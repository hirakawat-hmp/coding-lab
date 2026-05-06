---
type: comparison
status: []
tags:
  - ai/llm
  - ai/rag
sources:
  - "https://qiita.com/TOMOSIA-LinhND/items/8ff4b27c4d9097380c18"
created: 2026-05-06
updated: 2026-05-06
---

# Docling vs MarkItDown：GenAI向けドキュメント処理ツール比較

LLM・RAGシステム向けにドキュメントをMarkdownに変換するOSSツール2種の比較。IBM製DoclingとMicrosoft製MarkItDownはアーキテクチャ哲学が根本的に異なる。

## 概要比較

| 観点 | Docling（IBM製） | MarkItDown（Microsoft製） |
|------|----------------|------------------------|
| アーキテクチャ | ローカルVLP処理・データセキュリティ重視 | 軽量コア・複雑分析はLLM APIに委任 |
| セキュリティ | 完全オフライン動作・外部送信なし | 画像をクラウドAPIに送信 |
| 表・数式精度 | 複雑レイアウトでも高安定 | 接続Vision APIの品質に依存 |
| フォーマット対応 | 学術論文・報告書・構造化文書 | MP3・ZIP・HTML・YouTube字幕等の多様な形式 |
| ハードウェア | RAM・処理能力を大量消費 | 軽量（Vision機能はAPIコスト発生） |
| 主な用途 | 高精度・高機密文書処理 | 多様フォーマットの統合パイプライン |

## Docling が最適なケース

- 厳格な機密要件を持つ複雑な学術・財務文書の大量処理
- 外部API使用が禁止されたオンプレミス環境
- 複雑な表・数式の精度が重要な場合

## MarkItDown が最適なケース

- スプレッドシート・音声・動画トランスクリプト等の多様なフォーマットを統合
- 既存ワークフローへのCLI統合が必要
- Azure/OpenAI APIを既に活用中の組織

## 選択の指針

```
if 機密データ or 複雑な表/数式が重要:
    → Docling
elif 多様なフォーマット対応 or 軽量CLI統合:
    → MarkItDown
```

## 関連ページ

- [[wiki/s3-vectors-vs-opensearch]] — RAGインフラ選択（S3 Vectors vs OpenSearch）
- [[wiki/writeback-rag]] — WriteBack-RAG 知識ベース自動改善
