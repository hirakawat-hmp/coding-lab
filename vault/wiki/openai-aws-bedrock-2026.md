---
type: entity
status: []
tags:
  - ai/llm
  - ai/agent
  - infra/aws
  - industry/tech
sources:
  - "https://openai.com/index/openai-on-aws"
  - "https://aws.amazon.com/about-aws/whats-new/2026/04/bedrock-openai-models-codex-managed-agents/"
  - "https://www.cnbc.com/2026/04/28/openai-brings-models-to-aws-after-ending-exclusivity-with-microsoft.html"
created: 2026-04-29
updated: 2026-04-29
---

# OpenAI × AWS Bedrock 提携拡大（2026年4月）

2026年4月28日、OpenAI と AWS は戦略的パートナーシップを拡大し、Amazon Bedrock 上で OpenAI のモデル・Codex・Managed Agents を提供開始（Limited Preview）と発表した。Microsoft との独占契約終了の翌日という象徴的なタイミングでの発表。

## 3つの新オファリング

### 1. OpenAI Models on Bedrock
GPT-5.5 をはじめとするフロンティアモデルを Bedrock の標準 API から利用可能になる。AWS の既存エンタープライズ統制（IAM・PrivateLink・Guardrails・暗号化・CloudTrail）をそのまま継承。

### 2. Codex on Bedrock
週次 400万人超が利用する OpenAI のコーディングエージェントを AWS 環境に展開できる。コード自動化・リファクタリング・テスト生成・ソフトウェア配信加速に活用。

### 3. Bedrock Managed Agents（powered by OpenAI）
OpenAI エージェントハーネスを活用した本番対応エージェントを AWS 上で素早くデプロイできる。長時間タスクの確実な遂行・高速推論に最適化。

## 戦略的文脈

- Microsoft との独占的提携終了（[[wiki/microsoft-openai-2026-partnership]]）の翌日に発表
- OpenAI が実質的なマルチクラウド戦略に移行した最初の重大シグナル
- AWS 側は既存の [[wiki/amazon-bedrock-agentcore]] にも OpenAI エージェント技術が統合される見通し
- Anthropic–Amazon の大規模投資（[[wiki/anthropic-amazon-100b]]）と競合する構図が鮮明に

## 類似サービスとの比較

| | OpenAI on Bedrock | Anthropic on Bedrock |
|---|---|---|
| モデル | GPT-5.5等 | Claude 4.x系 |
| エージェント | Codex, Managed Agents | AgentCore |
| ステータス | Limited Preview (2026-04) | GA |

## 関連ページ

- [[wiki/microsoft-openai-2026-partnership]] — 独占契約終了の経緯
- [[wiki/amazon-bedrock-agentcore]] — AWS のエージェント実行環境
- [[wiki/anthropic-amazon-100b]] — Anthropic-Amazon パートナーシップ（競合軸）
- [[wiki/openai-codex-enterprise]] — Codex エンタープライズ展開
- [[wiki/openai-symphony]] — OpenAI エージェントオーケストレーション OSS
