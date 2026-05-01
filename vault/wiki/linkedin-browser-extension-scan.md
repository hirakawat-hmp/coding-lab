---
type: insight
status: []
tags:
  - security/privacy
  - industry/tech
  - policy/regulation
sources:
  - "https://404privacy.com/blog/linkedin-is-scanning-your-browser-extensions-this-is-how-they-use-the-data/"
created: 2026-05-01
updated: 2026-05-01
---

# LinkedInが6,278種のブラウザ拡張をスキャン — APFC指紋採集の実態

404 Privacyが発見。LinkedInはChromeユーザーがインストールしているブラウザ拡張機能を、ユーザーの同意なく収集している。検出した6,278種の拡張情報を暗号化してすべてのLinkedIn APIリクエストに付加している。

## 技術的手法

`chrome-extension://` プロトコルを利用して特定ファイルへのリクエストを送信:

- 拡張が**インストールされていない**場合: Chromeがブロック→エラーログに「LinkedInがスキャンした」と記録
- 拡張が**インストールされている**場合: リクエストが静かに成功→LinkedInがインストールを記録

## リスクの深刻さ

LinkedInはすでに本人確認済みの職業情報を持っているため、拡張スキャン結果との紐付けにより:

| 拡張カテゴリ | 漏洩するシグナル |
|-------------|----------------|
| 政治関連 | 政治活動・思想 |
| 宗教関連 | 宗教的実践 |
| 障害対応ツール | 健康・障害状況 |
| 求人検索（数百種） | 転職活動状況 |

## デバイスフィンガープリンティング

**APFC**（Aggregated Profile Fingerprinting Cache）と呼ばれるシステムの一部。ブラウザ・デバイスの48種の特性を監視する大規模プロファイリングシステム。

## 規制当局の対応

バイエルン州で**刑事捜査開始**（デジタル市場法：Digital Markets Act違反の疑い）。

## 示唆

[[wiki/flock-lpr-privacy]]（ナンバープレート追跡）や[[wiki/meta-employee-keylogging]]（Metaの社員データ収集）と同様に、プラットフォーム企業による「ユーザーが気付かない監視」の問題。AI時代において個人プロファイリングの精度と範囲が急拡大している。

## 関連ページ

- [[wiki/flock-lpr-privacy]] — Flock LPRのプライバシー問題
- [[wiki/meta-employee-keylogging]] — Meta社員のデータ強制収集
- [[wiki/google-ice-data-surveillance]] — GoogleのICEデータ提供事件
- [[wiki/online-age-verification-privacy]] — オンライン年齢確認と監視インフラ
