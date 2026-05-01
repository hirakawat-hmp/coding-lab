# LinkedIn — 6,278種のブラウザ拡張をスキャン・暗号化して全リクエストに付加

source: https://404privacy.com/blog/linkedin-is-scanning-your-browser-extensions-this-is-how-they-use-the-data/
fetched: 2026-05-01

## 概要

404 Privacy が発見：LinkedInはChromeユーザーの拡張機能インストール状況を同意なく収集している。対象は6,278種の拡張。結果は暗号化されてすべてのLinkedIn APIリクエストに付加される。

## 技術的手法

`chrome-extension://` プロトコルを悪用して特定ファイルのリクエストを送信。拡張がインストールされていない場合はChromeがリクエストをブロック（エラーログに記録）、インストールされている場合は静かにリクエストが成功。

## リスク

LinkedInはすでに本人確認済みの専業情報を持っているため、拡張スキャン結果と紐付けると：
- 政治活動関連拡張の利用が判明
- 宗教的実践のシグナルが漏洩
- 障害対応ツールの使用が特定される
- 求人検索拡張も数百種が対象

## デバイスプロファイリング

APFC（Aggregated Profile Fingerprinting Cache）と呼ばれるシステム。48種のブラウザ・デバイス特性を監視するシステムの一部として機能。

## 規制当局の対応

バイエルン州で刑事捜査開始（デジタル市場法違反の疑い）。
