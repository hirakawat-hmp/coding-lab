---
type: reference
status: [draft]
tags:
  - infra/aws
sources:
  - "https://www.publickey1.jp/blog/26/aws_app_runner430amazon_rds_custom_for_oracle1aws.html"
created: 2026-04-14
updated: 2026-04-14
---

# AWSサービス終了計画（2026年）

AWSが2026年に発表した複数サービスの終了・メンテナンスモード移行計画のまとめ。

## 主要終了サービス

### AWS App Runner

| 項目 | 内容 |
|------|------|
| 新規受付停止 | 2026年4月30日 |
| ステータス | メンテナンスモード移行 |
| 代替手段 | Amazon ECS Express Mode（2025年12月提供開始） |

App Runnerはコンテナをシンプルにデプロイできるサービスだったが、ECS Express Modeに機能が統合される形での廃止。

### Amazon RDS Custom for Oracle

| 項目 | 内容 |
|------|------|
| サービス終了 | 2027年3月31日 |
| 特徴 | マネージドサービスでありつつSSH・カスタマイズ可能という独特のポジション |

## メンテナンスモード移行（8サービス）

新規ユーザー受付停止、既存ユーザーは継続利用可能。

| サービス | 備考 |
|---------|------|
| Amazon Application Recovery Controller | 可用性管理 |
| Amazon Comprehend（一部機能） | Topic Modeling等 |
| Amazon Rekognition（一部機能） | Streaming Events等 |
| SNS Message Data Protection | メッセージ保護 |
| AWS Audit Manager | 監査自動化 |
| AWS CloudTrail Lake | ログ分析 |
| AWS Glue Ray Jobs | 分散処理 |
| AWS IoT FleetWise | 車両データ収集 |

## サンセット段階（3サービス）

| サービス | 内容 |
|---------|------|
| Amazon WorkMail | メール・カレンダー |
| Amazon WorkSpaces Thin Client | シンクライアント端末 |
| AWS Service Management Connector | ServiceNow等との連携 |

## 傾向

AWSがスリム化を進めており、クラウドネイティブなアーキテクチャへの集約が続いている。独自のニッチポジションを持つサービスは廃止され、主力サービスへの統合が進む。

## 関連ページ

- [[wiki/aws-frontier-agents]] — AWS DevOps/Security Agent（新規GAサービス）
- [[wiki/cloud-run-fastapi-deploy]] — GCPコンテナデプロイ（比較参考）
