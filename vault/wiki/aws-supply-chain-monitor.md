---
type: how-to
status: [draft]
tags:
  - security/supply-chain
  - infra/aws
sources:
  - "https://zenn.dev/aeyesec/articles/32fb05ddd1c3f7"
created: 2026-04-21
updated: 2026-04-21
---

# AWS マネージドサービスで作るサプライチェーン攻撃検知システム

AI Security Lab の はるぷ が2026年4月20日に公開した実践ガイド。1日で構築でき、運用コスト「ほぼゼロ」のサプライチェーン攻撃（C&C 通信）検知システム。

## 設計思想

サプライチェーン攻撃は **予防が困難**。侵害後に攻撃者がとる C&C（コマンド＆コントロール）通信を検出する **侵害後検知モデル** が現実的。

> 「100% の完璧な検知を追求して運用が死ぬより、80% を持続可能な形で検知し続ける」

## アーキテクチャ

```
Route 53 Resolver Query Logs  →  (DNS 解決ログ)
          ↓
VPC Flow Logs                 →  (ネットワークトラフィック)
          ↓
Athena                        →  SQL でログ結合・分析（データ移行不要）
          ↓
DynamoDB                      →  承認済み通信先ホワイトリスト
          ↓
Lambda (EventBridge トリガー)  →  相関分析 + 未知通信の抽出
          ↓
Slack 通知
```

## 処理フロー

1. DNS で解決された IP アドレスを記録（Route 53 Resolver ログ）
2. VPC Flow Logs と突き合わせて実際の通信を確認
3. DynamoDB のホワイトリストと照合
4. 未知の通信先を Slack へアラート

## 検知できるもの

- DNS 解決なしに不明 IP への直接通信
- 不審ドメインへの失敗 DNS クエリ
- 通常パターンから外れたトラフィック異常

## 検知できないもの（限界）

- 既存の承認済みドメインを悪用する攻撃
- Route 53 リゾルバーをバイパスした通信（ただしこの場合は DNS 解決なしの IP 通信として検出可能）

## 運用コスト

- インフラコスト: 分析時のみ課金（「ほぼゼロ」）
- 日次工数: Slack 確認 + ホワイトリスト更新で **10分未満**
- 初期チューニング: 数時間でベースライン確立

## 関連ページ

- [[wiki/wordpress-plugin-supply-chain-attack]] — サプライチェーン攻撃の実例（WP プラグイン 30本への一斉バックドア）
- [[wiki/vercel-2026-breach]] — Vercel 2026年セキュリティインシデント（サプライチェーン侵害）
- [[wiki/security-agent-harness]] — セキュリティ分析 AI エージェントのハーネス実践
