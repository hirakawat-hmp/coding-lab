# Claude Code + tmux でターミナルを閉じても安全 — Raw

source: https://qiita.com/take-yoda/items/00f05b0b517ee3a7c427
fetched: 2026-04-22

## Summary

How to use tmux with Claude Code to maintain terminal sessions when closing windows during long-running AI tasks.

## Key Steps

1. Install tmux
2. Configure `~/.tmux.conf`: add `set -g extended-keys on` (for Ghostty compatibility)
3. Run: `claude --worktree --tmux=classic` (or `-w --tmux=classic`)
4. Close terminal safely — session continues in background
5. Reconnect: `tmux attach-session -t [session-name]`

## Notes

- `--worktree`: creates isolated git branch for safe Claude operations
- Ghostty terminal: GPU acceleration, full color, better Japanese rendering vs Mac Terminal
- Practical demo: building a React TODO app while disconnecting/reconnecting

Published: April 21, 2026
