---
type: insight
status: []
tags:
  - tool/claude-code
  - dev/bash
sources:
  - "[[raw/2026-04-06-claude-code-hooks-docs]]"
  - "[[raw/2026-04-06-claude-code-hooks-impl]]"
created: 2026-04-06
updated: 2026-04-06
---

# Claude Code Hooks — 実用パターン集

[[wiki/claude-code-hooks]] の具体的な実装パターンをまとめたページ。実際の `claude-code-config` リポジトリの設定を含む。

## パターン1: 危険コマンドブロック

`block-dangerous.sh` で実装。PreToolUse (Bash) でコマンドを検査し、危険度に応じてブロックまたは警告する。

### ハードブロック（exit 2 — 常に拒否）

```bash
#!/bin/bash
input=$(cat)
cmd=$(echo "$input" | jq -r '.tool_input.command // empty')
[ -z "$cmd" ] && exit 0

block() {
  echo "{\"decision\":\"block\",\"reason\":\"$1\"}" >&2
  exit 2
}

# rm -rf on critical paths
echo "$cmd" | grep -qE '\brm\s+.*-[a-zA-Z]*[rf][a-zA-Z]*\s+(/\s|/\b|~/|~\b|\$HOME|/\*\b)' \
  && block "rm -rf on critical path is never allowed"

# Pipe remote content to shell (prompt injection vector)
echo "$cmd" | grep -qE '(curl|wget)\s.*\|\s*(bash|sh|zsh|python|node)' \
  && block "Piping remote content to shell is never allowed"

# Data exfiltration
echo "$cmd" | grep -qE '(curl|wget)\s.*(-d\s|--data|--upload-file|-T\s)' \
  && block "Sending data to external servers requires manual execution"

# sudo
echo "$cmd" | grep -qE '\bsudo\b' \
  && block "sudo is not allowed for AI agents"

# Disk destruction
echo "$cmd" | grep -qEi '\b(mkfs|diskutil\s+(erase|partitionDisk))\b' \
  && block "Disk format operations are never allowed"
```

### ソフト警告（exit 0 + stderr）

LLM は stderr のメッセージを見るが、実行は許可する。

```bash
warn() {
  echo "WARNING: $1" >&2
  exit 0
}

echo "$cmd" | grep -qE '\bgit\s+reset\s+--hard\b' \
  && warn "git reset --hard will discard all uncommitted changes"
echo "$cmd" | grep -qEi '\bgit\s+push\s+.*(-f\b|--force)\b' \
  && warn "git push --force can overwrite remote history"
echo "$cmd" | grep -qEi '\bDROP\s+(DATABASE|TABLE|SCHEMA)\b' \
  && warn "Database destructive operation: DROP detected"
echo "$cmd" | grep -qEi '\bterraform\s+destroy\b' \
  && warn "terraform destroy will tear down infrastructure"
```

ブロック対象と警告対象の設計判断:
- **ブロック**: 取り返しのつかない破壊、セキュリティ侵害、プロンプトインジェクション
- **警告**: 危険だが意図的な場合がある操作（git force push 等）

## パターン2: RTK コマンドリライト

[[wiki/rtk]] の `rtk rewrite` コマンドを使い、通常のコマンドを RTK プロキシ経由に透過的に書き換える。60-90% のトークン節約を実現。

```bash
#!/bin/bash
INPUT=$(cat)
CMD=$(echo "$INPUT" | jq -r '.tool_input.command // empty')
[ -z "$CMD" ] && exit 0

REWRITTEN=$(rtk rewrite "$CMD" 2>/dev/null)
EXIT_CODE=$?

case $EXIT_CODE in
  0) ;; # リライト成功
  1) exit 0 ;; # RTK 対象外 — パススルー
  2) exit 0 ;; # deny ルール — パススルー
  3) ;; # ask ルール — リライトするが確認を求める
  *) exit 0 ;;
esac

ORIGINAL_INPUT=$(echo "$INPUT" | jq -c '.tool_input')
UPDATED_INPUT=$(echo "$ORIGINAL_INPUT" | jq --arg cmd "$REWRITTEN" '.command = $cmd')

if [ "$EXIT_CODE" -eq 3 ]; then
  # permissionDecision を設定しない → 確認ダイアログ表示
  jq -n --argjson updated "$UPDATED_INPUT" \
    '{ "hookSpecificOutput": { "hookEventName": "PreToolUse", "updatedInput": $updated } }'
else
  # auto-allow
  jq -n --argjson updated "$UPDATED_INPUT" \
    '{ "hookSpecificOutput": { "hookEventName": "PreToolUse", "permissionDecision": "allow", "permissionDecisionReason": "RTK auto-rewrite", "updatedInput": $updated } }'
fi
```

**設計のポイント:**
- リライトロジックは全て Rust バイナリ側に委譲（Single Source of Truth）
- exit code でパーミッション制御を分離
- 同一コマンドの場合は何もしない（リライト済み判定）
- `rtk` や `jq` が未インストールの場合はフォールバック（exit 0）

## パターン3: Vault 自動同期

SessionStart/SessionEnd で vault リポジトリを自動同期。

```json
{
  "hooks": {
    "SessionStart": [{
      "hooks": [{
        "type": "command",
        "command": "cd ~/repos/vault && git pull --ff-only --quiet 2>/dev/null; eval \"$(mise activate bash 2>/dev/null)\" && qmd update --quiet 2>/dev/null; echo 'vault synced'"
      }]
    }],
    "SessionEnd": [{
      "hooks": [{
        "type": "command",
        "command": "cd ~/repos/vault && git add -A && git diff --cached --quiet || (git commit -m 'chore: auto-save vault changes' && git push) 2>/dev/null &"
      }]
    }]
  }
}
```

**設計のポイント:**
- `--ff-only` でコンフリクトを避ける
- `qmd update` で検索インデックスも更新
- SessionEnd は `&` でバックグラウンド実行（セッション終了をブロックしない）
- `2>/dev/null` でエラーを抑制（ネットワーク未接続時も安全）

## パターン4: コンテキスト再注入

PostCompact でコンパクション後に重要なコンテキストを再注入。

```json
{
  "hooks": {
    "PostCompact": [{
      "hooks": [{
        "type": "command",
        "command": "echo '{\"additionalContext\": \"重要: 現在のタスクは X。Y ファイルを編集中。\"}'"
      }]
    }]
  }
}
```

## パターン5: ツール使用ログ

PostToolUse を async で全ツール使用を外部にログ。

```json
{
  "hooks": {
    "PostToolUse": [{
      "matcher": ".*",
      "hooks": [{
        "type": "command",
        "command": "jq -r '[.hook_event_name, .tool_name] | @tsv' >> /tmp/claude-tool-log.tsv",
        "async": true
      }]
    }]
  }
}
```

## パターン6: セーフコマンド自動承認

`if` フィールドで安全なコマンドを自動承認。プロセス起動を避けるため `if` でフィルタリングするのがベストプラクティス。

```json
{
  "hooks": {
    "PreToolUse": [{
      "matcher": "Bash",
      "hooks": [{
        "type": "command",
        "if": "Bash(npm run lint|npm test|npx tsc --noEmit)",
        "command": "echo '{\"hookSpecificOutput\":{\"hookEventName\":\"PreToolUse\",\"permissionDecision\":\"allow\"}}'"
      }]
    }]
  }
}
```

## パターン7: ファイル変更の自動検知

特定ファイルの変更を監視して自動アクションを実行。

```json
{
  "hooks": {
    "FileChanged": [{
      "matcher": "package.json",
      "hooks": [{
        "type": "command",
        "command": "echo '{\"additionalContext\": \"package.json が変更されました。npm install が必要かもしれません。\"}'"
      }]
    }]
  }
}
```

## パターン8: MCP ツールの出力書き換え

PostToolUse で MCP ツールの出力を変換。`updatedMCPToolOutput` は MCP ツール専用。

```json
{
  "hooks": {
    "PostToolUse": [{
      "matcher": "mcp__database__query",
      "hooks": [{
        "type": "command",
        "command": "jq '{hookSpecificOutput: {hookEventName: \"PostToolUse\", updatedMCPToolOutput: (.tool_response | fromjson | .rows[:10] | tojson)}}'"
      }]
    }]
  }
}
```

## フック連鎖の設計

同一イベントに複数フックを設定した場合、**上から順に実行**される。前のフックが exit 2 でブロックすると後続は実行されない。

現在の `claude-code-config` の PreToolUse (Bash) の順序:

1. `block-dangerous.sh` — まず危険コマンドをブロック
2. `rtk-rewrite.sh` — ブロックされなかったコマンドを RTK でリライト

この順序は重要。RTK リライトの前に安全性を検証する。

## ベストプラクティス

1. **フックは高速に** — SessionStart は毎回実行される。重い処理はバックグラウンドで
2. **`if` フィールドを活用** — プロセス起動を減らす。正規表現パターンで事前フィルタ
3. **ログは `async: true`** — ブロッキングしない
4. **フォールバックを設計** — ツール未インストール時は exit 0 で安全にパススルー
5. **stderr は LLM に見える** — 警告メッセージは LLM の判断に影響する
6. **シェルプロファイルに注意** — .bashrc の出力が JSON パースを壊す場合がある

## 関連ページ

- [[wiki/claude-code-hooks]] — フックシステム概要
- [[wiki/claude-code-hooks-events]] — 各イベント詳細
- [[wiki/rtk]] — Rust Token Killer
- [[wiki/dev-environment-architecture]] — hooks の配置
