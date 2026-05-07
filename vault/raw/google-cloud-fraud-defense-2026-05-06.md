# Google Cloud Fraud Defense: reCAPTCHA の次世代進化

Source: https://cloud.google.com/blog/products/identity-security/introducing-google-cloud-fraud-defense-the-next-evolution-of-recaptcha/
Retrieved: 2026-05-07
Header Image: https://storage.googleapis.com/gweb-cloudblog-publish/images/GCN26_102_BlogHeader_2436x1200_Opt_1_Dark.max-2500x2500.jpg

## 概要

Google Cloud が Google Cloud Next '26（2026年4月22日）で「Google Cloud Fraud Defense」を発表。reCAPTCHA の次世代版で、エージェント型 Web（自律 AI エージェントが複雑なトランザクションを実行する世界）向けに設計された包括的なトラストプラットフォーム。

## 主な機能

### 1. Agentic Activity Measurement
- エージェント活動を計測・理解するダッシュボード
- 業界標準（Web Bot Auth・SPIFEE）に準拠
- エージェントと人間のアイデンティティを結びつけてリスク・トラストを評価

### 2. Agentic Policy Engine
- リスクスコア・自動化タイプ・エージェント ID に基づいてエージェントとユーザーを許可/ブロック
- ユーザーインタラクションの全旅程で粒度の細かい制御

### 3. AI-Resistant Challenge
- QRコードベースの新チャレンジ（従来のパズルを置き換え）
- 人間の存在証明を要求
- 自動化詐欺を経済的に不採算にする設計

## 主なメリット

- アカウント乗っ取り（ATO）を平均51%削減
- Fortune 100 企業の50%、1,400万以上のドメインを保護するGoogleの詐欺インテリジェンス活用
- 正規ユーザーには不可視（バックグラウンドで静かに検証）
- 正規の AI エージェントは許可しつつ、悪意ある自動化をブロック

## 移行

- 既存の reCAPTCHA 顧客は移行不要
- 既存のサイトキーと統合はそのまま利用可能
- 価格変更なし
