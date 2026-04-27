# LINEをAIエージェントの入口にする現実解

source: https://zenn.dev/peintangos/articles/b024c86e672191
fetched: 2026-04-27

## 背景

LINE 月間アクティブユーザー約 9,800 万人（日本）。日本最大のチャットプラットフォームを AI エージェントの UI として活用する。

## 3 つのインターフェース比較

### Messaging API
- LINE Bot を作るための REST API
- Webhook でユーザーメッセージを受信し返信
- テキスト・Flex Message（リッチ UI）・Quick Reply 対応
- 制約: 2 秒以内に 200 を返す必要 → AI 推論は非同期処理必須

### LIFF
- LINE アプリ内 WebView で任意の Web アプリを表示
- SSE ストリーミング・Markdown レンダリング可能（ChatGPT 的体験）
- 課題: トークからWebView への遷移でユーザー体験が断絶

### LINE Bot MCP Server
- Claude Desktop 等から「『こんにちは』と送って」と指示するだけ
- ローカル AI アシスタント向けの送信・管理ツール

## 実装環境

Next.js (App Router) + @line/bot-sdk + @anthropic-ai/sdk をVercelにデプロイ

## 推奨パターン

基本は Messaging API で十分。ストリーミング表示・Markdown 対応が必要な場合だけ LIFF へ遷移。
