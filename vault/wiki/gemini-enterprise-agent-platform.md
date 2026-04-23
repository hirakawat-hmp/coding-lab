---
type: entity
status: []
tags:
  - ai/agent
  - infra/gcp
  - tool/mcp
sources:
  - "https://www.publickey1.jp/blog/26/googleaiagent_studioaigemini_enterprise_agent_platform.html"
created: 2026-04-23
updated: 2026-04-23
---

# Gemini Enterprise Agent Platform

![Gemini Enterprise Agent Platform](https://www.publickey1.jp/2026/gemini-enterprise-angent-platform-gcn04.png)

Googleが[[wiki/google-cloud-next-2026]]で発表した、AIエージェントの開発・運用・管理を一気通貫で提供する企業向けプラットフォーム（2026年4月22日）。

## コンポーネント構成

| コンポーネント | 用途 |
|---|---|
| **Agent Studio** | ローコード・ビジュアル開発ツール |
| **ADK（Agent Development Kit）** | コードベースのエージェント開発フレームワーク |
| **Agent Engine** | エージェント実行環境（マネージド） |
| **Agent Gateway** | ガバナンス・ルーティング層 |
| **Agent Identity** | エージェント単位の認証・認可 |

## 特徴

- **マルチモデル対応**：Gemini・Gemma・Llama・Mistral・Claude・Deepseek など多様なモデルを選択可能
- **エコシステム**：ツールレジストリ・スキルレジストリ・マーケットプレイスで再利用性を担保
- **接続性**：データベース・SaaS・ドキュメントストアなど全データソースへのアクセス
- **セキュリティ**：アイデンティティ管理・可観測性・ポリシー管理を統合

## 競合ポジション
- AWS：[[wiki/aws-frontier-agents]]（DevOps Agent / Security Agent）
- OpenAI：[[wiki/chatgpt-workspace-agents]]（Workspace Agents）
- Microsoft：BYO Agent for MS Teams

## 関連ページ
- [[wiki/google-cloud-next-2026]] — GCN 2026全体まとめ
- [[wiki/google-agentic-data-cloud]] — データ基盤側の発表
- [[wiki/snapstate]] — AIエージェントワークフローの永続状態管理
