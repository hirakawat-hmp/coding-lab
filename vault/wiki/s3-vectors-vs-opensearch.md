---
type: comparison
status: []
tags:
  - ai/rag
  - infra/aws
sources:
  - "https://qiita.com/yakumo_09/items/c1118838c20107db54a9"
created: 2026-05-03
updated: 2026-05-03
---

# S3 Vectors vs OpenSearch：RAGベクトルストア選択ガイド

![S3 Vectors vs OpenSearch](https://qiita-user-contents.imgix.net/https%3A%2F%2Fqiita-image-store.s3.ap-northeast-1.amazonaws.com%2F0%2F3951176%2F2f80ed5f-427b-47a3-9700-7df19bb9e480.png)

AWS の RAG 実装における2大ベクトルストアの比較（2026年5月2日）。

## S3 Vectors（新サービス）

**設計思想：** ストレージ中心、従量課金

| 項目 | 詳細 |
|------|------|
| 最大ベクトル数 | 20億/インデックス |
| レイテンシ | ~100ms〜1秒 |
| コスト（1M ベクトル） | 約1.70ドル/月 |
| ハイブリッド検索 | ✗ |
| アイドル時コスト | 最小限 |

## OpenSearch Serverless

**設計思想：** コンピューティング中心、最低固定コスト

| 項目 | 詳細 |
|------|------|
| レイテンシ | ミリ秒単位 |
| コスト（非冗長構成） | 約173ドル/月 |
| コスト（本番冗長構成） | 約346ドル/月 |
| ハイブリッド検索 | ✓（ベクトル + キーワード） |
| 日本語形態素解析 | ✓ |
| 地理情報フィルタ | ✓ |

## コスト比較

```
1M ベクトルの場合:
S3 Vectors:          $1.70/月
OpenSearch (非冗長): $173/月  ← 約100倍
OpenSearch (本番):   $346/月  ← 約200倍
```

## 選択フローチャート

```
コスト最優先？
├── YES → S3 Vectors
│
└── NO
    ├── リアルタイム（<50ms）？ → OpenSearch
    ├── 日本語検索が必要？ → OpenSearch
    ├── ハイブリッド検索が必要？ → OpenSearch
    ├── 複雑なフィルタが必要？ → OpenSearch
    └── 大規模ストレージ（数十億件）？ → S3 Vectors
```

## 推奨ワークフロー

**段階的移行戦略：** S3 Vectors で始めてコスト検証 → パフォーマンス要件が出たら OpenSearch に移行

この移行が以前より現実的になった理由：両者の API インターフェースが似ており、移行コストが低下した。

**関連ページ:** [[wiki/aws-frontier-agents]] — AWS AI エージェントサービス群
