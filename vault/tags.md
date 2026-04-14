---
type: meta
status: []
created: 2026-04-10
updated: 2026-04-10
---

# Tag Library

vault 全体で使用可能な **type**、**status**、**tags** の正典。

wiki ページを作成・更新する際は必ずこのファイルを参照し、ここに定義された語彙のみを使用する。新しい type/status/tag を使いたい場合は、まずこのファイルに追加してから使う。

## Frontmatter スキーマ

すべての wiki ページは以下の frontmatter を持つ:

```yaml
---
type: <type>              # 必須、単一値
status: [<status>, ...]   # 必須、配列（空配列 [] も可）
tags: [<tag>, ...]        # 必須、配列（空配列 [] も可）
sources: [...]            # 任意、URL や参照元
created: YYYY-MM-DD       # 必須
updated: YYYY-MM-DD       # 必須
---
```

## Type 一覧

| type | 用途 | 例 |
|------|------|-----|
| `entity` | 固有名詞の辞書ページ（What is X?） | `cloud-run.md`, `anthropic.md` |
| `concept` | 抽象概念、パターン、原則 | `llm-wiki-pattern.md` |
| `how-to` | 手順書、レシピ、具体的な実装方法 | `cloud-run-fastapi-deploy.md` |
| `reference` | 仕様書、API リファレンス、チートシート | `gcloud-cli-cheatsheet.md` |
| `insight` | プロジェクト横断の学び、気付き | `knowledge-vault-lessons.md` |
| `comparison` | 2つ以上の対象を比較するページ | `pptxgenjs-vs-python-pptx.md` |
| `decision` | 設計判断、技術選定の記録（ADR 的） | `why-claude-code-action-over-custom.md` |
| `troubleshooting` | トラブルシュート事例、エラー解決 | `oidc-token-auth-failure.md` |
| `idea` | アイデア、壁打ち記録 | `agentic-vault-search-design.md` |
| `research-report` | Issue 起点の調査レポート（wiki ページ群の束ね） | `2026-04-14-topic.md` |
| `meta` | vault 自体に関するメタ情報（このファイルなど） | `tags.md` |

## Status 語彙

status は **配列** で、複数の状態を同時に表現できる。
status を持たない（状態遷移がない）ページは空配列 `[]` を使う。

### Lifecycle status

状態遷移を持つページ（`idea`, `decision`, `troubleshooting` 等）で使う。

| status | 意味 |
|--------|------|
| `seed` | 思い付きレベル（idea） |
| `growing` | 議論・具体化中（idea） |
| `mature` | 方針が固まった（idea） |
| `proposed` | 提案中（decision） |
| `accepted` | 採用された（decision） |
| `implemented` | 実装された（idea, decision） |
| `superseded` | 別の判断に置き換わった（decision） |
| `discarded` | 却下された（idea, decision） |
| `investigating` | 調査中（troubleshooting） |
| `resolved` | 解決済み（troubleshooting） |

### Quality status

品質・検証レベルを示す（`how-to`, `reference` 向け）。

| status | 意味 |
|--------|------|
| `draft` | 下書き、未検証 |
| `verified` | 実際に検証済み |
| `deprecated` | 非推奨、別の方法を推奨 |

### Freshness status

情報の鮮度を示す（全 type で使える）。

| status | 意味 |
|--------|------|
| `outdated` | 情報が古い可能性、更新が必要 |
| `needs-review` | 見直しが必要 |

### Archive status

全 type で使える。アーカイブされたページはデフォルトの検索結果から除外される。

| status | 意味 |
|--------|------|
| `archived` | 歴史的資料、現在は直接参照しない |

## Type × Status 対応表

各 type で使用可能な status 語彙:

| type              | 使える status                                                                       |
| ----------------- | -------------------------------------------------------------------------------- |
| `entity`          | Freshness                                                                        |
| `concept`         | Freshness                                                                        |
| `how-to`          | Quality + Freshness                                                              |
| `reference`       | Quality + Freshness                                                              |
| `insight`         | Freshness                                                                        |
| `comparison`      | Freshness                                                                        |
| `decision`        | Lifecycle の {proposed, accepted, superseded, discarded, implemented} + Freshness |
| `troubleshooting` | Lifecycle の {investigating, resolved} + Freshness                                |
| `idea`            | Lifecycle の {seed, growing, mature, implemented, discarded} + Freshness          |
| `research-report` | なし（常に `[]`）                                                                      |
| `meta`            | なし（常に `[]`）                                                                      |

## ドメインタグ

トピック・領域を示すタグ。ページは複数のドメインタグを持てる。
**階層構造はスラッシュ区切り**（例: `ai/llm`, `infra/gcp`）。

### AI / LLM

| タグ | 説明 |
|------|------|
| `ai/llm` | LLM 全般 |
| `ai/agent` | エージェントシステム、自律実行 |
| `ai/rag` | RAG、セマンティック検索 |
| `ai/eval` | 評価、ベンチマーク、モデル検証 |
| `ai/prompt-engineering` | プロンプト設計 |
| `ai/video-gen` | 動画生成 AI モデル・ツール |
| `ai/audio-gen` | 音楽・音声生成 AI モデル・ツール |
| `ai/image-gen` | 画像生成 AI モデル・ツール |
| `ai/computer-vision` | コンピュータビジョン、物体検出・追跡・セグメンテーション |
| `media/3d` | 3D グラフィックス、メッシュ処理、モーションキャプチャ |

### Infrastructure

| タグ | 説明 |
|------|------|
| `infra/gcp` | Google Cloud Platform |
| `infra/aws` | AWS |
| `infra/k8s` | Kubernetes |
| `infra/ci-cd` | CI/CD、GitHub Actions 含む |
| `infra/docker` | Docker、コンテナ |
| `infra/cloudflare` | Cloudflare サービス・製品・Workers |
| `infra/sre` | SRE、信頼性エンジニアリング、Platform Engineering |

### Development

| タグ | 説明 |
|------|------|
| `dev/typescript` | TypeScript |
| `dev/python` | Python |
| `dev/rust` | Rust |
| `dev/bash` | Bash / Shell |
| `dev/git` | Git、バージョン管理 |
| `dev/markdown` | Markdown 記法、ドキュメント生成 |
| `dev/javascript` | JavaScript / Node.js / Bun エコシステム |

### Knowledge Management

| タグ | 説明 |
|------|------|
| `km/vault` | Knowledge vault、wiki 運用 |
| `km/obsidian` | Obsidian |
| `km/markdown` | Markdown 関連 |

### Tools

個別の CLI ツール、ライブラリ、サービス。

| タグ | 説明 |
|------|------|
| `tool/claude-code` | Claude Code CLI |
| `tool/claude-code-action` | anthropics/claude-code-action |
| `tool/qmd` | qmd 検索ツール |
| `tool/pptxgenjs` | PptxGenJS（JavaScript PPTX 生成ライブラリ） |
| `tool/python-pptx` | python-pptx（Python PPTX 操作ライブラリ） |
| `tool/marp` | Marp（Markdown スライド生成） |
| `tool/presenton` | presenton（OSS プレゼン生成プラットフォーム） |
| `tool/pptagent` | PPTAgent（PPTX 生成エージェントフレームワーク） |
| `tool/rtk` | RTK - Rust Token Killer |
| `tool/officecli` | OfficeCLI（AI エージェント向け Office 操作 CLI） |
| `tool/google-stitch` | Google Stitch（DESIGN.md → UI 生成） |

### Frameworks

AI エージェントや開発の **フレームワーク**。ライブラリ単体より高次のもの。

| タグ | 説明 |
|------|------|
| `framework/mastra` | Mastra（TypeScript AI エージェントフレームワーク） |
| `framework/adk` | Google ADK（マルチエージェントフレームワーク） |

### Statistics / Math

統計・数理・最適化の話題。

| タグ | 説明 |
|------|------|
| `stats/bayesian` | ベイズ推論、Belief Propagation、確率モデル |
| `stats/mmm` | Marketing Mix Modeling |
| `stats/optimization` | 最適化問題、アルゴリズム |

### Security

| タグ | 説明 |
|------|------|
| `security/web` | Web セキュリティ、脆弱性、CVE |
| `security/supply-chain` | サプライチェーン攻撃、依存関係汚染 |

### Design

デザインシステム、UI 設計。

| タグ | 説明 |
|------|------|
| `design/system` | デザインシステム、DESIGN.md、スタイルガイド |

### UI / Visualization

UI コンポーネント、データ可視化。

| タグ | 説明 |
|------|------|
| `ui/components` | UI コンポーネントライブラリ（shadcn/ui 等） |
| `ui/visualization` | データ可視化、チャート、グラフ |

### Projects

プロジェクト固有の知識を示すタグ。期間とステータスで管理。

| タグ | 説明 | 期間 | ステータス |
|------|------|------|-----------|
| `project/knowledge-vault` | このリポジトリ自体 | 2026-04〜 | active |
| `project/aaas-ai-planner` | AaaS AI Planner（旧 AAIP） - AI 駆動マーケティング戦略立案・プレゼン生成システム | 2025-12〜 | active |

プロジェクトタグが付いたページは project 単位で振り返りたい時に `tag:project/xxx` で絞り込む。
普段の agentic search ではドメインタグ（ai/, infra/ 等）で検索すれば自然にプロジェクト知識も含まれる。

## 運用ルール

1. **type は必ず1つ**: 複数の type は指定できない
2. **status は配列**: 空配列 `[]` も有効。複数値を持てる
3. **tags は配列**: ドメインタグを複数指定可能
4. **新規タグは先にこのファイルに登録**: 未登録タグを frontmatter に書かない
5. **lint で検出される**: `scripts/lint-check.sh` が未登録 type/status/tag を検出する
6. **定期見直し**: 月1 or 四半期に1回、tag library を lint して統合・削除・追加を検討

## 未登録タグの扱い

lint 実行時に tag library 未登録のタグが検出された場合:
1. 正式登録するか判断（このファイルに追加）
2. 既存タグへ統合（表記ゆれ吸収）
3. 一時的に許容（新領域の発見時）

## 関連ページ

- `../CLAUDE.md` — vault 全体の運用ルール
- [[wiki/knowledge-vault-lessons]] — vault 構築の教訓
