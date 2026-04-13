#!/bin/bash
# PreToolUse hook for Bash: block catastrophic commands, warn on dangerous ones
# Hard block (exit 2): never allowed, even if user approved Bash
# Warn (exit 0 + stderr): LLM sees warning before proceeding

set -uo pipefail

input=$(cat)
cmd=$(echo "$input" | jq -r '.tool_input.command // empty')
[ -z "$cmd" ] && exit 0

block() {
  echo "{\"decision\":\"block\",\"reason\":\"$1\"}" >&2
  exit 2
}

warn() {
  echo "WARNING: $1" >&2
  exit 0
}

# ============================================================
# HARD BLOCK — catastrophic, never allowed
# ============================================================

# rm -rf on critical paths (/, ~, $HOME, .)
if echo "$cmd" | grep -qE '\brm\s+.*-[a-zA-Z]*[rf][a-zA-Z]*\s+(/\s|/\b|~/|~\b|\$HOME|/\*\b)'; then
  block "rm -rf on critical path (/, ~) is never allowed"
fi

# Pipe remote content to shell (primary prompt injection vector)
if echo "$cmd" | grep -qE '(curl|wget)\s.*\|\s*(bash|sh|zsh|python|node)'; then
  block "Piping remote content to shell is never allowed"
fi

# Data exfiltration via HTTP
if echo "$cmd" | grep -qE '(curl|wget)\s.*(-d\s|--data|--data-raw|--data-binary|-F\s|--upload-file|-T\s)'; then
  block "Sending data to external servers requires manual execution"
fi

# sudo — AI agents should never escalate privileges
if echo "$cmd" | grep -qE '\bsudo\b'; then
  block "sudo is not allowed for AI agents"
fi

# Disk destruction (macOS)
if echo "$cmd" | grep -qEi '\b(mkfs|diskutil\s+(erase|partitionDisk))\b'; then
  block "Disk format operations are never allowed"
fi
if echo "$cmd" | grep -qE '\bdd\s+.*of=/dev/'; then
  block "Raw disk writes are never allowed"
fi

# ============================================================
# WARN — dangerous but sometimes intentional
# ============================================================

# Git destructive operations
echo "$cmd" | grep -qE '\bgit\s+reset\s+--hard\b' \
  && warn "git reset --hard will discard all uncommitted changes"
echo "$cmd" | grep -qEi '\bgit\s+push\s+.*(-f\b|--force)\b' \
  && warn "git push --force can overwrite remote history"
echo "$cmd" | grep -qE '\bgit\s+checkout\s+(--\s*)?[.]' \
  && warn "git checkout . will discard all working tree changes"
echo "$cmd" | grep -qE '\bgit\s+checkout\s+--\s' \
  && warn "git checkout -- will discard changes to specified files"
echo "$cmd" | grep -qE '\bgit\s+clean\s+-[a-zA-Z]*f' \
  && warn "git clean -f permanently deletes untracked files"
echo "$cmd" | grep -qE '\bgit\s+branch\s+-D\b' \
  && warn "git branch -D force-deletes without merge check"
echo "$cmd" | grep -qEi '\bgit\s+stash\s+(drop|clear)\b' \
  && warn "git stash drop/clear permanently deletes stashed changes"
echo "$cmd" | grep -qE '\bgit\s+restore\b' | grep -qvE '\-\-staged' \
  && warn "git restore (without --staged) discards working tree changes"

# Database destruction
echo "$cmd" | grep -qEi '\bDROP\s+(DATABASE|TABLE|SCHEMA)\b' \
  && warn "Database destructive operation: DROP detected"
echo "$cmd" | grep -qEi '\bTRUNCATE\b' \
  && warn "Database destructive operation: TRUNCATE detected"

# Infrastructure destruction
echo "$cmd" | grep -qEi '\bterraform\s+destroy\b' \
  && warn "terraform destroy will tear down infrastructure"
echo "$cmd" | grep -qEi '\bdocker\s+(system|volume)\s+prune\b' \
  && warn "docker prune will remove all unused resources"

exit 0
