---
tags:
  - concept
sources:
  - "Karpathy, LLM Wiki (gist:karpathy/442a6bf555914893e9891c11519de94f)"
created: 2026-04-06
updated: 2026-04-06
---

# LLM Wiki パターン

Karpathy が提唱する、LLM でナレッジベースを構築・保守するパターン。

## コアアイデア

従来の RAG は毎回ゼロから知識を再発見する。LLM Wiki は違う:
- LLM が **永続的な wiki を漸進的に構築・保守**する
- 相互リンク、矛盾のフラグ、合成は一度やれば蓄積される
- 知識は compile once, keep current

## 3層アーキテクチャ

1. **Raw sources** — 元ネタ（immutable）。人間が投入、LLM は参照のみ
2. **Wiki** — LLM が生成・保守する Markdown。要約、エンティティ、概念、比較
3. **Schema** — LLM への指示書（CLAUDE.md）。規約、ワークフロー、フォーマット

## 3つのオペレーション

### Ingest
- raw に資料追加 → LLM が読み、wiki ページを作成・更新
- 1つのソースが 10-15 ページに触れることもある
- 既存ページとの矛盾はフラグする

### Query
- LLM が wiki を検索し、回答を合成
- 価値のある回答は wiki ページとして保存（知識が複利で増える）

### Lint
- 矛盾、古い情報、孤立ページ、欠けたリンクをチェック
- LLM が保守の労働を担うから wiki が死なない

## ナビゲーション

- **index.md** — 全ページのカタログ（カテゴリ別、一行要約つき）
- **log.md** — 時系列の操作ログ（append-only）

## 検索ツール

- 小規模: index.md で十分
- 大規模: [[wiki/qmd-search-engine]] のような専用検索エンジン

## なぜ機能するか

人間が wiki を放棄する理由は保守コスト。LLM は:
- 飽きない
- 相互リンクの更新を忘れない
- 1パスで15ファイルに触れる

人間の仕事: ソースの選別、問いかけ、意味の解釈
LLM の仕事: それ以外すべて（要約、相互リンク、整合性管理）

## 関連

- [[wiki/markdown-knowledge-base-tools-comparison]] — LLM Wiki パターンと相性の良い Obsidian 代替ツールの比較
- [[wiki/dev-environment-architecture]] — 開発環境アーキテクチャ（vault を含む 3 リポジトリ構成）
