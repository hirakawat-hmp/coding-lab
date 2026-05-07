---
type: insight
status: []
tags:
  - dev/typescript
  - security/web
  - industry/tech
sources:
  - "https://blog.val.town/better-auth"
created: 2026-05-07
updated: 2026-05-07
---

# Val Town の認証遍歴：Supabase → Clerk → Better Auth

Val Town（JavaScript サンドボックスサービス）が2度目の認証システム大改修を完了。Tom MacWright による技術的教訓として、SaaS 認証プロバイダー選定の重要な知見を提供する事例。

## 移行の歴史

| 時期 | 変更 | 理由 |
|------|------|------|
| 2023年 | Supabase → Clerk | Supabase の認証機能に限界 |
| 2026年 | Clerk → Better Auth | Clerk のアーキテクチャ的不一致 |

## Clerk の失敗理由

### 1. アーキテクチャの根本的不一致
Clerk の思想：「ユーザーテーブルを廃止せよ（Consider dropping your users table）」

Val Town のようにソーシャル機能（アバター・フォロー・コンテンツフィード）が豊富なサービスには根本から合わない。ユーザー情報を頻繁に参照する UI では、自社 DB でユーザーデータを管理することが不可欠。

### 2. 厳しいレート制限
Clerk API の制限：**アカウント全体で毎秒5リクエスト**

コンテンツフィードにアバターを表示するだけで、何十もの API コールが発生。限界に達することが常態化。

### 3. 単一障害点
すべてのセッションリフレッシュが Clerk サーバーを経由するため、Clerk のダウン = ログインユーザー全員がアクセス不能。

> "reliability is the _minimum_ of the combined reliability of its critical parts"
> （信頼性はその重要パーツの信頼性の最小値）— Tom MacWright

### 4. 3年間維持した理由
- 認証ソリューションの OSS 選択肢が少ない（多くは古い）
- 切り替えコストが高い
- Clerk 自体はシンプルなフロントエンドアプリには優れている

## Better Auth の優位点

- OSS で独立稼働可能（Clerk サーバーへの依存ゼロ）
- セッションをローカルで管理
- 2週間の**並行移行**サポート（両方のシステムを同時運用してリスク分散）

## 教訓

1. **認証は core business logic に近い**ほど、外部 SaaS への依存リスクが高まる
2. **ソーシャル機能が多いサービス**は、自社 DB でユーザーデータを持つことが必須
3. **外部認証 SaaS の採用前**に「ユーザーアバターを100個表示するコストは？」をシミュレーションすべき
