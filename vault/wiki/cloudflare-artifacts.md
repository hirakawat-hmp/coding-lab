---
type: entity
status: []
tags:
  - infra/cloudflare
  - ai/agent
  - tool/mcp
sources:
  - "https://www.publickey1.jp/blog/26/cloudflareaicloudflare_artifactsgitrestful_api.html"
created: 2026-04-20
updated: 2026-04-20
---

# Cloudflare Artifacts

Cloudflare が発表した AI エージェント専用ファイルシステム。2026年5月初旬にパブリックベータ予定。

## 概要

従来のファイルシステムは人間ユーザー向けに設計されているが、Cloudflare Artifacts は**自律的に動作する AI エージェントのワークフロー**に特化して設計されている。

## 主要機能

### Git 互換性
- コミット、ブランチ、フォークをネイティブサポート
- ほとんどの AI モデルは Git をよく知っているため、追加ツール不要
- 数百〜数千の AI エージェントが同時にコードを生成・編集・フォークする規模に対応

### アクセス方法
1. **Git クライアント** — 既存の Git ワークフロー
2. **RESTful API** — プログラマティックアクセス
3. **Cloudflare Workers API** — Workers エコシステムとの統合

### 対応データ型
- コード
- 設定ファイル
- セッション履歴
- 状態管理データ

## 設計思想

「AI エージェントが最も馴染みのある道具（Git）でファイルを管理できるようにする」というアプローチ。Cloudflare の AI エージェントエコシステム（Wrangler の AI 対応化、Email Service 等）の一部として位置づけられる。

## AI エージェント時代のインフラとして

[[wiki/cloudflare-cf-cli]] の全サービス CLI 化構想と合わせて、Cloudflare は AI エージェントが「Cloudflare を土台として動作する」世界を積極的に構築中。

## 関連ページ

- [[wiki/cloudflare-cf-cli]] — Cloudflare 全製品対応 CLI「cf」
- [[wiki/cloudflare-wrangler-ai]] — AI エージェント向け Wrangler 再設計
- [[wiki/snapstate]] — AI エージェントワークフローの永続状態管理（類似コンセプト）
- [[wiki/salesforce-headless-360]] — 同じく AI エージェント向けプラットフォーム再設計のトレンド
