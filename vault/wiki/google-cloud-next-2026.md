---
type: entity
status: []
tags:
  - ai/agent
  - infra/gcp
  - industry/tech
sources:
  - "https://www.itmedia.co.jp/aiplus/articles/2604/23/news061.html"
  - "https://www.publickey1.jp/blog/26/googleaiagent_studioaigemini_enterprise_agent_platform.html"
created: 2026-04-23
updated: 2026-04-23
---

# Google Cloud Next 2026

![Google Cloud Next 2026](https://image.itmedia.co.jp/aiplus/articles/2604/23/yu_gcn.jpg)

Google Cloudが2026年4月22日に開催した年次カンファレンス。「**Agentic Enterprise（エージェンティック・エンタープライズ）**」への移行が主要テーマ。

## 主要発表

### AIエージェント開発プラットフォーム
- **[[wiki/gemini-enterprise-agent-platform]]**：LLMを活用したエージェント開発基盤。Agent Gateway・Agent Identityなどのガバナンス機能を統合
- **Workspace Intelligence**：Google WorkspaceのデータをAIが分析し業務支援を実現

### AIインフラストラクチャ
- **[[wiki/google-tpu-8]]**：学習用「8t」と推論用「8i」の2機種。前世代比3倍性能
- **Virgo Network**：複数のAIデータセンターを連携させる専用ネットワークファブリック

### データ基盤
- **[[wiki/google-agentic-data-cloud]]**：AWS・Azureを含む全クラウドのデータをAIネイティブなデータレイクハウスに統合
- **[[wiki/google-spanner-omni]]**：ローカルマシンにインストール可能な大規模分散RDB

### セキュリティ（Agentic Defense）
- Threat Hunting agent、Detection Engineering agent
- **Wiz AI Application Protection Platform**：AIアプリケーションの脆弱性対策
- **Google Cloud Fraud Defense**：不正検知

## 背景
2025年に続いてAIエージェントの企業活用が主軸。GoogleはNVIDIA製GPUとTPUの両方を提供し、多様なAIワークロードに対応する体制を強化している。

## 関連ページ
- [[wiki/gemini-personal-intelligence]] — Geminiの個人向けRAG機能（2026年4月）
- [[wiki/gemini-robotics-er]] — Gemini Robotics産業向け応用
- [[wiki/aws-frontier-agents]] — AWS DevOps / Security Agent（競合比較）
