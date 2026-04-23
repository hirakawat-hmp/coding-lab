---
type: entity
status: []
tags:
  - infra/gcp
  - data/analytics
sources:
  - "https://www.publickey1.jp/blog/26/google_cloudrdbspanner_omni.html"
created: 2026-04-23
updated: 2026-04-23
---

# Google Cloud Spanner Omni

![Spanner Omni](https://www.publickey1.jp/2026/spanner-omni-ann01.png)

Googleが[[wiki/google-cloud-next-2026]]でプレビュー公開した、**オンプレミス環境にインストール可能**な大規模分散リレーショナルデータベース（2026年4月22日）。

## 概要

Google Cloud Spannerはこれまでクラウド専用だったが、Spanner OmniはGoogleのオンプレミス向けインフラに再実装したもの。

## 技術的特徴

- **スケール**：単一サーバーから数千台規模のクラスタへ拡張可能
- **パフォーマンス**：ベンチマークで「秒間数百万件のクエリ処理」を実証
- **抽象化**：Google独自のColossusファイルシステムと原子時計技術への依存を抽象化レイヤーで解消。ローカルファイルシステムとの連携でほぼ同等のパフォーマンスを実現
- **統合**：Google Cloudとオンプレミスを同じDBで統一
  - ホット/コールドフェイルオーバー対応
  - AIアプリケーション構築のための共通基盤

## 意義

他クラウドベンダーもローカル展開製品（AWS Outposts、Azure Arc など）を提供しているが、Googleは原子時計ベースの強整合性を特色としてきた。Spanner Omniはその特性をオンプレミスに持ち込む野心的な試みである。

## 関連ページ
- [[wiki/google-cloud-next-2026]] — GCN 2026全体まとめ
- [[wiki/google-agentic-data-cloud]] — Agentic Data Cloud（データ統合側）
- [[wiki/openduck-distributed-duckdb]] — OSS分散DuckDB（競合参考）
