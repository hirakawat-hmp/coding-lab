---
tags:
  - concept
sources:
  - "[[raw/2026-04-06-claude-code-hooks-docs]]"
  - "[[raw/2026-04-06-claude-code-hooks-impl]]"
created: 2026-04-06
updated: 2026-04-06
---

# Claude Code Hooks

Claude Code のライフサイクルの特定ポイントで自動実行されるユーザー定義ハンドラ。シェルコマンド、HTTP エンドポイント、LLM プロンプト、またはエージェントとして実装できる。

## ライフサイクル概要

```
SessionStart → UserPromptSubmit → PreToolUse → PermissionRequest
    → PostToolUse → Stop → SessionEnd
```

加えて非同期イベント: Notification, SubagentStart/Stop, TaskCreated/Completed, FileChanged, CwdChanged, WorktreeCreate/Remove, InstructionsLoaded, ConfigChange, PreCompact/PostCompact, Elicitation/ElicitationResult

## 設定の3層構造

```json
{
  "hooks": {
    "HookEventName": [        // 1. フックイベント
      {
        "matcher": "Bash",    // 2. マッチャーグループ（フィルタ）
        "hooks": [            // 3. ハンドラ配列
          {
            "type": "command",
            "command": "script.sh"
          }
        ]
      }
    ]
  }
}
```

## 設定ファイルの配置場所

| 場所 | スコープ | チーム共有 |
|------|---------|-----------|
| `~/.claude/settings.json` | 全プロジェクト | 不可 |
| `.claude/settings.json` | プロジェクト単位 | 可 |
| `.claude/settings.local.json` | プロジェクトローカル | 不可 |
| Managed policy | 組織全体 | 可 |
| Plugin `hooks/hooks.json` | プラグイン有効時 | 可 |
| Skill/Agent フロントマター | スキル実行中のみ | 可 |

## ハンドラタイプ

### 1. Command（シェルコマンド）

最も一般的。stdin で JSON 入力を受け取り、stdout で JSON 出力を返す。

```json
{
  "type": "command",
  "command": "$HOME/.claude/hooks/my-hook.sh",
  "async": false,
  "shell": "bash",
  "timeout": 600,
  "if": "Bash(git *)",
  "statusMessage": "検証中..."
}
```

**終了コードプロトコル:**

| 終了コード | 意味 |
|-----------|------|
| 0 | 成功 — stdout の JSON をパース |
| 2 | ブロッキングエラー — イベント固有のアクション実行 |
| その他 | 非ブロッキングエラー — verbose モードで stderr 表示 |

### 2. HTTP（Webhook）

外部サービスへの POST リクエスト。レスポンスは JSON。

```json
{
  "type": "http",
  "url": "http://localhost:8080/hook",
  "timeout": 30,
  "headers": { "Authorization": "Bearer $MY_TOKEN" },
  "allowedEnvVars": ["MY_TOKEN"]
}
```

### 3. Prompt（LLM 評価）

単一ターンの LLM 評価。yes/no 判定を返す。

```json
{
  "type": "prompt",
  "prompt": "このツール呼び出しを許可すべきか？ Context: $ARGUMENTS",
  "model": "fast-model",
  "timeout": 30
}
```

### 4. Agent（サブエージェント）

ツールアクセス付きのサブエージェントを起動。Read, Grep, Glob が使える。

```json
{
  "type": "agent",
  "prompt": "このデプロイの安全性を検証してください",
  "timeout": 60
}
```

## 共通フィールド

| フィールド | 必須 | 説明 |
|-----------|-----|------|
| `type` | はい | `"command"`, `"http"`, `"prompt"`, `"agent"` |
| `if` | いいえ | パーミッションルール形式のフィルタ（ツールイベントのみ） |
| `timeout` | いいえ | 秒数。デフォルト: command=600, http=30, agent=60 |
| `statusMessage` | いいえ | スピナーのカスタムメッセージ |
| `once` | いいえ | セッション中1回だけ実行（スキル専用） |
| `async` | いいえ | 非同期実行。ログ系に便利 |

## 環境変数

フック内で利用可能な環境変数:

- `$CLAUDE_PROJECT_DIR` — プロジェクトルート
- `${CLAUDE_PLUGIN_ROOT}` — プラグインのインストールディレクトリ
- `${CLAUDE_PLUGIN_DATA}` — プラグインの永続データ
- `$CLAUDE_ENV_FILE` — SessionStart/CwdChanged で環境変数を書き込むファイル

## 全フックイベント一覧

全25種のイベントを網羅。詳細は [[wiki/claude-code-hooks-events]] を参照。

### コアライフサイクル

| イベント | タイミング | ブロック可能 | マッチャー |
|---------|-----------|-------------|-----------|
| **SessionStart** | セッション開始/再開 | 不可 | `startup`, `resume`, `clear`, `compact` |
| **SessionEnd** | セッション終了 | 不可 | `clear`, `logout`, `prompt_input_exit` |
| **UserPromptSubmit** | プロンプト送信前 | 可 | なし |
| **Stop** | Claude 応答完了 | 可 | なし |

### ツール関連

| イベント | タイミング | ブロック可能 | マッチャー |
|---------|-----------|-------------|-----------|
| **PreToolUse** | ツール実行前 | 可 | ツール名（正規表現） |
| **PermissionRequest** | 権限ダイアログ表示前 | 可 | ツール名 |
| **PostToolUse** | ツール実行成功後 | 不可 | ツール名 |
| **PostToolUseFailure** | ツール実行失敗後 | 不可 | ツール名 |
| **PermissionDenied** | Auto モードで拒否 | 不可 | ツール名 |

### サブエージェント・タスク

| イベント | タイミング | ブロック可能 | マッチャー |
|---------|-----------|-------------|-----------|
| **SubagentStart** | サブエージェント起動 | 不可 | エージェントタイプ名 |
| **SubagentStop** | サブエージェント終了 | 可 | エージェントタイプ名 |
| **TaskCreated** | TaskCreate ツールでタスク作成 | 可 | なし |
| **TaskCompleted** | タスク完了 | 可 | なし |

### ファイル・設定

| イベント | タイミング | ブロック可能 | マッチャー |
|---------|-----------|-------------|-----------|
| **FileChanged** | 監視ファイルの変更 | 不可 | ファイル名（basename） |
| **CwdChanged** | 作業ディレクトリ変更 | 不可 | なし |
| **InstructionsLoaded** | CLAUDE.md/rules ロード | 不可 | `session_start`, `compact`, etc. |
| **ConfigChange** | 設定ファイル変更 | 可 | `user_settings`, `project_settings`, etc. |

### コンパクション

| イベント | タイミング | ブロック可能 | マッチャー |
|---------|-----------|-------------|-----------|
| **PreCompact** | コンパクション前 | 不可 | `manual`, `auto` |
| **PostCompact** | コンパクション後 | 不可 | `manual`, `auto` |

### ワークツリー

| イベント | タイミング | ブロック可能 | マッチャー |
|---------|-----------|-------------|-----------|
| **WorktreeCreate** | ワークツリー作成 | 可 | なし |
| **WorktreeRemove** | ワークツリー削除 | 不可 | なし |

### 通知・MCP

| イベント | タイミング | ブロック可能 | マッチャー |
|---------|-----------|-------------|-----------|
| **Notification** | 通知送信 | 不可 | `permission_prompt`, `idle_prompt`, etc. |
| **Elicitation** | MCP エリシテーション要求 | 可 | MCP サーバー名 |
| **ElicitationResult** | MCP エリシテーション応答 | 可 | MCP サーバー名 |

## マッチャーパターン

正規表現で対象を絞り込む。省略または `"*"` で全マッチ。

```json
{ "matcher": "Bash" }              // Bash ツールのみ
{ "matcher": "Edit|Write" }        // Edit または Write
{ "matcher": "mcp__memory__.*" }   // memory MCP サーバーの全ツール
```

MCP ツールの命名規則: `mcp__<server>__<tool>`

## PreToolUse の permissionDecision

最も強力なフック。ツール実行の許可/拒否/入力の書き換えが可能。

```json
{
  "hookSpecificOutput": {
    "hookEventName": "PreToolUse",
    "permissionDecision": "allow",
    "permissionDecisionReason": "理由",
    "updatedInput": { "command": "書き換えたコマンド" },
    "additionalContext": "Claude に伝えるコンテキスト"
  }
}
```

| 値 | 動作 |
|----|------|
| `allow` | 権限ダイアログをスキップして実行 |
| `deny` | ツール実行を拒否 |
| `ask` | 権限ダイアログを表示 |
| `defer` | 一時停止して呼び出し元に制御を返す（SDK連携用） |

## 共通入力フィールド

全フックが stdin/POST で受け取る JSON:

```json
{
  "session_id": "abc123",
  "transcript_path": "/path/to/transcript.jsonl",
  "cwd": "/current/directory",
  "permission_mode": "default|plan|acceptEdits|auto|dontAsk|bypassPermissions",
  "hook_event_name": "PreToolUse",
  "agent_id": "agent-xyz",
  "agent_type": "AgentName"
}
```

## 実用パターン

具体的な実装例は [[wiki/claude-code-hooks-patterns]] を参照。主要なパターン:

1. **危険コマンドブロック** — rm -rf /, curl | bash, sudo を exit 2 でブロック
2. **RTK リライト** — コマンドを rtk 経由に書き換えてトークン節約
3. **Vault 自動同期** — SessionStart で git pull + qmd update、SessionEnd で commit + push
4. **コンテキスト再注入** — PostCompact で重要なコンテキストを再注入
5. **ツール使用ログ** — PostToolUse を async で全ツール使用をログ
6. **セーフコマンド自動承認** — `if` フィールドで npm test, lint 等を自動許可

## 制限事項

- 出力は **10,000文字** が上限（超過分は切り捨て）
- SessionStart はセッション開始のたびに実行されるため**高速であること**が重要
- `async: true` のフックは結果を待たない（ログ/監視向け）
- シェルプロファイルが起動時に出力を行うと JSON パースに失敗する
- `if` フィールドはツールイベントでのみ使用可能
- 同一の command/URL は自動で重複排除される
- `/hooks` コマンドで全設定フックを読み取り専用で確認可能
- `disableAllHooks: true` で全フックを無効化可能

## 関連ページ

- [[wiki/claude-code-hooks-events]] — 各イベントの詳細仕様
- [[wiki/claude-code-hooks-patterns]] — 実用的な実装パターン集
- [[wiki/rtk]] — RTK（Rust Token Killer）コマンドリライトツール
- [[wiki/dev-environment-architecture]] — hooks の配置を含む開発環境設計
