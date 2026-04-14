---
type: entity
status: []
tags:
  - ai/agent
  - infra/aws
  - infra/sre
sources:
  - "https://zenn.dev/genda_jp/articles/349257b6d83fd2"
  - "https://aws.amazon.com/devops-agent/"
  - "https://aws.amazon.com/blogs/machine-learning/aws-launches-frontier-agents-for-security-testing-and-cloud-operations/"
created: 2026-04-14
updated: 2026-04-14
---

# AWS Frontier Agents

AWSが2026年3月31日にGA（一般提供開始）したドメイン特化型AIエージェント群。DevOps AgentとSecurity Agentの2種類からなる。

## 定義

AWSは「Frontier Agents」を以下と定義：
> 「独立して目標を達成し、大規模に並列タスクを実行し、数時間〜数日間継続して動作するシステム」

## AWS DevOps Agent

### 機能

- CloudWatch、Datadog、New Relicなど複数監視ツールのデータを横断分析
- インシデントの根本原因を特定し、修正提案をSlack/Webコンソールへ送信
- **修正実行には人間の承認が必須**

### 実績（プレビュー段階）

- MTTR最大75%削減
- 解決速度3〜5倍向上

### 価格

$0.50/分（実行時間のみ課金、2026年4月10日から有料化）

## AWS Security Agent

### 三層機能

| 機能 | 内容 | 価格 |
|------|------|------|
| ペネトレーションテスト | 年1〜2回→継続的テストへ転換 | $50/タスク時間 |
| 設計レビュー | アーキテクチャ段階での脆弱性検出 | 月200件まで無料 |
| PRレビュー | GitHub統合でセキュリティコメント自動投稿 | 月1,000件まで無料 |

### 制限事項

- GitHubのみ対応（GitLab、Bitbucket等は非対応）
- 利用可能リージョン：6つに限定
- Google Cloudは明示的サポート外
- オンプレミスはMCP経由での接続のみ

## SREへの影響

### 変わること

- 深夜アラート時の「ゼロからの調査30分」が削減
- ペネトレーションテストが継続的に実施可能
- PRマージ前のセキュリティレビューが自動化

### 変わらないこと

- 修正実行の最終判断（人間の承認が必須）
- ビジネス判断（「緊急対応か月曜対応か」）
- エージェント出力の正確性を判断するスキル（新たに必要）

### リスク

余裕が生まれた時間を人員削減に充てると、将来の問題対応能力が低下するリスクがある。プロアクティブな改善作業に充てることを推奨。

## 関連ページ

- [[wiki/platform-engineering]] — SREからPlatform Engineeringへの転換
- [[wiki/aws-service-retirement-2026]] — AWS同時期のサービス終了計画
- [[wiki/gaia-local-ai-agent]] — オンプレミス・ローカルのAIエージェント（対比）
- [[wiki/snapstate]] — エージェント状態管理の設計
