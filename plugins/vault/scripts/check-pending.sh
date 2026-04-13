#!/bin/bash
# vault/Clippings/ の未処理ファイルを検出する
set -euo pipefail

VAULT_ROOT="$(cd "$(dirname "$0")/../../.." && pwd)"
CLIPPINGS_DIR="${VAULT_ROOT}/vault/Clippings"

if [ ! -d "$CLIPPINGS_DIR" ]; then
  echo "Clippings ディレクトリなし: ${CLIPPINGS_DIR}"
  exit 0
fi

pending_files=()
while IFS= read -r -d '' file; do
  if head -30 "$file" | grep -q 'status:.*pending'; then
    pending_files+=("$file")
  fi
done < <(find "$CLIPPINGS_DIR" -name "*.md" -type f -print0 2>/dev/null)

if [ ${#pending_files[@]} -eq 0 ]; then
  echo "未処理の Clippings はありません。"
else
  echo "未処理の Clippings: ${#pending_files[@]} 件"
  echo ""
  for f in "${pending_files[@]}"; do
    basename "$f"
  done
fi
