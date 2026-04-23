---
type: insight
status: []
tags:
  - security/privacy
  - security/web
  - industry/tech
sources:
  - "https://techcrunch.com/2026/04/22/apple-fixes-bug-that-cops-used-to-extract-deleted-chat-messages-from-iphones/"
created: 2026-04-23
updated: 2026-04-23
---

# Apple：削除済みメッセージの通知キャッシュ残留バグ修正

![iPhoneの通知](https://techcrunch.com/wp-content/uploads/2026/04/iphone-pop-up-notifications.jpg)

Appleが2026年4月22日のアップデートで、**削除されたメッセージが通知キャッシュに最大1ヶ月間残留するバグ**を修正した。FBIがこの欠陥を使用してSignalの削除済みメッセージを抽出していたことが明らかになっていた。

## バグの内容

- 「削除対象としてマークされた通知が予期せずデバイスに保持されていた」
- 削除したはずのメッセージ内容が通知キャッシュに最大1ヶ月保持
- Signalの「メッセージ消去」機能が実質的に無効化されていた

## 発覚の経緯

404 Mediaの報道により、FBIが合法的なデバイスアクセスの過程でこの欠陥を利用し、Signalから削除済みメッセージを抽出していたことが判明。

## 関係者のコメント

Signal会長 Meredith Whittaker：「削除されたメッセージの通知は、OSの通知データベースに残るべきではない」

## 教訓

**エンドツーエンド暗号化アプリのプライバシー保証は、アプリ層だけでは担保できない。** OSの通知システム、バックアップ機構、キャッシュレイヤーなど、下位レイヤーが同等のセキュリティ要件を満たさなければ、暗号化の意味が失われる。

Apple は iOS 18 を実行している旧デバイスにもバックポート修正を適用した。

## 関連ページ
- [[wiki/firefox-tor-indexeddb-cve]] — ブラウザ下位レイヤーによるプライバシー侵害（同構造の問題）
- [[wiki/google-ice-data-surveillance]] — プラットフォームと法執行機関のデータ提供問題
- [[wiki/claude-code-security-incidents]] — セキュリティインシデント事例集
