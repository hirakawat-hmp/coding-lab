---
type: entity
status: []
tags:
  - ai/rag
  - infra/gcp
  - ai/llm
sources:
  - "https://qiita.com/Tadataka_Takahashi/items/69196e01b021bbf8759d"
created: 2026-05-02
updated: 2026-05-02
---

# Gemini Embedding 2

Googleが2026年4月22日に一般提供開始したマルチモーダル埋め込みモデル。テキスト・画像・動画・音声・PDFを**単一の埋め込み空間にマッピング**できる初のプロダクション対応モデル。

## スペック

| 項目 | 内容 |
|------|------|
| リリース日 | 2026年4月22日（GA） |
| モーダル対応 | テキスト・画像・動画・音声・PDF |
| 出力次元 | 128〜3072次元（推奨：768/1536/3072） |
| 対応言語 | 100以上 |
| 技術 | MRL（Matryoshka Representation Learning） |

## MRL技術の意義

次元削減時に精度低下を最小化する。小さい次元でも高精度を維持できるため、コスト最適化（低次元）と精度優先（高次元）を柔軟に選択できる。

## 5つの主要ユースケース

1. **Agentic Multimodal RAG** — エージェント的推論とマルチモーダル検索の統合
2. **マルチモーダル/ビジュアル検索** — 画像で商品を探す意味的類似検索
3. **記憶・パーソナライズ検索** — 個人メモ間の概念的横断検索
4. **検索結果の再ランキング** — 初期検索後の精度向上
5. **分類・クラスタリング・異常検知** — 非検索型の活用

## 実装のポイント

- **Task prefix を使う：** クエリとドキュメント両方に用途指定（`RETRIEVAL_QUERY`, `RETRIEVAL_DOCUMENT` 等）を付けると精度が向上
- **Batch API 活用：** コスト 50% 削減可能
- **既存ベクトルとの互換性なし：** モデル移行時は再埋め込みが必要

## 関連ページ

- [[wiki/google-cloud-next-2026]] — Google Cloud Next 2026 まとめ（Agentic Enterprise テーマ）
- [[wiki/gemini-enterprise-agent-platform]] — Gemini Enterprise Agent Platform
- [[wiki/rag-mcp-sidecar]] — RAG を Cloud Run サイドカーとして配置する設計
- [[wiki/writeback-rag]] — WriteBack-RAG（自動的にナレッジベースを改善）
