---
type: how-to
status: [draft]
tags:
  - ai/agent
  - tool/claude-code
sources:
  - "https://zenn.dev/peintangos/articles/b024c86e672191"
created: 2026-04-27
updated: 2026-04-27
---

# LINE を AI エージェントの入口にする

月間アクティブユーザー約 9,800 万人（日本）の LINE を AI エージェントの UI として活用する実装パターン。3 つのインターフェースを比較検討し、ユースケース別の最適解を示す。

## 3 つのインターフェース比較

| インターフェース | 特徴 | 向いているケース |
|--------------|------|---------------|
| **Messaging API** | REST API。Webhook でメッセージ受信・返信 | ほとんどのケース |
| **LIFF** | LINE 内 WebView でリッチな Web アプリを表示 | ストリーミング・Markdown が必要 |
| **LINE Bot MCP Server** | MCP 経由でローカル AI から LINE 送信 | ローカル AI アシスタントからの送信 |

## Messaging API の詳細

最もシンプルで実用的。以下の UI コンポーネントが使える:
- テキストメッセージ
- Flex Message（カード UI、画像・ボタン入り）
- Quick Reply（次のアクション候補をボタンで提示）

**重要制約**: 2 秒以内に HTTP 200 を返す必要がある。AI 推論は非同期処理にして Webhook レスポンスとは切り離す。

```typescript
// 非同期パターン
app.post('/webhook', async (req, res) => {
  res.sendStatus(200); // 即座に返す
  const events = req.body.events;
  // AI 推論は非同期で
  processEventsAsync(events);
});
```

## LIFF の詳細

LINE アプリ内で Web アプリを WebView 表示する。SSE ストリーミングや Markdown レンダリングが使えるため ChatGPT 的体験を実現できる。

**課題**: トークからWebView への画面遷移がユーザー体験を断絶させる。日常会話には不向き。

## 推奨パターン

```
通常の会話 → Messaging API（テキスト + Quick Reply）
    ↓
長い出力・Markdown・ストリーミングが必要な場合
    ↓
LIFF へのリンクを Messaging API で送信 → LIFF で詳細表示
```

「基本は Messaging API で十分。ストリーミング表示・Markdown 対応が必要な場合だけ LIFF へ遷移する」が最適バランス。

## 実装スタック

```
Next.js (App Router)
+ @line/bot-sdk
+ @anthropic-ai/sdk
→ Vercel にデプロイ
```

## 関連ページ

- [[wiki/lineyahoo-agent-i]] — LINEヤフーの公式 AI エージェント「Agent i」
- [[wiki/ag-ui-protocol]] — AI エージェントとフロントエンドを繋ぐプロトコル
- [[wiki/claude-code-routines]] — Claude Code での定期実行パターン
