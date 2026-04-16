---
type: entity
status: []
tags:
  - ai/agent
  - ai/llm
sources:
  - "https://openai.com/index/the-next-evolution-of-the-agents-sdk"
created: 2026-04-16
updated: 2026-04-16
---

# OpenAI Agents SDK v2（次世代エージェント SDK）

OpenAI が 2026年4月15日に発表した Agents SDK の次世代バージョン。マルチエージェントオーケストレーション・ストリーミング・新ツール統合など大幅強化。

## 主要アップデート

### サンドボックス機能（Sandboxing）
エージェントが制御されたコンピュータ環境内で動作するサンドボックス機能を追加。特定の操作に必要なファイル・コードのみにアクセスし、システム全体の整合性を保護。

### 強化されたハーネス
- 設定可能なメモリ（Configurable Memory）
- サンドボックス対応オーケストレーション
- ファイルシステムツール（文書・システムとの連携）

### サンドボックスプロバイダー統合
Blaxel・Cloudflare・Vercel などの外部サンドボックスプロバイダーと統合。ポータブルなワークスペース記述のための **Manifest 抽象化**を導入。

### 言語サポート
- 最初のリリース: Python
- TypeScript サポート: 後続リリースで計画

## 背景

Responses API と組み合わせることで、コンピュータ環境での自律実行エージェント構築が容易になった。Cloudflare Agent Cloud とも連携（Cloudflare + OpenAI の共同発表）。

## 位置づけ

OpenAI エコシステムにおけるエージェント開発の標準フレームワーク。競合の Anthropic Claude SDK、Google ADK などと競争関係。

## 関連ページ

- [[wiki/snapstate]] — AI エージェントワークフローの永続状態管理
- [[wiki/aws-frontier-agents]] — AWS DevOps Agent / Security Agent
- [[wiki/cloudflare-wrangler-ai]] — Cloudflare エージェント最適化 CLI
- [[wiki/claude-code-routines]] — Anthropic の自動実行 Routines（競合）
