---
type: entity
status: []
tags:
  - infra/aws
  - ai/agent
  - ai/eval
sources:
  - "https://qiita.com/leomarokun/items/1ae7df3747a45abbfb84"
created: 2026-05-04
updated: 2026-05-04
---

# Amazon Bedrock AgentCore Optimization

AWSが提供するAIエージェントのプロンプト・設定をデータドリブンに改善するマネージドサービス。2026年4月30日にプレビュー公開。

## 概要

本番稼働中のエージェントのトレースと評価指標を分析し、**コードを変更せずに**システムプロンプトやモデル設定を最適化できる。

## 3つの主要機能

### 1. Configuration Bundles

システムプロンプト・Model ID・ツール説明を**コードとは独立してバージョン管理**する。アプリを再デプロイせずに設定変更が可能。

### 2. Recommendations

本番トレースと評価指標を解析し、AIが**最適化案を自動生成**する。人間が承認した後にBundleとして適用。

### 3. A/B Testing

Gateway経由でリアルタイムトラフィックを分割し、**統計的検証**でどちらの設定が優れているか判定する。

- 統計的有意差判定：p値（p < 0.05で有意）と信頼区間を使用
- 実例：Treatment（0.915）vs Control（0.830）→ p値が0.05を超えたため差は「有意でない」と判定

## 実装フロー

```
1. AgentCore CLIでエージェント作成・デプロイ
2. Configuration Bundleを作成（初期設定）
3. Recommendationsで最適化案を生成・承認
4. Online Evaluationで評価指標を設定
5. A/B testでライブトラフィック検証
6. 勝者Bundleを本番適用
```

## 料金

詳細は未公表（プレビュー中）。同じAmazon Bedrock AgentCoreファミリーの他機能はペネトレーションテスト $50/task-hour で課金。

## 関連ページ

- [[wiki/amazon-bedrock-agentcore]] — Bedrock AgentCore Managed Harness全体の概要
- [[wiki/aws-security-agent-pentest]] — AWS Security Agentによるペネトレーションテスト
- [[wiki/empirical-prompt-tuning]] — AI が自分のプロンプトを評価するループで再現性を向上
