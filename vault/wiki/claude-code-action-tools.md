---
type: reference
status: [verified]
tags:
  - tool/claude-code-action
  - infra/ci-cd
sources:
  - "https://deepwiki.com/anthropics/claude-code-action/5.3-tool-and-permission-configuration"
  - "https://github.com/anthropics/claude-code-action/blob/main/docs/configuration.md"
  - "https://github.com/anthropics/claude-code-action/issues/690"
created: 2026-04-10
updated: 2026-04-10
---

# Claude Code Action: ツールと権限の設定

`anthropics/claude-code-action@v1` のツールアクセス制御と権限設定の詳細。

## ツール命名規則

ツールは階層的な命名パターンに従っており、パターンベースのフィルタリングが可能:

| 種類 | 形式 | 例 |
|---|---|---|
| 組み込みツール | `<ToolName>` | `Glob`, `Read`, `Edit` |
| Bash コマンド | `Bash(<command>:*)` | `Bash(git add:*)`, `Bash(npm run test:*)` |
| MCP ツール | `mcp__<server>__<action>` | `mcp__github__create_issue` |

MCP ツールはプレフィックスで一括許可が可能: `mcp__github__*` と指定すると GitHub MCP サーバーの全ツールが許可される。

## allowedTools の設定方法

### `claude_args` を使った設定（推奨）

```yaml
- uses: anthropics/claude-code-action@v1
  with:
    anthropic_api_key: ${{ secrets.ANTHROPIC_API_KEY }}
    claude_args: |
      --allowedTools "Bash(npm install),Bash(npm run test),Edit,MultiEdit,Read,Write"
      --disallowedTools "TaskOutput"
```

### `settings` JSON を使った設定

```yaml
- uses: anthropics/claude-code-action@v1
  with:
    anthropic_api_key: ${{ secrets.ANTHROPIC_API_KEY }}
    settings: |
      {
        "permissions": {
          "allow": ["Bash", "Read", "Edit"],
          "deny": ["WebFetch"]
        }
      }
```

### 特定コマンドのみを許可する例

```yaml
claude_args: |
  --allowedTools "Bash(npm run test:*),Bash(npm run lint:*),Read,Edit"
```

ワイルドカード `*` を使って特定のコマンドプレフィックスのみを許可できる。

## WebSearch / WebFetch の有効化

### デフォルト動作

セキュリティ上の理由から、Web アクセスツールはデフォルトで **無効**:

- `WebSearch` — デフォルト無効
- `WebFetch` — デフォルト無効

### 有効化方法 1: `claude_args` での明示的許可

```yaml
- uses: anthropics/claude-code-action@v1
  with:
    anthropic_api_key: ${{ secrets.ANTHROPIC_API_KEY }}
    claude_args: |
      --allowedTools "Bash,Edit,MultiEdit,Read,Write,WebFetch,WebSearch"
      --permission-mode acceptEdits
```

### 有効化方法 2: `settings` JSON の permissions で許可

```yaml
- uses: anthropics/claude-code-action@v1
  with:
    anthropic_api_key: ${{ secrets.ANTHROPIC_API_KEY }}
    settings: |
      {
        "permissions": {
          "allow": ["WebSearch", "WebFetch"],
          "deny": []
        }
      }
```

### 既知の問題と修正（Issue #690）

**問題**: v1 初期バージョンで `claude_args` の `--allowedTools` に `WebSearch`/`WebFetch` を指定しても、`DISALLOWED_TOOLS` 環境変数で無効化されてしまうバグがあった。

**原因**: `parseAllowedTools()` でパースされた値が `buildDisallowedToolsString()` に渡されず、ユーザー指定の許可リストが反映されなかった。

**修正**: PR #1033 で修正済み。現在は `--allowedTools` で明示的に指定すると、デフォルトの無効化設定が正しくオーバーライドされる。

## セキュリティモデル

### 2層防御

1. **MCP サーバー層**: コンテキストや権限に基づいて条件付きで MCP サーバーを設定に含める
2. **ツール層**: 個別ツールへのアクセスには明示的な許可が必要

### Tag Mode のデフォルトツールセット

Tag Mode では以下のツールが事前設定されている:

| カテゴリ | ツール |
|---|---|
| 読み取り系 | `Glob`, `Grep`, `LS`, `Read` |
| コメント管理 | `mcp__github_comment__update_claude_comment` |
| CI 連携 | `mcp__github_ci__get_ci_status`, `mcp__github_ci__get_workflow_run_details`, `mcp__github_ci__download_job_log` |
| Git 操作（署名なし） | `Bash(git add:*)`, `Bash(git commit:*)`, `Bash(git push:*)` |
| ファイル操作（API 署名付き） | `mcp__github_file_ops__commit_files`, `mcp__github_file_ops__delete_files` |

**注意**: `Edit`、`MultiEdit`、`Write` は明示的な許可リストには含まれないが、`--permission-mode acceptEdits` により workspace 内の編集は自動許可される。

### Agent Mode のツール設定

Agent Mode では最小権限の原則に従い、`--allowedTools` または `allowed_tools` で明示的に指定されたツールのみが利用可能。

## CI/CD 権限の設定

GitHub Actions ログや CI ステータスへのアクセスには追加権限が必要:

```yaml
permissions:
  contents: write
  pull-requests: write
  issues: write
  actions: read  # CI アクセスに必要

jobs:
  claude:
    steps:
      - uses: anthropics/claude-code-action@v1
        with:
          additional_permissions: |
            actions: read
```

利用可能な CI/CD MCP ツール:
- `mcp__github_ci__get_ci_status` — ワークフロー実行ステータスの確認
- `mcp__github_ci__get_workflow_run_details` — 詳細なワークフロー情報の取得
- `mcp__github_ci__download_job_log` — ジョブログのダウンロードと分析

## 環境変数の設定

```yaml
settings: |
  {
    "env": {
      "NODE_ENV": "test",
      "CI": "true",
      "DATABASE_URL": "postgres://test:test@localhost:5432/test_db"
    }
  }
```

## MCP サーバーの追加設定

カスタム MCP サーバーを `--mcp-config` で追加できる:

```yaml
claude_args: |
  --mcp-config '{
    "mcpServers": {
      "sequential-thinking": {
        "command": "npx",
        "args": ["-y", "@modelcontextprotocol/server-sequential-thinking"]
      }
    }
  }'
  --allowedTools mcp__sequential-thinking__sequentialthinking
```

## 関連ページ

- [[wiki/claude-code-github-actions]] — GitHub Actions 全体の概要
- [[wiki/claude-code-action-modes]] — Tag Mode と Agent Mode の比較
- [[wiki/claude-code-auto-merge]] — auto-merge 設計パターン
- [[wiki/knowledge-vault-lessons]] — WebSearch/WebFetch 有効化のハマりどころ
