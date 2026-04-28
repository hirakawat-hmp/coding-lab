---
type: entity
status: []
tags:
  - infra/aws
  - ai/agent
sources:
  - "https://qiita.com/ryu-ki/items/7437eb2403875bbd3c49"
created: 2026-04-28
updated: 2026-04-28
---

# Amazon Bedrock AgentCore Managed Harness

AWSが提供するAIエージェント構築・デプロイの簡素化サービス。コードを書かずに対話形式でエージェントを作成・デプロイできる。2026年4月22日プレビュー公開。

## 概要

**キャッチフレーズ**：「コードを書くことなく、対話形式で簡単にエージェントを作ることができる」

AgentCore CLI で対話的にエージェントを構築。プロジェクト名、リソース種別、ハーネス設定などを段階的に入力して構成する。

## 対応モデルプロバイダー

| プロバイダー | 備考 |
|------------|------|
| Amazon Bedrock | — |
| OpenAI | — |
| Google Gemini | — |

呼び出し時にモデルをオーバーライド可能。

## 設定オプション

| カテゴリ | 内容 |
|---------|------|
| 環境 | デフォルト / ECR / Dockerfile 指定 |
| メモリー | 有効化・設定 |
| ツール | Browser（ヘッドレス）、Code Interpreter |
| 認証 | IAM 等 |
| ネットワーク | VPC 設定等 |
| ライフサイクル | タイムアウト等 |

## オブザーバビリティ

実行トレースの確認が可能。「エージェント側の実装に集中することができる」設計。

## 制約（プレビュー時点）

- 対応リージョン：us-east-1、us-west-2、eu-central-1、ap-southeast-2
- 必要ランタイム：Node.js 20以上

## 関連

- [[wiki/aws-frontier-agents]] — AWS DevOps Agent / Security Agent
- [[wiki/snapstate]] — AIエージェントの永続状態管理
- [[wiki/openai-agents-sdk-v2]] — OpenAI の類似サービス（Agents SDK）
