#!/bin/bash
# qmd に vault collection を登録する
set -euo pipefail

VAULT_ROOT="$(cd "$(dirname "$0")/../../.." && pwd)"
VAULT_DIR="${VAULT_ROOT}/vault"
COLLECTION_NAME="vault"

# qmd の存在確認
if ! command -v qmd &>/dev/null; then
  echo "ERROR: qmd がインストールされていません"
  echo "  npm install -g @tobilu/qmd"
  exit 1
fi

# 既存 collection の確認
if qmd collection show "$COLLECTION_NAME" &>/dev/null; then
  echo "collection '${COLLECTION_NAME}' は登録済みです"
  qmd collection show "$COLLECTION_NAME"
else
  echo "collection '${COLLECTION_NAME}' を登録します..."
  qmd collection add "$COLLECTION_NAME" "$VAULT_DIR" --pattern "**/*.md"
  echo "登録完了"
fi

echo ""
echo "埋め込みを生成します..."
qmd embed
echo "完了"

echo ""
qmd status
