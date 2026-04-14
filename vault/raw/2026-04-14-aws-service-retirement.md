# AWSサービス終了計画 — Raw Source

Source: https://www.publickey1.jp/blog/26/aws_app_runner430amazon_rds_custom_for_oracle1aws.html
Fetched: 2026-04-14
Feed: Publickey

## 主要な終了サービス

**AWS App Runner**
- ステータス：メンテナンスモードへ移行
- 新規受付停止：2026年4月30日
- 代替手段：「Amazon ECS Express Mode」（2025年12月提供開始）への移行を推奨

**Amazon RDS Custom for Oracle**
- ステータス：サンセット段階
- サービス終了：2027年3月31日
- 特徴：マネージドサービスでありつつホストへのSSH、データベースやOSのカスタマイズが可能な独特なサービス

## その他の影響を受けるサービス

**メンテナンスモード移行（8サービス）**
- Amazon Application Recovery Controller
- Amazon Comprehend（Topic Modeling等の機能）
- Amazon Rekognition（Streaming Events等の機能）
- SNS Message Data Protection
- AWS Audit Manager
- AWS CloudTrail Lake
- AWS Glue Ray Jobs
- AWS IoT FleetWise

**サンセット段階（3サービス）**
- Amazon WorkMail
- Amazon WorkSpaces Thin Client
- AWS Service Management Connector

メンテナンスモードでは「新規ユーザーの受付が停止」される一方、既存ユーザーは継続利用可能。
