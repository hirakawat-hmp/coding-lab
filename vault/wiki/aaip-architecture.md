---
type: entity
status: []
tags:
  - project/aaas-ai-planner
  - infra/gcp
  - ai/agent
  - framework/mastra
sources:
  - "[[raw/aaip-architecture-investigation-2026-04-06.md]]"
created: 2026-04-06
updated: 2026-04-06
---

# AAIP (AaaS AI Planner) アーキテクチャ

AI 駆動のマーケティング戦略立案・プレゼンテーション生成システム。

## システム構成

| サブシステム | 技術スタック | 規模 |
|---|---|---|
| Next.js App | Next.js 15 + Mastra AI + Jotai | ~33,500行 |
| FastAPI Server | FastAPI + python-pptx | ~2,000行 |
| External Agents | Google ADK + A2A | ~2,000行 |
| RAG Server | Node.js + PgVector + BM25 | ~2,500行 |
| **合計** | | **~41,800行** |

## コア設計パターン

### Agent Network パターン

Planner Agent（Gemini 3 Flash）が中央ルーターとして機能し、6つのサブエージェントに委任する：

- **marketing-expert**: ローカル Mastra Agent（マーケティング知識）
- **tdasim-proxy**: A2A 経由で TDASim Agent（広告効果シミュレーション）
- **scv-norm-proxy**: A2A 経由で SCV Norm Agent（BigQuery 分析）
- **querida-proxy**: A2A 経由で Querida Agent（セグメント分析）
- **chart-proxy**: A2A 経由で Chart Agent（データ可視化、Vega-Lite/ECharts/Matplotlib）
- **cvsim-proxy**: A2A 経由で CVSim Agent

外部エージェントはすべて Google ADK で構築され、A2A プロトコル（JSON-RPC）で通信する。

### 26カード計画システム

4カテゴリ×26種のカードで構成されるワークフロー：

| カテゴリ | カード数 | 例 |
|---|---|---|
| 分析・洞察 | 5 | 市場分析、競合分析、自社分析 |
| 戦略 | 10 | KPI設定、ターゲット分析、メディア戦略 |
| 戦術・メディア | 7 | メディア選定、予算配分、フライト |
| 管理 | 4 | スケジュール、PDCA、サマリ |

各カードは Zod スキーマで出力を検証し、カード間でコンテキストを連鎖させる。

### 3データベースアーキテクチャ

| DB | スキーマ | 用途 |
|---|---|---|
| aaip_auth | auth | ユーザー認証（NextAuth JWT） |
| aaip_dev | app, mastra | メインアプリ + Mastra Memory |
| aaip_rag | public | RAG ベクトルストア + ジョブキュー |

Drizzle ORM の `pgSchema()` で明示的スキーマプレフィックスを付与。

### Dual LLM 戦略

- **Gemini 3 Flash**: 高速処理（チャット、計画、カード生成）
- **GPT-5 (Azure)**: 高品質コンテンツ生成（スライド内容）

### RAG パイプライン

ハイブリッド検索（Vector + BM25 + RRF fusion）にタグベースのアクセス制御を組み合わせ。RAG Server は HTTP API と MCP インターフェースの2つを公開し、Planner Agent は MCP 経由でネイティブツールとして利用する。

## プレゼンテーション生成パイプライン

3ステップの逐次処理：
1. **Outline 生成**: 計画カードからページ構成を生成
2. **Layout 選択**: 各ページに適切なスライドテンプレートを割当
3. **Content 生成**: GPT-5 で詳細なスライド内容を生成

最終的に FastAPI の PPTX Generator で PowerPoint ファイルに変換。

## チャット SSE ストリーミング

Planner Agent Network のストリームは SSE でクライアントに送信。chunk が二重ネスト（`chunk.payload.payload.text`）になるため、API ルートで明示的にアンラップする。

## インフラ（GCP）

- Cloud Run: Next.js, FastAPI, Agents, Phoenix（全サービス）
- Cloud SQL: PostgreSQL 17 + pgvector（1インスタンス、4DB）
- Load Balancer + Cloud Armor（IP 制限）
- Secret Manager（環境ごとのシークレット管理）
- VPC + Cloud NAT（サービス間内部通信）

## 既知の課題

- FastAPI の分析結果がインメモリ保存（コンテナ再起動で消失）
- テストカバレッジが 0%
- SSE の `#### Completion Check` フィルタリングが脆弱（文字列マッチング）
- 非推奨モデルエクスポートが残存

## 関連

- [[wiki/google-adk-orchestrator]] — ADK による A2A マルチエージェント構成
- [[wiki/mcp-mastra-integration]] — Mastra と MCP の統合パターン
- [[wiki/mastra-patterns]] — Mastra フレームワークのパターン
