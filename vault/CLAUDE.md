# Knowledge Vault — 自動ナレッジベース

GitHub Actions 上の Claude Code で自動運用する個人ナレッジベース。
`vault/` ディレクトリを Obsidian の vault として開く。すべてのコンテンツは日本語で記述する。

## ディレクトリ構成

```
coding-lab/                   # git リポジトリルート
├── .github/workflows/        # GitHub Actions
├── plugins/vault/            # vault 操作プラグイン（agents, skills, scripts, config）
│
└── vault/                    # Obsidian vault パス + ナレッジストア
    ├── wiki/                 # LLM が生成・保守するページ
    ├── newsletters/          # 日次ニュースレター
    ├── raw/                  # 取得した元ソース（immutable）
    ├── assets/               # 画像等
    ├── index.md              # wiki 全ページのカタログ（カテゴリ別）
    └── log.md                # 時系列の操作ログ（append-only）
```

### パス規約

- wiki ページ: `vault/wiki/ページ名.md`
- ニュースレター: `vault/newsletters/YYYY-MM-DD.md`
- 画像: `vault/assets/`
- 元ソース: `vault/raw/`
- index, log: `vault/index.md`, `vault/log.md`

## Frontmatter スキーマ

すべての wiki ページは以下の構造を持つ:

```yaml
---
type: <type>              # 必須、単一値
status: [<status>, ...]   # 必須、配列（空配列 [] も可）
tags: [<tag>, ...]        # 必須、配列
sources: [...]            # 任意
created: YYYY-MM-DD       # 必須
updated: YYYY-MM-DD       # 必須
---
```

### type（ページの型）

| type | 用途 |
|------|------|
| `entity` | 固有名詞の辞書ページ |
| `concept` | 抽象概念、パターン、原則 |
| `how-to` | 手順書、レシピ |
| `reference` | 仕様書、API リファレンス、チートシート |
| `insight` | 横断的な学び、気付き |
| `comparison` | 2つ以上の対象を比較 |
| `decision` | 設計判断、技術選定の記録 |
| `troubleshooting` | トラブルシュート事例 |
| `idea` | アイデア、壁打ち記録 |
| `meta` | vault 自体のメタ情報 |

### status（状態）

状態遷移を持つ type のみ値を入れる。持たない場合は `[]`。
詳細な語彙と Type×Status 対応は `vault/tags.md` を参照。

### tags（ドメインタグ）

トピックや領域を示す。階層はスラッシュ区切り（例: `ai/llm`, `infra/gcp`）。
**利用可能なタグは `vault/tags.md` に定義されている。新規タグを使いたい場合は先に tag library に追加する。**

## wiki ページフォーマット

```markdown
---
type: concept
status: []
tags:
  - ai/llm
  - tool/claude-code
sources:
  - "URL or reference"
created: YYYY-MM-DD
updated: YYYY-MM-DD
---

# タイトル

本文。他の wiki ページへは `[[wiki/ページ名]]` でリンクする。
```

### ファイル名規約

- kebab-case（小文字、ハイフン区切り）
- 英語ベース（例: `vault/wiki/react-server-components.md`）
- 簡潔で内容を表すもの

## ニュースレターフォーマット

`vault/newsletters/YYYY-MM-DD.md` に以下の形式で作成:

```markdown
---
created: YYYY-MM-DD
type: newsletter
---

# Daily Knowledge Digest — YYYY-MM-DD

## 要約

今日のトピックの1-2文の概要。

## トピック

### 1. トピックタイトル

要約（3-5文）。背景、重要なポイント、影響を含める。

**関連ページ:** [[wiki/作成したページ名]]
**ソース:** [記事タイトル](URL)

### 2. トピックタイトル
...

## 今日作成・更新したページ

- [[wiki/ページ名]] — 一行説明
- [[wiki/ページ名]] — 一行説明

## 関連する既存ページ

- [[wiki/既存ページ名]] — どう関連するか
```

## index.md フォーマット

`vault/index.md` は type 別のカタログ:

```markdown
# Index

## Entities
## Concepts
## How-to
## Reference
## Insights
## Comparisons
## Decisions
## Troubleshooting
## Ideas
## Meta
```

新しいページを作成したら、該当する type のセクションに `- [[wiki/ページ名]] — 一行要約` 形式で追加する。新しいものは末尾に追加。

## log.md フォーマット

`vault/log.md` に以下の形式:

```markdown
# Log

## [YYYY-MM-DD] operation | 説明
- 実行した内容の箇条書き
```

operation の種類:
- `research` — Issue 経由のリサーチ
- `digest` — RSS/ニュースの日次ダイジェスト
- `update` — 既存ページの更新

## Agentic Search（知識探索）

vault は埋め込みベースの RAG ではなく、**agent がパスとタグを指定して明示的に探索する** 設計を採用している。

### 探索手順

1. **tag library を確認**: `vault/tags.md` を読み、利用可能な type と tag を把握
2. **候補を絞り込む**: type と tag で wiki ページをフィルタ
   - 例: `type: how-to` + `tag: infra/gcp` → GCP 関連の手順ページ
3. **index.md で概要を確認**: `vault/index.md` から関連ページを選ぶ
4. **ページを読む**: `Read` でフロントマターと本文を取得
5. **リンクをたどる**: 本文中の `[[wiki/X]]` リンクから関連ページへ
6. **必要なら本文検索**: `Grep` で特定のキーワードを探す
7. **不足があれば追加**: 欲しい情報がなければ WebSearch/WebFetch で調査し、新ページを作成

### 原則

- **まず既存知識を見る**: 毎回ゼロから調べ直さない。`vault/wiki/` と `vault/index.md` を先に確認
- **明示的なパスを優先**: ベクトル検索より、type/tag/ファイル名での直接指定を優先
- **見つけた情報は wiki に蓄積**: 有用な知見は wiki ページとして残し、次回の探索コストを下げる

## ワークフロー

### Research（Issue 経由）

1. Issue のコメントからリサーチトピックを抽出
2. WebSearch でトピックを調査（複数の検索クエリを試す）
3. 重要なソースを WebFetch で取得し `vault/raw/` に保存
4. `vault/wiki/` にページを作成:
   - トピックの要約ページ（source タグ）
   - 言及されたエンティティの専用ページ（entity タグ）
   - 新しい概念があれば概念ページ（concept タグ）
   - 既存ページとの関連があればリンクを追加
5. `vault/newsletters/YYYY-MM-DD.md` を作成または追記
6. `vault/index.md` を更新
7. `vault/log.md` に記録
8. Issue にコメントで結果を報告

### Daily Digest（RSS/Cron）

1. `plugins/vault/config/feeds.yml` を読み込む
2. 各フィードの RSS を WebFetch で取得
3. 直近24時間以内の記事をフィルタ
4. 重要な記事（settings の max_total_articles まで）を選別
5. 各記事について:
   a. WebFetch で全文取得し `vault/raw/` に保存
   b. WebSearch で関連情報を追加調査
   c. `vault/wiki/` にページを作成（適切なタグ付き）
   d. 関連する既存 wiki ページにリンクを追加
6. `vault/newsletters/YYYY-MM-DD.md` を作成（全トピック集約）
7. `vault/index.md` を更新
8. `vault/log.md` に記録

## Git コミット規約

- コミットメッセージは英語で簡潔に
- 形式: `<type>: <description>`
  - `research: <topic>` — Issue リサーチ
  - `digest: YYYY-MM-DD daily digest` — 日次ダイジェスト
  - `update: <what changed>` — 更新

## 重要な注意事項

- すべての wiki コンテンツは **日本語** で記述する
- ファイル名は **英語 kebab-case**
- raw/ のファイルは一度保存したら変更しない（immutable）
- 既存の wiki ページと関連があれば `[[wiki/ページ名]]` で相互リンクする
- 新情報が既存の記述と矛盾する場合はページ内に明記する
- 1つのトピックから複数ページを作成してよい（要約、エンティティ、概念）
- newsletters/ は日付ごとに1ファイル。同日に複数回実行された場合は追記する
- リサーチは深く行う。表面的な要約ではなく、技術的な詳細まで踏み込む
- vault/index.md は必ずリサーチ/ダイジェスト完了後に更新する
