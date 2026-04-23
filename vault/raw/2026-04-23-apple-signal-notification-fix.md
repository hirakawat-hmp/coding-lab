# Apple iOS: 削除済みメッセージの通知キャッシュ残留バグ修正

Source: https://techcrunch.com/2026/04/22/apple-fixes-bug-that-cops-used-to-extract-deleted-chat-messages-from-iphones/
Fetched: 2026-04-23

## 要点

Appleが削除済みメッセージを警察がiPhoneから抽出できるバグを修正するソフトウェアアップデートをリリース。

- 「削除対象としてマークされた通知が予期せずデバイスに保持されていた」
- 削除されたメッセージの内容が通知キャッシュに最大1ヶ月間保持されていた
- FBIがこのバグを使用してSignalアプリの削除済みメッセージを抽出していたことが404 Mediaの報道で明らかに
- Signalの会長Meredith Whittaker：「削除されたメッセージの通知はOSの通知DBに残るべきではない」
- iOS 18を実行している古いデバイスにも修正をバックポート

OGP: https://techcrunch.com/wp-content/uploads/2026/04/iphone-pop-up-notifications.jpg
