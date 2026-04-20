---
type: insight
status: []
tags:
  - security/web
  - security/supply-chain
sources:
  - "https://www.bleepingcomputer.com/news/security/vercel-confirms-breach-as-hackers-claim-to-be-selling-stolen-data/"
  - "https://vercel.com/kb/bulletin/vercel-april-2026-security-incident"
created: 2026-04-20
updated: 2026-04-20
---

# Vercel 2026年4月 セキュリティインシデント

![Vercel 2026 Security Incident](https://www.bleepstatic.com/content/hl-images/2026/04/19/vercel-header-lg.jpg)

2026年4月19日、Vercel がセキュリティインシデントを公式に認め、内部システムへの不正アクセスが確認された。

## 侵害の経路

サプライチェーン経由の侵害が特徴的。攻撃者はサードパーティ AI ツール **Context.ai** の従業員 Google Workspace アカウントを侵害し、そこから Vercel 環境へのアクセスを段階的に拡大した。

## 流出したデータ

- **環境変数**（"sensitive" フラグのないもの：平文保存）
  - API キー（NPM トークン、GitHub トークン含む）
  - データベース認証情報
  - デプロイ用アクセス認証情報
- **従業員情報** 580 件：名前、Vercel メールアドレス、アカウントステータス、タイムスタンプ

Vercel は「顧客の環境変数はすべて暗号化して保存している」と説明しているが、sensitive フラグなしの変数は列挙攻撃で取得可能だった。

## 攻撃者と要求

脅威アクター「ShinyHunters」がハッキングフォーラムに投稿し、Telegram 経由で 200万ドルの身代金を要求した疑いがある。盗まれたデータはダークウェブで販売試みが確認された。

## 影響範囲

- **限定的**: 一部の顧客のみ
- **コアサービスは無事**: Next.js、Turbopack、オープンソースプロジェクトは未影響

## 推奨対応

1. 環境変数を見直し、機密情報には "sensitive" フラグを付ける
2. 全シークレット（APIキー、DBパスワード等）を即時ローテーション
3. GitHub トークン、NPM トークンを無効化して再発行

## 教訓：サプライチェーンリスク

今回の侵害はVercel自身のシステム脆弱性ではなく、**使用している外部 AI ツール（Context.ai）経由**だった。SaaS サービスが AI ツールと統合するほど、サプライチェーン攻撃の表面積が広がる。

サードパーティへの OAuth スコープを最小化し、接続している AI ツールのアクセス権を定期的に監査することが重要。

## 関連ページ

- [[wiki/wordpress-plugin-supply-chain-attack]] — サプライチェーン攻撃の類似事例
- [[wiki/google-apikey-gemini-billing]] — API キー流出インシデントの教訓
- [[wiki/claude-code-security-incidents]] — Claude Code 経由のセキュリティ事故
- [[wiki/mcp-security-vulnerability-2026]] — MCP のシステム的脆弱性
