# ChatGPT serves ads. Here's the full attribution loop

- Source: https://www.buchodi.com/how-chatgpt-serves-ads-heres-the-full-attribution-loop/
- Published: 2026-04-28

## Summary

OpenAIがChatGPTで広告を配信・追跡するシステムの技術解析。

**広告注入:** SSEストリーム内に `single_advertiser_ad_unit` 構造体を注入。Fernet暗号化された4トークンで属性チェーンを形成。

**追跡インフラ:**
- OAIQトラッキングSDKがブラウザで訪問者行動をOpenAIに報告
- ドメイン: `bzrcdn.openai.com`（クリエイティブ）/ `bzr.openai.com`（イベント送信）
- Cookie: `__oppref` + `__oaiq_domain_probe` でユーザー追跡

**コンテキストターゲティング:** 同一ユーザーでもトピックにより異なる広告を配信確認。

**注目点:** `open_externally: false` 設定でクリック後ナビゲーションもアプリ内WebViewで監視。
