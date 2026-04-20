---
type: entity
status: []
tags:
  - ai/agent
  - tool/mcp
sources:
  - "https://www.publickey1.jp/blog/26/salesforceapiclimcpsalesforce_headless_360.html"
  - "https://www.itmedia.co.jp/aiplus/articles/2604/17/news118.html"
created: 2026-04-20
updated: 2026-04-20
---

# Salesforce Headless 360

TDX 2026 デベロッパーカンファレンスで発表された Salesforce の AI エージェント向けプラットフォーム。Salesforce の全機能を、ブラウザ UI ではなく API/CLI/MCP 経由で AI エージェントがアクセスできるようにする。

## 背景

「なぜ Salesforce にログインする必要があるのか？」という問いが出発点。人間向けに設計された Web UI は AI エージェントにとって「障害」でしかない。

## アクセス方法

| 方法 | 説明 |
|------|------|
| API | REST/GraphQL 経由でのデータ操作 |
| CLI | コマンドラインからの Salesforce 操作 |
| MCP サーバー | LLM から直接 Salesforce 機能を呼び出す |

## 主な機能

- **Skills for Coding Agents** — AI 開発エージェント向けの専用スキルセット
- **フルライフサイクル対応** — 開発・テスト・評価・デプロイ・実験・監視・運用
- **サービス横断** — CRM、データウェアハウス、Slack との統合

## AI エージェント時代のプラットフォーム戦略

Salesforce は世界最大の CRM プラットフォームだが、そのリソースに AI エージェントがアクセスするには従来 UI 操作かカスタム API 実装が必要だった。Headless 360 は Salesforce の全機能を「エージェントネイティブ」にする転換点。

競合他社（HubSpot、Microsoft Dynamics 等）も同様のエージェント対応を強いられる可能性が高い。

## 関連ページ

- [[wiki/cloudflare-artifacts]] — Cloudflare の AI エージェント向けインフラ（同様のトレンド）
- [[wiki/openai-agents-sdk-v2]] — OpenAI の次世代エージェント SDK
- [[wiki/aws-frontier-agents]] — AWS のエージェント化戦略
- [[wiki/mcp-mastra-integration]] — MCP を活用したエージェント統合パターン
