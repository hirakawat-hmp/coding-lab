---
tags:
  - concept
sources:
  - "/Users/hdymacuser/Desktop/atl-document-generator/.serena/memories/design/rag-mcp-sidecar.md"
created: 2026-04-06
updated: 2026-04-06
---

# RAG MCP サイドカー設計

RAG (Retrieval-Augmented Generation) を Next.js から独立した MCP サーバーに分離し、Cloud Run サイドカーとして配置するアーキテクチャ。

## 目的

1. Vector-only から Hybrid Search（Vector + BM25 + RRF fusion）への移行
2. ヘディングパスプレフィックスによる文脈保持チャンキング
3. pdfplumber から Gemini マルチモーダル PDF 変換への移行
4. ADK（Agent Development Kit）移行に備えた関心の分離

## アーキテクチャ

```
Cloud Run サイドカー構成:
  Next.js (port 8080) <---> RAG MCP Server (port 3100)
                                    |
                              PostgreSQL (aaip_rag)
                              - embedding vector(768)
                              - metadata JSONB
                              - tsv tsvector
```

Next.js は RAG DB に直接接続しない。全ての RAG 操作は MCP サーバー経由。

## インターフェース

### REST API

| エンドポイント | 用途 |
|---------------|------|
| `POST /api/ingest` | ドキュメント取り込み |
| `POST /api/search` | ハイブリッド検索 |
| `DELETE /api/documents/{fileId}` | ドキュメント削除 |

### MCP Tool

- `rag_search`: Agent 向けに公開。検索用
- `rag_ingest`: MCP 非公開（REST API のみ）

## Hybrid Search

Vector Search と BM25 を組み合わせ、RRF (Reciprocal Rank Fusion) でスコア統合する。

### Vector Search
- PgVector を使用
- topK x 3 で候補取得

### BM25
- bigram tokenize で CJK 対応
- tsvector を使用
- 例: 「チューリッヒ」 → 「チュ ュー ーリ リッ ッヒ」

### RRF Fusion
```
score = Sum(1 / (k + rank))  (k = 60)
```

## PDF -> Markdown 変換

Gemini Files API でアップロード後、generateText で構造化 Markdown に変換。ヘディングは記述的に付ける（「## スライド5」ではなく「## 全体売上サマリー」）。

## アクセス制御

- 認証・認可は Next.js が担当
- RAG Server は渡された tagIds を信頼してフィルタリング
- tagIds が空の場合は結果なし（安全側に倒す）

## ディレクトリ構成

```
rag-server/src/
├── server.ts, config.ts
├── api/router.ts
├── parser/extract.ts, gemini.ts
└── rag/db.ts, embed.ts, store.ts, chunk.ts, ingest.ts, search.ts, bm25.ts, fusion.ts
```

## 実装フェーズ

1. RAG Server 基盤
2. コア RAG ロジック（Vector + BM25 + Fusion）
3. Ingest パイプライン（PDF -> Markdown -> Chunk -> Embed -> Store）
4. Next.js 側接続
5. デプロイ（Dockerfile, Cloud Build, サイドカー YAML）

## 未決事項

- PPTX 処理: FastAPI 維持 or PDF 変換 -> Gemini
- Embedding モデル: gemini-embedding-001 vs text-embedding-005
- 既存チャンク再生成 or FTS バックフィルのみ
- RAG Server リソース配分: CPU/メモリ比率
- MCP transport: SSE or stdio

## 関連ページ

- [[wiki/cloud-run-fastapi-deploy]] -- Cloud Run デプロイの汎用パターン
- [[wiki/mcp-mastra-integration]] -- MCP プロトコルの活用パターン
