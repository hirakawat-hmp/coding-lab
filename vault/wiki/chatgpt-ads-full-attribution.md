---
type: insight
status: []
tags:
  - ai/llm
  - security/privacy
  - industry/tech
sources:
  - "https://www.buchodi.com/how-chatgpt-serves-ads-heres-the-full-attribution-loop/"
created: 2026-04-29
updated: 2026-04-29
---

# ChatGPT 広告配信の完全な属性チェーン解析

Buchodi's Threat Intel（2026年4月28日）による技術解析。ChatGPT の広告配信・追跡システムの実装を SSE ストリームから Cookie まで詳細に解明した調査レポート。

## 広告注入の仕組み

ChatGPT バックエンドは会話の SSE（Server-Sent Events）ストリーム内に `single_advertiser_ad_unit` 構造体を注入する。この構造体には以下が含まれる:

- 広告主のブランド情報
- カルーセルカード
- **Fernet 暗号化された 4 つのトークン**（属性チェーンを形成）

## 追跡インフラ

### OAIQ SDK
訪問者のブラウザ上で動作するトラッキング SDK。商品ビューをリアルタイムで OpenAI に報告。

### 使用ドメイン
| ドメイン | 用途 |
|---|---|
| `bzrcdn.openai.com` | クリエイティブ配信 |
| `bzr.openai.com` | イベント送信 |

### Cookie
| Cookie 名 | 用途 |
|---|---|
| `__oppref` | ユーザー追跡 |
| `__oaiq_domain_probe` | ユーザー追跡 |

## コンテキストターゲティング

同一ユーザーでも異なるトピックの会話をすると異なる広告を受け取ることが確認された。会話の文脈をターゲティングシグナルとして使用。

## `open_externally: false` の意味

ChatGPT アプリ内の WebView でリンクを開く際、`open_externally: false` 設定によりクリック後のナビゲーションも OpenAI がモニタリングできる状態。

## 背景との接続

[[wiki/chatgpt-ads-stackadapt]] では ChatGPT 広告の StackAdapt × OpenAI パイロット（CPM $15〜60）が確認されている。本記事はその技術実装の詳細を明らかにした続報と位置づけられる。

## プライバシーへの含意

会話内容そのものが広告ターゲティングに使われるモデルは、ユーザーが AI に打ち明けた情報が広告システムに流入するリスクを内包する。欧州 GDPR 下での合法性も問われる可能性がある。

## 関連ページ

- [[wiki/chatgpt-ads-stackadapt]] — ChatGPT 広告配信（StackAdapt パイロット）
- [[wiki/security/privacy]] タグの関連ページ
- [[wiki/flock-lpr-privacy]] — 監視インフラとプライバシー法の狭間
