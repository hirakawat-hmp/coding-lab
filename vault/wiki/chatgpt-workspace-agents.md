---
type: entity
status: []
tags:
  - ai/agent
  - tool/mcp
  - industry/tech
sources:
  - "https://openai.com/index/introducing-workspace-agents-in-chatgpt/"
  - "https://9to5mac.com/2026/04/22/openai-updates-chatgpt-with-codex-powered-workspace-agents-for-teams/"
created: 2026-04-23
updated: 2026-04-23
---

# ChatGPT Workspace Agents

OpenAIが2026年4月22日に発表したエンタープライズ向けAIエージェント機能。**Codexベースで動作する共有エージェント**をチームで作成・管理できる。GPTs の進化版と位置づけられている。

## 主要機能

- **クラウド実行**：ユーザー不在時も継続してバックグラウンドで動作
- **スケジュール実行**：定期的なタスク自動化が可能
- **Slack連携**：Slackからリクエストを受け付けてエージェントが処理
- **ツール接続**：ファイル・スキル・カスタムMCPサーバーを接続可能
- **ガバナンス**：RBAC（ロールベースアクセス制御）・管理者承認・監査ログ・監視・一元管理

## 提供条件

| 項目 | 内容 |
|------|------|
| 対象プラン | Business、Enterprise、Edu、Teachers |
| 無料期間 | 2026年5月6日まで無料 |
| 以降 | クレジット制 |
| 現状 | Research Preview |

## 競合との比較

| 製品 | 提供元 |
|------|--------|
| ChatGPT Workspace Agents | OpenAI |
| [[wiki/gemini-enterprise-agent-platform]] | Google |
| [[wiki/aws-frontier-agents]] | AWS |
| BYO Agent for MS Teams | Microsoft |

## 関連ページ
- [[wiki/openai-agents-sdk-v2]] — OpenAI Agents SDK（開発者向け）
- [[wiki/claude-code-routines]] — Claude Code Routines（類似機能）
- [[wiki/snapstate]] — エージェントの永続状態管理
