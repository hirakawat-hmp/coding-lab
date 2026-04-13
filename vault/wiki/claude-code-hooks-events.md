---
type: reference
status: []
tags:
  - tool/claude-code
sources:
  - "[[raw/2026-04-06-claude-code-hooks-docs]]"
created: 2026-04-06
updated: 2026-04-06
---

# Claude Code Hooks — 全イベント詳細

[[wiki/claude-code-hooks]] の各イベントの入出力仕様をまとめたリファレンス。

## SessionStart

セッション開始時に実行。環境セットアップに使う。

- **マッチャー:** `startup`（新規）, `resume`（再開）, `clear`（クリア後）, `compact`（コンパクション後）
- **入力:** `source`, `model`, オプションで `agent_type`
- **ブロック:** 不可
- **典型的用途:** 環境変数設定、外部リソース同期

```bash
#!/bin/bash
# CLAUDE_ENV_FILE に書き込むと Claude Code の環境変数になる
if [ -n "$CLAUDE_ENV_FILE" ]; then
  echo 'export NODE_ENV=production' >> "$CLAUDE_ENV_FILE"
fi
exit 0
```

## SessionEnd

セッション終了時に実行。クリーンアップに使う。

- **マッチャー:** `clear`, `logout`, `prompt_input_exit`
- **入力:** exit reason
- **ブロック:** 不可
- **典型的用途:** 状態の保存、リソースの解放

## UserPromptSubmit

ユーザーがプロンプトを送信し、Claude が処理する前に実行。入力バリデーションに使う。

- **入力:** `prompt`（テキスト）
- **ブロック:** 可（`decision: "block"` で送信を阻止）
- **典型的用途:** 機密情報を含むプロンプトのブロック、入力のサニタイズ

```json
{
  "decision": "block",
  "reason": "パスワードを含むプロンプトはブロックされます"
}
```

## PreToolUse

最も重要なフック。Claude がツールパラメータを生成した後、実行前に介入。

- **マッチャー:** ツール名（`Bash`, `Edit`, `Write`, `Read`, `Glob`, `Grep`, `Agent`, `WebFetch`, `WebSearch`, `AskUserQuestion`, MCP ツール）
- **入力:** `tool_name`, `tool_input`（ツール固有）, `tool_use_id`
- **ブロック:** 可
- **判定:** `allow` / `deny` / `ask` / `defer`

### ツール入力スキーマ

**Bash:**
```json
{ "command": "npm test", "description": "テスト実行", "timeout": 120000, "run_in_background": false }
```

**Write:**
```json
{ "file_path": "/path/to/file.txt", "content": "ファイル内容" }
```

**Edit:**
```json
{ "file_path": "/path/to/file.txt", "old_string": "検索文字列", "new_string": "置換文字列", "replace_all": false }
```

**Read:**
```json
{ "file_path": "/path/to/file.txt", "offset": 10, "limit": 50 }
```

**Glob:**
```json
{ "pattern": "**/*.ts", "path": "/path/to/dir" }
```

**Grep:**
```json
{ "pattern": "TODO.*fix", "path": "/dir", "glob": "*.ts", "output_mode": "content", "-i": true }
```

**Agent:**
```json
{ "prompt": "APIエンドポイントを探して", "subagent_type": "Explore", "model": "sonnet" }
```

### updatedInput による入力書き換え

PreToolUse は `updatedInput` でツール入力を書き換え可能。RTK リライトはこれを活用している。

```json
{
  "hookSpecificOutput": {
    "hookEventName": "PreToolUse",
    "permissionDecision": "allow",
    "updatedInput": { "command": "rtk git status" }
  }
}
```

### defer（一時停止）

SDK 連携で使用。ツール実行を一時停止し、呼び出し元に `stop_reason: "tool_deferred"` と `deferred_tool_use` を返す。

## PermissionRequest

権限ダイアログが表示される直前に実行。権限の自動付与や入力の書き換えに使う。

- **入力:** `tool_name`, `tool_input`, オプションで `permission_suggestions`
- **ブロック:** 可
- **判定:** `behavior: "allow" | "deny"`

```json
{
  "hookSpecificOutput": {
    "hookEventName": "PermissionRequest",
    "decision": {
      "behavior": "allow",
      "updatedInput": { "command": "npm run lint" },
      "updatedPermissions": [
        {
          "type": "addRules",
          "rules": [{ "toolName": "Bash", "ruleContent": "npm run *" }],
          "behavior": "allow",
          "destination": "session"
        }
      ]
    }
  }
}
```

`updatedPermissions` の `type`:
- `addRules` / `replaceRules` / `removeRules` — ルール操作
- `setMode` — パーミッションモード変更
- `addDirectories` / `removeDirectories` — ディレクトリ操作

`destination`: `session` / `localSettings` / `projectSettings` / `userSettings`

## PostToolUse

ツール実行成功後に実行。ログやコンテキスト追加に使う。

- **入力:** `tool_input`, `tool_response`, `tool_use_id`
- **ブロック:** 不可（すでに実行済み）
- **出力:** `additionalContext`（Claude へのコンテキスト）, `updatedMCPToolOutput`（MCP ツールのみ）

## PostToolUseFailure

ツール実行失敗後に実行。

- **入力:** `tool_input`, `tool_use_id`, `error`, オプションで `is_interrupt`
- **ブロック:** 不可
- **出力:** `additionalContext`

## PermissionDenied

Auto モードの分類器がツール呼び出しを拒否した際に実行。

- **入力:** `tool_name`, `tool_input`, `tool_use_id`, `reason`
- **ブロック:** 不可
- **出力:** `retry: true` でリトライを許可

## Stop

Claude が応答を完了した際に実行。応答の検証や追加処理に使う。

- **入力:** `stop_reason`（文字列またはオブジェクト）
- **ブロック:** 可（`decision: "block"` で応答をやり直し）

## SubagentStart / SubagentStop

サブエージェントの起動/終了時。

- **マッチャー:** エージェントタイプ名（`Bash`, `Explore`, `Plan`, カスタム名）
- **Start 入力:** `agent_id`, `agent_type`
- **Stop 入力:** + `agent_transcript_path`, `last_assistant_message`
- **Start ブロック:** 不可（`additionalContext` でコンテキスト注入可能）
- **Stop ブロック:** 可

## TaskCreated / TaskCompleted

TaskCreate ツールでタスクが作成/完了された際に実行。

- **入力:** `task_id`, `task_subject`, オプションで `task_description`, `teammate_name`, `team_name`
- **ブロック:** 可（exit 2 でタスク作成/完了を阻止）
- **特殊:** `{"continue": false, "stopReason": "..."}` でチームメイトを停止

## FileChanged

監視ファイルがディスク上で変更された際に実行。

- **マッチャー:** ファイル名（basename）。例: `.env`, `package.json`
- **入力:** `file_path`, `change_type`
- **ブロック:** 不可
- **注意:** matcher で監視対象ファイルを指定する必要がある

## CwdChanged

作業ディレクトリが変更された際に実行。

- **入力:** `old_cwd`, `new_cwd`
- **ブロック:** 不可
- **特殊:** `CLAUDE_ENV_FILE` が利用可能。新しいディレクトリに応じた環境変数を設定できる

## InstructionsLoaded

CLAUDE.md や `.claude/rules/*.md` がロードされた際に実行。コンプライアンス監査に使う。

- **マッチャー:** `load_reason`（`session_start`, `nested_traversal`, `path_glob_match`, `include`, `compact`）
- **入力:** `file_path`, `memory_type`, `load_reason`, オプションで `globs`, `trigger_file_path`, `parent_file_path`
- **ブロック:** 不可

## ConfigChange

セッション中に設定ファイルが変更された際に実行。

- **マッチャー:** `user_settings`, `project_settings`, `local_settings`, `policy_settings`, `skills`
- **ブロック:** 可（ただし `policy_settings` はブロック不可）

## Notification

Claude Code が通知を送信する際に実行。

- **マッチャー:** `permission_prompt`, `idle_prompt`, `auth_success`, `elicitation_dialog`
- **入力:** `message`, オプションで `title`, `notification_type`
- **ブロック:** 不可
- **出力:** `additionalContext`

## WorktreeCreate / WorktreeRemove

ワークツリーの作成/削除時に実行。

- **Create ブロック:** 可（非ゼロ終了で作成を阻止）
- **Remove ブロック:** 不可
- **Create 出力:** stdout にパスを出力、または `hookSpecificOutput.worktreePath` で返す

## PreCompact / PostCompact

コンテキストコンパクションの前後に実行。

- **マッチャー:** `manual`, `auto`
- **ブロック:** 不可
- **典型的用途:** PostCompact でコンテキストの再注入

## Elicitation / ElicitationResult

MCP サーバーがユーザー入力を要求した際/ユーザーが応答した際に実行。

- **マッチャー:** MCP サーバー名
- **Elicitation 入力:** `server_name`, `form_schema`
- **ブロック:** 可
- **判定:** `action: "accept" | "decline" | "cancel"`、オプションで `content`

## 関連ページ

- [[wiki/claude-code-hooks]] — フックシステム概要
- [[wiki/claude-code-hooks-patterns]] — 実用パターン集
