#!/bin/bash
set -euo pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
EXTERNAL_DIR="$ROOT/plugins/external"
MANIFEST="$EXTERNAL_DIR/manifest.yml"
SKILLS_DIR="$HOME/.claude/skills"

info() { printf "\033[1;34m[info]\033[0m %s\n" "$1"; }
ok()   { printf "\033[1;32m[ok]\033[0m   %s\n" "$1"; }
err()  { printf "\033[1;31m[err]\033[0m  %s\n" "$1" >&2; }

usage() {
  cat <<'EOF'
Usage: external.sh <command> [args]

Commands:
  add <owner/repo> [--path <path>] [--name <name>]
      Clone a GitHub repo and register it as an external skill/plugin.
      --path  Path to skill/plugin within the repo (auto-detected if possible)
      --name  Override the directory name (default: repo name)

  remove <name>
      Remove an external skill/plugin and its symlink.

  update [name]
      Git pull all externals, or a specific one.

  link
      Re-create symlinks for all registered externals.

  list
      Show registered externals.
EOF
  exit 1
}

# --- Helpers ---

detect_skill_path() {
  local dir="$1"
  # Check common locations for SKILL.md
  for candidate in \
    ".claude/skills" \
    "skills" \
    "."; do
    if find "$dir/$candidate" -name "SKILL.md" -maxdepth 2 2>/dev/null | grep -q .; then
      # Return the parent dir of the first SKILL.md found
      local skill_dir
      skill_dir=$(find "$dir/$candidate" -name "SKILL.md" -maxdepth 2 2>/dev/null | head -1 | xargs dirname)
      echo "${skill_dir#$dir/}"
      return 0
    fi
  done
  return 1
}

check_python_deps() {
  python3 -c "import yaml" 2>/dev/null || { err "PyYAML is required: pip install pyyaml"; exit 1; }
}

add_to_manifest() {
  local name="$1" repo="$2" skill_path="$3"
  check_python_deps
  python3 - "$name" "$repo" "$skill_path" "$MANIFEST" <<'PYEOF'
import yaml, sys
name, repo, skill_path, manifest = sys.argv[1], sys.argv[2], sys.argv[3], sys.argv[4]
with open(manifest, 'r') as f:
    data = yaml.safe_load(f) or {}
entries = data.get('entries', []) or []
for e in entries:
    if e.get('name') == name:
        print(f'Already registered: {name}', file=sys.stderr)
        sys.exit(1)
entries.append({'name': name, 'repo': repo, 'type': 'skill', 'path': skill_path})
data['entries'] = entries
with open(manifest, 'w') as f:
    yaml.dump(data, f, default_flow_style=False, allow_unicode=True, sort_keys=False)
PYEOF
}

remove_from_manifest() {
  local name="$1"
  check_python_deps
  python3 - "$name" "$MANIFEST" <<'PYEOF'
import yaml, sys
name, manifest = sys.argv[1], sys.argv[2]
with open(manifest, 'r') as f:
    data = yaml.safe_load(f) or {}
entries = data.get('entries', []) or []
data['entries'] = [e for e in entries if e.get('name') != name]
with open(manifest, 'w') as f:
    yaml.dump(data, f, default_flow_style=False, allow_unicode=True, sort_keys=False)
PYEOF
}

get_entries() {
  check_python_deps
  python3 - "$MANIFEST" <<'PYEOF'
import yaml, json, sys
manifest = sys.argv[1]
with open(manifest, 'r') as f:
    data = yaml.safe_load(f) or {}
entries = data.get('entries', []) or []
for e in entries:
    print(json.dumps(e))
PYEOF
}

create_symlink() {
  local name="$1" skill_path="$2"
  local source="$EXTERNAL_DIR/$name/$skill_path"
  local skill_name
  skill_name=$(basename "$skill_path")

  if [ ! -d "$source" ]; then
    err "Source not found: $source"
    return 1
  fi

  mkdir -p "$SKILLS_DIR"
  ln -sfn "$source" "$SKILLS_DIR/$skill_name"
  ok "linked: $skill_name → $source"
}

# --- Commands ---

cmd_add() {
  local repo="" path="" name=""

  while [[ $# -gt 0 ]]; do
    case "$1" in
      --path) path="$2"; shift 2 ;;
      --name) name="$2"; shift 2 ;;
      *)
        if [ -z "$repo" ]; then
          repo="$1"; shift
        else
          err "Unknown argument: $1"; exit 1
        fi
        ;;
    esac
  done

  if [ -z "$repo" ]; then
    err "Usage: external.sh add <owner/repo> [--path <path>] [--name <name>]"
    exit 1
  fi

  [ -z "$name" ] && name=$(basename "$repo")

  if [ -d "$EXTERNAL_DIR/$name" ]; then
    err "$name already exists at $EXTERNAL_DIR/$name"
    exit 1
  fi

  info "Cloning $repo..."
  gh repo clone "$repo" "$EXTERNAL_DIR/$name" -- --depth 1

  # Auto-detect skill path if not specified
  if [ -z "$path" ]; then
    if path=$(detect_skill_path "$EXTERNAL_DIR/$name"); then
      info "Auto-detected skill path: $path"
    else
      err "Could not auto-detect skill path. Use --path to specify."
      rm -rf "$EXTERNAL_DIR/$name"
      exit 1
    fi
  fi

  add_to_manifest "$name" "$repo" "$path"
  create_symlink "$name" "$path"
  ok "Added $name ($repo)"
}

cmd_remove() {
  local name="${1:-}"
  if [ -z "$name" ]; then
    err "Usage: external.sh remove <name>"
    exit 1
  fi

  # Get skill path before removing from manifest
  local skill_path
  skill_path=$(python3 - "$name" "$MANIFEST" <<'PYEOF'
import yaml, sys
name, manifest = sys.argv[1], sys.argv[2]
with open(manifest, 'r') as f:
    data = yaml.safe_load(f) or {}
for e in data.get('entries', []) or []:
    if e.get('name') == name:
        print(e.get('path', ''))
        break
PYEOF
)

  if [ -n "$skill_path" ]; then
    local skill_name
    skill_name=$(basename "$skill_path")
    rm -f "$SKILLS_DIR/$skill_name"
  fi

  rm -rf "$EXTERNAL_DIR/$name"
  remove_from_manifest "$name"
  ok "Removed $name"
}

cmd_update() {
  local target="${1:-}"

  get_entries | while IFS= read -r entry; do
    local name repo
    name=$(echo "$entry" | jq -r '.name')
    repo=$(echo "$entry" | jq -r '.repo')

    if [ -n "$target" ] && [ "$name" != "$target" ]; then
      continue
    fi

    if [ -d "$EXTERNAL_DIR/$name" ]; then
      info "Updating $name..."
      git -C "$EXTERNAL_DIR/$name" pull --ff-only 2>/dev/null \
        && ok "$name updated" \
        || err "$name update failed"
    else
      info "Re-cloning $name..."
      gh repo clone "$repo" "$EXTERNAL_DIR/$name" -- --depth 1 \
        && ok "$name cloned" \
        || err "$name clone failed"
    fi
  done
}

cmd_link() {
  get_entries | while IFS= read -r entry; do
    local name skill_path
    name=$(echo "$entry" | jq -r '.name')
    skill_path=$(echo "$entry" | jq -r '.path')
    create_symlink "$name" "$skill_path"
  done
}

cmd_list() {
  get_entries | while IFS= read -r entry; do
    local name repo skill_path
    name=$(echo "$entry" | jq -r '.name')
    repo=$(echo "$entry" | jq -r '.repo')
    skill_path=$(echo "$entry" | jq -r '.path')
    local installed="✗"
    local skill_name
    skill_name=$(basename "$skill_path")
    [ -L "$SKILLS_DIR/$skill_name" ] && installed="✓"
    printf "  %s %-20s %-35s %s\n" "$installed" "$name" "$repo" "$skill_path"
  done
}

# --- Main ---

case "${1:-}" in
  add)    shift; cmd_add "$@" ;;
  remove) shift; cmd_remove "$@" ;;
  update) shift; cmd_update "$@" ;;
  link)   cmd_link ;;
  list)   cmd_list ;;
  *)      usage ;;
esac
