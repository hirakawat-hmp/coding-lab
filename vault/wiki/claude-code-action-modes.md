---
type: reference
status: [verified]
tags:
  - tool/claude-code-action
  - infra/ci-cd
sources:
  - "https://deepwiki.com/anthropics/claude-code-action/3.1-execution-modes"
  - "https://deepwiki.com/anthropics/claude-code-action/1-overview"
  - "https://github.com/anthropics/claude-code-action/blob/main/docs/migration-guide.md"
created: 2026-04-10
updated: 2026-04-10
---

# Claude Code Action: Tag Mode と Agent Mode

`anthropics/claude-code-action@v1` には2種類の実行モードがある。v1 以降はモードの **自動検出** が行われ、手動設定は不要になった。

## モード検出ロジック

以下の優先順位でモードが自動決定される:

1. `track_progress: true` が設定されている → Tag Mode 強制
2. `prompt` 入力が存在する → **Agent Mode**
3. GitHub イベントにトリガーフレーズが含まれる → **Tag Mode**
4. いずれにも該当しない → 実行なし

## Tag Mode（インタラクティブモード）

### 概要

開発者からの対話的なリクエストに応答するモード。PR・Issue での `@claude` メンションに反応し、リアルタイムでフィードバックを提供する。

### トリガー条件

- Issue / PR コメントへの `@claude` メンション（デフォルトのトリガーフレーズ）
- Issue のアサイン（`assignee_trigger` で設定）
- ラベルの付与（`label_trigger` で設定）

### 動作の特徴

- **進捗トラッキングコメント**: タスクのチェックリストを更新しながらリアルタイムで進捗を報告
- **自動ブランチ管理**: 変更を `claude/` プレフィックスのブランチに自動プッシュ
- **コンテキスト自動収集**: PR の diff、コメント履歴、CI ステータスを自動的に取得
- **豊富なデフォルトツール**: ファイル操作、GitHub API ツール、CI 連携ツールを標準で利用可能

### デフォルト利用可能ツール

| カテゴリ | ツール |
|---|---|
| ファイル操作 | `Glob`, `Grep`, `LS`, `Read` |
| ファイル編集 | `Edit`, `MultiEdit`, `Write`（`--permission-mode acceptEdits` 経由） |
| コメント管理 | `mcp__github_comment__update_claude_comment` |
| CI 連携 | `mcp__github_ci__get_ci_status`, `mcp__github_ci__get_workflow_run_details` |
| Git 操作 | `Bash(git add:*)`, `Bash(git commit:*)`, `Bash(git push:*)` |

**注意**: `WebSearch` と `WebFetch` はデフォルトで **無効**。有効化には明示的な設定が必要。

### ユースケース

- コードレビューの依頼（`@claude このコードをレビューして`）
- バグ修正の依頼（`@claude この TypeError を修正して`）
- 機能実装の依頼（`@claude このユーザー認証機能を実装して`）
- 質問への回答（`@claude この API の使い方は?`）

## Agent Mode（自動化モード）

### 概要

人間の介入なしに実行される自動化タスク向けのモード。スケジュール実行や CI/CD パイプラインに最適。

### トリガー条件

- ワークフロー YAML の `prompt` 入力に値がある場合
- `workflow_dispatch`、`schedule`、`repository_dispatch` などの自動化イベント

### 動作の特徴

- **サイレント実行**: 進捗コメントを投稿せず、GitHub Step Summary にのみ出力
- **現在のブランチで動作**: 自動ブランチ作成なし（チェックアウトされたブランチで実行）
- **最小限のツールセット**: `--allowedTools` で明示的に許可したツールのみ利用可能
- **高いセキュリティ制御**: 不要なツールへのアクセスを最小化

### ユースケース

- 日次ダイジェスト生成
- スケジュールされたコードベース分析
- イベント駆動の PR サマリー
- CI 統合によるリントや修正

## 設定比較

| 設定項目 | Tag Mode | Agent Mode |
|---|---|---|
| `prompt` パラメータ | 不要（省略可能） | 必須（モードの判定条件） |
| ユーザーへのフィードバック | 進捗コメントをリアルタイム更新 | GitHub Step Summary のみ |
| ブランチ管理 | `claude/` ブランチを自動作成 | 現在のブランチで動作 |
| コンテキスト取得 | PR diff、コメント履歴を自動収集 | 環境変数と手動ファイル読み取り |
| デフォルトツールセット | 豊富なデフォルトツール | 明示的に許可したツールのみ |

## 移行ガイド（Beta → v1）

旧 beta 版から v1 への主な変更点:

| 旧 Beta 設定 | v1 での対応 |
|---|---|
| `mode: "tag"` | 削除（自動検出） |
| `mode: "agent"` | 削除（自動検出） |
| `direct_prompt` | `prompt` に変更 |
| `custom_instructions` | `claude_args: --append-system-prompt` |
| `max_turns` | `claude_args: --max-turns` |
| `model` | `claude_args: --model` |
| `allowed_tools` | `claude_args: --allowedTools` |
| `disallowed_tools` | `claude_args: --disallowedTools` |

### Before（Beta）

```yaml
- uses: anthropics/claude-code-action@beta
  with:
    mode: "tag"
    direct_prompt: "セキュリティ問題の PR レビュー"
    anthropic_api_key: ${{ secrets.ANTHROPIC_API_KEY }}
    custom_instructions: "コーディング規約に従うこと"
    max_turns: "10"
    model: "claude-sonnet-4-6"
```

### After（v1）

```yaml
- uses: anthropics/claude-code-action@v1
  with:
    prompt: "セキュリティ問題の PR レビュー"
    anthropic_api_key: ${{ secrets.ANTHROPIC_API_KEY }}
    claude_args: |
      --append-system-prompt "コーディング規約に従うこと"
      --max-turns 10
      --model claude-sonnet-4-6
```

## 関連ページ

- [[wiki/claude-code-github-actions]] — GitHub Actions 全体の概要
- [[wiki/claude-code-action-tools]] — allowedTools と WebSearch/WebFetch の設定
- [[wiki/claude-code-auto-merge]] — auto-merge 設計パターン
- [[wiki/knowledge-vault-lessons]] — Tag mode と prompt 指定に関する実運用の知見
