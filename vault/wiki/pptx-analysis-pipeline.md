---
type: concept
status: []
tags:
  - ai/agent
  - dev/python
  - dev/typescript
  - project/aaas-ai-planner
sources:
  - "fastapi_summary_pptx_capability.md"
  - "pptx-import.md"
created: 2026-04-06
updated: 2026-04-06
---

# PPTX 解析・インポートパイプライン

PPTX/PDF ファイルを解析してコンテンツを抽出・構造化し、レポートを生成するパイプライン。2つのアプローチが存在する。

## アプローチ 1: FastAPI 3段階解析（summary_pptx）

FastAPI サーバーの `/api/summary-pptx` エンドポイントで提供される深層解析。

### Phase 1: コンテンツ抽出

[[wiki/python-pptx]] でスライドから以下を抽出する:

- **テキスト**: 段落・改行を保持
- **表 (Tables)**: テキスト配列 + 数値パース済み配列（通貨記号、カンマ、パーセント、括弧負数に対応）
- **グラフ (Charts)**: タイトル、系列（名前、カテゴリ、値）
- **埋め込み Excel**: OLE オブジェクトとして埋め込まれた .xlsx を openpyxl で抽出

### Phase 2: 論理構造解析（Gemini AI）

スライド群を3-8の章に分類し、各スライドの目的（intent）、スライド間の接続関係（connections）、章間の相互参照（cross_links）を出力する。全スライドは必ず1つの章に割り当てられる。

### Phase 3: レポート生成（Markdown）

Gemini AI で戦略サマリーを生成する:

- ステップ1: 商品・KPI から課題を分析（主要課題3件）
- ステップ2: 戦略のまとめ（全体戦略、チャネル別戦術、スケジュール案、予算配分案）
- 数値情報は tables.rows_numeric から積極的に使用し、不明な数値は「不明」、推定は「(仮説)」と明記

### 技術スタック

python-pptx, pdfplumber, openpyxl, google-generativeai (Gemini)。非同期処理でバックグラウンド実行し、ステータスポーリングで結果を取得する。

## アプローチ 2: ルールベース変換（pptx-import）

PPTX を python-pptx で解析し、中間表現 (IR, Pydantic モデル) に変換した後、ルールベースで React/Tailwind コードを生成する。HTML プレビューと PNG (Playwright) を出力する。

### 特徴

- **Deterministic**: LLM 依存なしのルールベース変換
- **IR 設計**: Pydantic モデルで型安全
- presenton の LLM 2段階パイプラインとは異なるアプローチ

## Reference 統合への活用

PPTX/PDF をアップロードし、Phase 1 の抽出テキストを Mastra RAG に保存、Phase 2/3 をメタデータとして保存する統合案がある。

## 関連ページ

- [[wiki/google-adk-orchestrator]] -- PPTX 解析を含むマルチエージェント構成
- [[wiki/ai-pptx-generation-overview]] — PPTX 生成（逆方向: データ → PPTX）
- [[wiki/python-pptx]] — 解析の基盤ライブラリ
- [[wiki/pptagent]] — リファレンスベース生成で解析技術を活用
