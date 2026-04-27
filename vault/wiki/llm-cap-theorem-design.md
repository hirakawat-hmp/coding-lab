---
type: concept
status: []
tags:
  - ai/llm
  - ai/agent
  - industry/tech
sources:
  - "https://zenn.dev/hsaki/articles/llm-cap-theorem"
created: 2026-04-27
updated: 2026-04-27
---

# LLM の CAP 定理

分散システムの CAP 定理（Consistency / Availability / Partition Tolerance）の概念を LLM アプリケーション設計に転用したフレームワーク。3 要素を同時に満たすことはできないというトレードオフを設計判断の軸にする。

## LLM における 3 要素

| 要素 | 説明 |
|------|------|
| **C（一貫性）** | 全ユーザーに同一モデルを使用して出力品質を安定化する |
| **A（可用性）** | TPM/RPM のクオータ制限を回避し、LLM が継続的に応答できる |
| **P（価格）** | 安価なコストで LLM を利用できる |

## 3 つの戦略パターン

### CA を選ぶ（高品質 + 高可用性）
Reserved Tier や Provisioned Throughput で容量を確保。コストが大幅に増加する。企業規模のプロダクション向け。

### CP を選ぶ（高品質 + 低コスト）
単一モデルの従量課金を使う。RPM/TPM を超過すると 429 エラーが発生して可用性が低下する。小規模・低トラフィック向け。

### AP を選ぶ（高可用性 + 低コスト）
複数モデルでフォールバック構成し、クォータ超過時に別モデルへ切り替える。「モデルの出力品質が一貫しなくなる」トレードオフがある。

## スループット型 SLI という本質的な違い

従来のバックエンドシステム:
- **数値型 SLI**: リクエスト成功率、エラーレート → お金を積めばスケールアウトで解決

LLM アプリケーション:
- **スループット型 SLI**: TPM（Tokens per Minute）/ RPM（Requests per Minute） → クォータは API プロバイダが管理し、「物理的にスケールアウトできない」

これがビジネス意思決定（どの戦略パターンを選ぶか）をエンジニアリング設計に直接結びつける理由。

## 設計への適用

1. ユーザーセグメント別に C/A/P の優先度を決める（例: 有料ユーザーは CA、フリーユーザーは AP）
2. SLO を「成功率」ではなく「スループット」で定義する
3. フォールバック先モデルを選定する際は出力品質の差異を事前に評価する

## 関連ページ

- [[wiki/platform-engineering]] — 「努力」から「仕組み」へ変える Platform Engineering
- [[wiki/writeback-rag]] — LLM の知識蓄積を自動改善する WriteBack-RAG
