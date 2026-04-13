---
url: "https://code.claude.com/docs/en/hooks"
title: "Claude Code Hooks — Official Documentation"
date_fetched: 2026-04-06
---

# Claude Code Hooks — Official Documentation

## Overview

Hooks are user-defined shell commands, HTTP endpoints, LLM prompts, or agents that execute automatically at specific points in Claude Code's lifecycle. They enable automation, validation, and integration with external systems.

## Hook Lifecycle

```
SessionStart → UserPromptSubmit → PreToolUse → PermissionRequest → PostToolUse → Stop → SessionEnd
```

Plus async events: Notification, SubagentStart/Stop, TaskCreated/Completed, FileChanged, CwdChanged, WorktreeCreate/Remove, InstructionsLoaded, ConfigChange, PreCompact/PostCompact, Elicitation/ElicitationResult

## Hook Configuration Levels

| Location | Scope | Shareable |
|----------|-------|-----------|
| `~/.claude/settings.json` | All projects | No |
| `.claude/settings.json` | Single project | Yes |
| `.claude/settings.local.json` | Single project | No |
| Managed policy | Organization-wide | Yes |
| Plugin `hooks/hooks.json` | When enabled | Yes |
| Skill/Agent frontmatter | While active | Yes |

## Hook Handler Types

### 1. Command Hooks
- Input: JSON on stdin
- Output: exit code (0=success, 2=blocking error, other=non-blocking)
- JSON output on stdout (exit 0 only)
- Environment variables: $CLAUDE_PROJECT_DIR, ${CLAUDE_PLUGIN_ROOT}, ${CLAUDE_PLUGIN_DATA}

### 2. HTTP Hooks
- Input: JSON as POST body
- Output: 2xx with JSON response
- Error handling: non-2xx/timeout = non-blocking error

### 3. Prompt Hooks
- Single-turn evaluation
- Returns yes/no decision as JSON

### 4. Agent Hooks
- Spawns subagent with tool access (Read, Grep, Glob)

## Common Hook Fields

| Field | Required | Description |
|-------|----------|-------------|
| type | yes | "command", "http", "prompt", "agent" |
| if | no | Permission rule to narrow execution (tool events only) |
| timeout | no | Seconds before cancel (defaults: 600/30/60) |
| statusMessage | no | Custom spinner message |
| once | no | Run only once per session (skills only) |

## Matcher Patterns

| Event | Matches | Examples |
|-------|---------|----------|
| Tool events | Tool name | Bash, Edit|Write, mcp__memory__.* |
| SessionStart | Session source | startup, resume, clear, compact |
| SessionEnd | Exit reason | clear, logout, prompt_input_exit |
| Notification | Type | permission_prompt, idle_prompt, auth_success |
| SubagentStart/Stop | Agent type | Bash, Explore, Plan |
| FileChanged | Filename | .env, .envrc, package.json |
| ConfigChange | Config source | user_settings, project_settings |

## Exit Code Protocol

| Exit Code | Meaning |
|-----------|---------|
| 0 | Success - parse JSON stdout |
| 2 | Blocking error - stderr feedback, event-specific action |
| Other | Non-blocking error - stderr in verbose mode |

## Hook Events (全25種)

1. SessionStart - セッション開始/再開
2. SessionEnd - セッション終了
3. UserPromptSubmit - ユーザープロンプト送信前
4. PreToolUse - ツール実行前
5. PermissionRequest - 権限ダイアログ表示前
6. PostToolUse - ツール実行成功後
7. PostToolUseFailure - ツール実行失敗後
8. PermissionDenied - Auto モード分類器が拒否
9. Stop - Claude 応答完了
10. SubagentStart - サブエージェント起動
11. SubagentStop - サブエージェント終了
12. TaskCreated - タスク作成
13. TaskCompleted - タスク完了
14. FileChanged - ファイル変更検知
15. CwdChanged - 作業ディレクトリ変更
16. InstructionsLoaded - CLAUDE.md/rules ロード
17. ConfigChange - 設定変更
18. Notification - 通知送信
19. WorktreeCreate - ワークツリー作成
20. WorktreeRemove - ワークツリー削除
21. PreCompact - コンパクション前
22. PostCompact - コンパクション後
23. Elicitation - MCP エリシテーション要求
24. ElicitationResult - MCP エリシテーション応答

## PreToolUse permissionDecision values

- allow: 許可（権限ダイアログスキップ）
- deny: 拒否（ツール実行しない）
- ask: 権限ダイアログを表示
- defer: 一時停止して呼び出し元に制御を返す

## PermissionRequest decision

- behavior: allow | deny
- updatedInput: 入力パラメータの上書き
- updatedPermissions: 権限ルールの動的変更

## Tool Input Schemas

### Bash
command, description, timeout, run_in_background

### Write
file_path, content

### Edit
file_path, old_string, new_string, replace_all

### Read
file_path, offset, limit

### Glob
pattern, path

### Grep
pattern, path, glob, output_mode, -i, multiline

### Agent
prompt, description, subagent_type, model

### AskUserQuestion
questions (array), answers (object)
