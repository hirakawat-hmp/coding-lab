---
type: entity
status: []
tags:
  - infra/gcp
  - data/analytics
  - ai/agent
sources:
  - "https://www.publickey1.jp/blog/26/googleawssaasaiagent_data_cloud.html"
created: 2026-04-23
updated: 2026-04-23
---

# Google Agentic Data Cloud

Googleが[[wiki/google-cloud-next-2026]]で発表した、**AWS・Azure・GCP上のあらゆるデータソースをAIネイティブなデータレイクハウスに統合**するデータ基盤（2026年4月22日）。

## 主要機能

- **ユニバーサルコンテキストエンジン**：AIエージェントに信頼性の高いビジネスコンテキストを提供
- **Cross-Cloud Lakehouse**：複数クラウドのデータをシームレスにアクセス（データをコピーせず参照）
- **Apache Icebergフォーマット**：オープンフォーマットによるクラウド間互換性
- **ナレッジカタログ**：非構造化データからエンティティ情報を自動抽出
- **Smart Storage**：データ管理・活用の効率化

## 外部連携

Databricks Unity Catalog、AWS Glue Data Catalog、Snowflake Polaris などの外部カタログとも統合。

## 意義

これまで「データのサイロ化」が企業AIエージェントの最大の障壁だった。Agentic Data Cloudはデータをコピーせず、元の場所に存在したまま全クラウドにまたがってAIが参照できる仕組みを目指す。

## 関連ページ
- [[wiki/google-cloud-next-2026]] — GCN 2026全体まとめ
- [[wiki/google-spanner-omni]] — Spanner Omni（オンプレRDB）
- [[wiki/gemini-enterprise-agent-platform]] — エージェント開発側の基盤
- [[wiki/writeback-rag]] — ナレッジベース自動改善パターン
