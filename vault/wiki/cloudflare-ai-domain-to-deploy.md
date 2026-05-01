---
type: entity
status: []
tags:
  - infra/cloudflare
  - ai/agent
sources:
  - "https://www.itmedia.co.jp/aiplus/articles/2604/30/news105.html"
created: 2026-05-01
updated: 2026-05-01
---

# Cloudflare × Stripe — AIエージェントによるドメイン取得〜デプロイ自動化

![Cloudflare AI Domain to Deploy](https://image.itmedia.co.jp/aiplus/articles/2604/30/260430tm_cloudflare-1.png)

2026年4月30日にCloudflareとStripeが発表した公開ベータ機能。AIエージェントがドメイン取得・DNS設定・認証・デプロイまでの全プロセスを自動実行できる。クレジットカード番号の入力なしで完結する設計が特徴。

## 概要

従来は人間が手動で行っていたフロー（ドメイン取得→DNS設定→サーバー構成→デプロイ）を、AIエージェントが一気通貫で処理できる最初の実用的な実装例。

## 技術構成

- **Stripe Projects** との統合が中核
- 3段階（登録・認証・デプロイ）で運用を簡素化
- ユーザー認証・決済処理のみ人間が対応（ヒューマン・イン・ザ・ループ）
- Stripe CLIインストール後、基本コマンドで自動化可能

## 意義

[[wiki/cloudflare-wrangler-ai]]で始まったAIエージェント向けCloudflareの進化の延長線上。単なる「AIを使った開発支援」から「AIが独立してインフラを構築・管理する」フェーズへの移行を示す。

## 関連ページ

- [[wiki/cloudflare-wrangler-ai]] — AI エージェント向けCloudflare Wrangler全面再設計
- [[wiki/cloudflare-cf-cli]] — Cloudflare全製品統合CLI「cf」
- [[wiki/cloudflare-artifacts]] — AI エージェント向けGit互換ファイルシステム
- [[wiki/salesforce-headless-360]] — 同様のAPIファーストAIエージェント基盤
