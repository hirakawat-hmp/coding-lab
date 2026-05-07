---
type: entity
status: []
tags:
  - infra/gcp
  - security/web
  - ai/agent
sources:
  - "https://cloud.google.com/blog/products/identity-security/introducing-google-cloud-fraud-defense-the-next-evolution-of-recaptcha/"
created: 2026-05-07
updated: 2026-05-07
---

# Google Cloud Fraud Defense — reCAPTCHA の次世代進化

![Google Cloud Fraud Defense](https://storage.googleapis.com/gweb-cloudblog-publish/images/GCN26_102_BlogHeader_2436x1200_Opt_1_Dark.max-2500x2500.jpg)

Google Cloud が Google Cloud Next '26（2026年4月22日）で発表した次世代詐欺防止プラットフォーム。reCAPTCHA の後継として、AI エージェントが自律的に複雑なトランザクションを実行する「エージェント型 Web」時代向けに設計された。

## 3つのコア機能

### 1. Agentic Activity Measurement
- エージェント活動を計測・分析するダッシュボード
- 業界標準（**Web Bot Auth**・**SPIFEE**）に準拠
- エージェントと人間のアイデンティティを紐付けてリスク・トラストを評価

### 2. Agentic Policy Engine
- リスクスコア・自動化タイプ・エージェント ID・カスタム条件でエージェントとユーザーを許可/ブロック
- ユーザーインタラクションの全旅程（登録→ログイン→決済→チェックアウト）で制御

### 3. AI-Resistant Challenge
- **QR コードベースの新チャレンジ**（従来のパズルに代わる人間存在証明）
- バックグラウンドの静かな検証で正規ユーザーには不可視
- 自動化詐欺を経済的に不採算にする

## 成果指標

| 指標 | 数値 |
|------|------|
| アカウント乗っ取り（ATO）削減 | 平均51% |
| 保護対象 Fortune 100 | 50% |
| 保護ドメイン数 | 1,400万以上 |

## reCAPTCHA からの移行

- **移行不要**：既存 reCAPTCHA 顧客は何もしなくてよい
- 既存のサイトキーと統合はそのまま
- **価格変更なし**

## 意義

従来の CAPTCHA（bot vs. human の二項対立）から、AI エージェントの爆発的増加に対応した「正規 AI エージェントは許可しつつ悪意ある自動化をブロックする」新パラダイムへの移行を示す。

## 関連ページ

- [[wiki/google-cloud-next-2026]] — Google Cloud Next '26 全体まとめ
