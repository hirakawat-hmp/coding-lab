# Vault — 個人ナレッジベース

個人ナレッジベースが `~/repos/coding-lab/vault/` にある。
プロジェクト横断の知見を蓄積・検索するために使う。

運用ルールの詳細は vault/CLAUDE.md を参照。

## 検索（qmd MCP）

qmd MCP ツールで vault を検索できる。

- `mcp__qmd__query` — ハイブリッド検索（lex + vec 推奨）
  - `intent` パラメータに検索意図を必ず明記
  - collection: `"vault"`
- `mcp__qmd__get` — パスまたは docid で単一ドキュメント取得
- `mcp__qmd__multi_get` — glob やカンマ区切りで複数取得

```
# キーワード検索
[{type:'lex', query:'error handling'}]

# セマンティック検索
[{type:'vec', query:'how to handle errors gracefully'}]

# ハイブリッド（推奨）
[{type:'lex', query:'error'}, {type:'vec', query:'error handling best practices'}]
```

## いつ vault を参照するか

- 実装前に関連する過去の知見がないか確認
- ライブラリやツールの選定時に比較ページを探す
- エラーやハマりどころに遭遇した時
- 他プロジェクトで得た知見を活かせそうな時

## いつ vault に蓄積するか

- プロジェクト固有でない汎用的な知見を得た時
- ライブラリの使い方やハマりどころを発見した時
- 技術比較・選定を行った時
- 有用な設計パターンを見つけた時

蓄積は vault-ingest skill (`/vault-ingest`) または手動で vault/wiki/ にページを作成する。

## Vault Plugin

vault 操作用のツールは `~/repos/coding-lab/plugins/vault/` にある:

- **agents:** vault-researcher（他プロジェクトからの知識検索用）
- **skills:** /vault-ingest, /vault-lint, /vault-list, /vault-tags
- **scripts:** vault-cli.py（list/tags/lint/show）
