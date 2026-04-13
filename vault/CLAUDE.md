# Vault — Personal Knowledge Base

LLM Wiki パターンに基づく個人ナレッジベース。
Obsidian で閲覧、Claude Code で生成・保守、qmd MCP で検索。

## ディレクトリ構成

- `Clippings/` — Obsidian Web Clipper の保存先。人間がWebから記事をクリップする。フロントマターの `status` フィールドで処理状態を管理（`pending` → `ingested`）
- `raw/` — 元ネタ（immutable）。Clippings から取得した原文、PDF、メモ、議事録。LLM が保存し、以降は変更しない
- `wiki/` — LLM が生成・保守する Markdown。要約、エンティティ、概念、比較、分析
- `index.md` — wiki 全ページのカタログ。カテゴリ別にリンク + 一行要約。ingest のたびに更新する
- `log.md` — 時系列の操作ログ（append-only）

## タグ規約

フロントマターの `tags` フィールドで分類する:

- `source` — raw から生成された要約ページ
- `entity` — 人物、ツール、サービス、組織など固有名詞
- `concept` — 技術概念、パターン、原則
- `insight` — プロジェクト横断の知見、学び
- `comparison` — 比較・対照ページ

## ページフォーマット

wiki ページは以下のフォーマットで作成する:

```markdown
---
tags:
  - <tag>
sources:
  - "[[raw/元ファイル名]]"
created: YYYY-MM-DD
updated: YYYY-MM-DD
---

# タイトル

本文。他の wiki ページへは `[[wiki/ページ名]]` でリンクする。
```

## ワークフロー

### Ingest（取り込み）

2つのパスがある:

**パス A: Clippings 経由（主フロー）**
1. 人間が Obsidian Web Clipper で `Clippings/` に記事をクリップ
2. LLM に「ingest して」と依頼（vault-ingest エージェントを使用）
3. LLM は `Clippings/` の `status: pending` を走査し、各クリップについて:
   - 元ソースを WebFetch/ダウンロードして `raw/` に保存
   - `wiki/` に要約ページを作成（タグ、ソースリンク、作成日を含む）
   - 関連する既存 wiki ページを更新（相互リンク追加、情報の統合）
   - 新情報が既存の記述と矛盾する場合はページ内に明記する
   - 言及されたエンティティや概念に専用ページがなければ作成する
   - クリップのフロントマターを `status: ingested` に更新
4. `index.md` にページを追加
5. `log.md` に記録

**パス B: 直接 raw/ に配置**
1. 人間が `raw/` に資料を直接追加（PDF、議事録、メモ等）
2. LLM に「ingest して」と依頼
3. 以降はパス A の step 3 と同様（wiki 生成、index/log 更新）

### Query（問い合わせ）

1. 人間が質問する
2. LLM は qmd MCP ツールで vault を検索（lex + vec のハイブリッド推奨）
3. 関連ページを読み、回答を生成
4. 価値のある回答（分析、比較、合成）は `wiki/` にページとして保存し、index.md を更新
5. `log.md` に記録: `## [YYYY-MM-DD] query | 質問の要約`

### Lint（保守）

定期的に wiki の健全性をチェックする:
- 矛盾する記述がないか
- 新しいソースで上書きされるべき古い情報がないか
- 孤立ページ（インバウンドリンクがない）がないか
- 言及されているが専用ページがない概念がないか
- 欠けている相互リンクがないか
- Web 検索で埋められるデータギャップがないか

チェック後 `log.md` に記録: `## [YYYY-MM-DD] lint | 修正内容の要約`

## index.md フォーマット

```markdown
# Index

## Sources
- [[wiki/ページ名]] — 一行要約

## Entities
- [[wiki/ページ名]] — 一行要約

## Concepts
- [[wiki/ページ名]] — 一行要約

## Insights
- [[wiki/ページ名]] — 一行要約

## Comparisons
- [[wiki/ページ名]] — 一行要約
```

## log.md フォーマット

```markdown
# Log

## [2026-04-06] ingest | 記事タイトル
- wiki/要約ページ.md を作成
- wiki/既存ページ.md を更新（新リンク追加）
```

## 特記事項

- wiki ページの内容は LLM が書く。人間は読む側
- raw/ のファイルは immutable。LLM は参照のみ
- プロジェクト固有ではなく、横断的な知見をここに蓄積する
- 知識は一度整理したら蓄積される。毎回ゼロから再発見しない
