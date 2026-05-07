# Val Town: Supabase → Clerk → Better Auth への認証移行

Source: https://blog.val.town/better-auth
Retrieved: 2026-05-07
Author: Tom MacWright
Published: 2026-05-06

## 移行の概要

Val Town が2度目の認証システム大改修を完了。Clerk から Better Auth へ移行（2023年に Supabase から Clerk へ移行済み）。

## Clerk の主な問題点

### アーキテクチャの不一致
Clerk の哲学は専用ユーザーテーブルを完全に置き換えること（"Consider dropping your users table" という思想）。
Val Town のようにソーシャル機能（アバター表示、ユーザー情報）を多用するサービスには根本的に合わない。

### レート制限の問題
Clerk の API はアカウント全体で「毎秒5リクエスト」という厳しい制限。
コンテンツフィードで大量のユーザー情報を表示する際、常にレート制限に引っかかる。

### 単一障害点
すべてのセッションリフレッシュが Clerk を経由するため、Clerk がダウンするとログインユーザー全員がアクセス不能に。

## Clerk を3年間維持した理由

- 認証ソリューションの選択肢が少ない（OSS は古い）
- 切り替えコストが高い
- シンプルなフロントエンド向けアプリでは Clerk は優れている

## Better Auth の優位点

- OSS で独立稼働可能
- ローカルでセッション管理（第三者のアップタイムに依存しない）
- 2週間の並行移行をサポート
- Val Town のエコシステムとの親和性

## 重要な教訓

「信頼性はその重要パーツの信頼性の最小値」—— 認証をローカルで制御することの重要性
