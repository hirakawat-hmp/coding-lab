#!/bin/bash
set -euo pipefail

ROOT="$(cd "$(dirname "$0")" && pwd)"

info() { printf "\033[1;34m[info]\033[0m %s\n" "$1"; }
ok()   { printf "\033[1;32m[ok]\033[0m   %s\n" "$1"; }
warn() { printf "\033[1;33m[warn]\033[0m %s\n" "$1"; }

# --- Phase 1: Symlinks ---
mkdir -p ~/.claude/rules ~/.claude/agents ~/.claude/skills ~/.claude/hooks

# Rules
for f in "$ROOT"/config/rules/*.md; do
  [ -f "$f" ] && ln -sf "$f" ~/.claude/rules/"$(basename "$f")"
done
ok "rules linked"

# Agents: vault + dev-tools
for d in "$ROOT"/plugins/*/agents; do
  [ -d "$d" ] || continue
  for f in "$d"/*.md; do
    [ -f "$f" ] && ln -sf "$f" ~/.claude/agents/"$(basename "$f")"
  done
done
ok "agents linked"

# Skills: vault + dev-tools
for d in "$ROOT"/plugins/*/skills; do
  [ -d "$d" ] || continue
  for s in "$d"/*/; do
    [ -d "$s" ] && ln -sfn "$s" ~/.claude/skills/"$(basename "$s")"
  done
done
ok "skills linked"

# Hooks
for d in "$ROOT"/plugins/*/hooks; do
  [ -d "$d" ] || continue
  for f in "$d"/*.sh; do
    [ -f "$f" ] && ln -sf "$f" ~/.claude/hooks/"$(basename "$f")"
  done
done
ok "hooks linked"

# Settings & global config
ln -sf "$ROOT/config/settings.json" ~/.claude/settings.json
ok "settings linked"

ln -sf "$ROOT/config/CLAUDE.md" ~/.claude/CLAUDE.md
ok "global CLAUDE.md linked"

# Output styles
mkdir -p ~/.claude/output-styles
for f in "$ROOT"/config/output-styles/*.md; do
  [ -f "$f" ] && ln -sf "$f" ~/.claude/output-styles/"$(basename "$f")"
done
ok "output-styles linked"

# --- Phase 2: MCP servers ---
if command -v claude &>/dev/null && command -v jq &>/dev/null; then
  info "Registering MCP servers..."

  MCP_FILE="$ROOT/config/mcp-servers.json"
  for name in $(jq -r 'keys[]' "$MCP_FILE"); do
    config=$(jq -c ".\"$name\"" "$MCP_FILE")
    claude mcp add-json --scope user "$name" "$config" 2>/dev/null \
      && ok "mcp: $name" \
      || warn "mcp failed: $name"
  done
else
  if ! command -v claude &>/dev/null; then
    warn "Claude Code not found. Skipping MCP server registration."
  elif ! command -v jq &>/dev/null; then
    warn "jq not found. Install jq first, then re-run this script."
  fi
fi

# --- Phase 3: Plugins ---
if command -v claude &>/dev/null; then
  info "Registering plugin marketplaces..."

  MARKETPLACES=(
    "anthropics/claude-plugins-official"
    "anthropics/claude-code"
    "wshobson/agents"
    "affaan-m/everything-claude-code"
    "yamadashy/repomix"
    "ComposioHQ/awesome-claude-skills"
    "ChromeDevTools/chrome-devtools-mcp"
    "muratcankoylan/Agent-Skills-for-Context-Engineering"
    "K-Dense-AI/claude-scientific-skills"
    "upstash/context7"
  )
  for repo in "${MARKETPLACES[@]}"; do
    claude plugin marketplace add "$repo" 2>/dev/null && ok "marketplace: $repo" || warn "marketplace already registered or failed: $repo"
  done

else
  warn "Claude Code not found. Install it first, then run this script again."
fi

# --- Done ---
echo ""
ok "Claude Code configuration complete!"
