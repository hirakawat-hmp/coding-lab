---
url: "local://claude-code-config/hooks/"
title: "Claude Code Hooks 実装例 — block-dangerous.sh + rtk-rewrite.sh"
date_fetched: 2026-04-06
---

# Claude Code Hooks 実装例

## settings.json のフック設定

```json
{
  "hooks": {
    "SessionStart": [
      {
        "hooks": [
          {
            "type": "command",
            "command": "cd ~/repos/vault && git pull --ff-only --quiet 2>/dev/null; eval \"$(mise activate bash 2>/dev/null)\" && qmd update --quiet 2>/dev/null; echo 'vault synced'"
          }
        ]
      }
    ],
    "SessionEnd": [
      {
        "hooks": [
          {
            "type": "command",
            "command": "cd ~/repos/vault && git add -A && git diff --cached --quiet || (git commit -m 'chore: auto-save vault changes' && git push) 2>/dev/null &"
          }
        ]
      }
    ],
    "PreToolUse": [
      {
        "matcher": "Bash",
        "hooks": [
          {
            "type": "command",
            "command": "$HOME/.claude/hooks/block-dangerous.sh"
          },
          {
            "type": "command",
            "command": "$HOME/.claude/hooks/rtk-rewrite.sh"
          }
        ]
      }
    ]
  }
}
```

## block-dangerous.sh

ハードブロック（exit 2）:
- rm -rf /（クリティカルパス）
- curl | bash（リモートコード実行）
- curl --data（データ流出）
- sudo（権限昇格）
- mkfs, diskutil erase, dd of=/dev/（ディスク破壊）

警告（exit 0 + stderr）:
- git reset --hard, push --force, checkout ., clean -f, branch -D, stash drop/clear, restore
- DROP DATABASE/TABLE, TRUNCATE
- terraform destroy
- docker system/volume prune

## rtk-rewrite.sh

RTK (Rust Token Killer) によるコマンドリライト:
- `rtk rewrite` にコマンドを渡してリライト判定
- exit 0: リライト成功 → auto-allow + updatedInput
- exit 1: RTK 対象外 → パススルー
- exit 2: deny ルール → パススルー
- exit 3: ask ルール → リライトするが permissionDecision は設定せず確認を求める
- rtk >= 0.23.0 が必要
