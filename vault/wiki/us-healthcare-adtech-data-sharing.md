---
type: insight
status: []
tags:
  - security/privacy
  - security/incident
  - policy/regulation
created: 2026-05-05
updated: 2026-05-05
sources:
  - "https://techcrunch.com/2026/05/04/us-healthcare-marketplaces-shared-citizenship-and-race-data-with-ad-tech-giants/"
---

# 米医療保険マーケットプレイス — 市民権・人種データを広告Techに送信

![医療データプライバシー](https://techcrunch.com/wp-content/uploads/2026/05/pixel-mouse-2217637165.jpg)

Bloomberg調査により、20の州政府運営医療保険マーケットプレイスのほぼすべてが、ピクセルトラッキングを通じてGoogle・Meta・TikTok・LinkedIn・Snapなどのアドテク大手に市民権・人種・収監状況などの個人情報を送信していたことが判明。

## 流出した情報カテゴリ

- 市民権のステータス（citizenship status）
- 人種・民族情報
- 家族の収監状況
- メールアドレス・電話番号・ZIP コード

## 影響範囲

- 州の医療保険マーケットプレイスを年間利用する約700万人のアメリカ人
- 影響を受けた州：New York、Washington D.C.、Virginia など多数

## 政府の対応

| 州 | 対応 |
|----|------|
| Washington D.C. | TikTokトラッカーを一時停止 |
| Virginia | Metaのトラッカーを削除 |

## 技術的メカニズム

アナリティクス用途で広く使われるピクセルトラッカーが、保護情報を含む医療サイト上で**誤設定**された。テレヘルスや医療機関での類似インシデントが繰り返されるパターン。

## 示唆

「匿名のアナリティクスのつもりがセンシティブデータの流出」という問題は、ヘルスケア分野でも繰り返される構造的問題。HIPAA準拠とアドテク活用の両立は技術的にも法的にも難しい。

## 関連ページ

- [[wiki/flock-lpr-privacy]] — Flock LPR プライバシー問題
- [[wiki/linkedin-browser-extension-scan]] — LinkedIn ブラウザ拡張スキャン問題
- [[wiki/online-age-verification-privacy]] — 年齢確認と全国民監視インフラ
- [[wiki/google-ice-data-surveillance]] — Google/ICE データ提供問題
