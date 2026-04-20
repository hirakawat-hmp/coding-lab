---
type: concept
status: []
tags:
  - ai/agent
  - dev/typescript
sources:
  - "https://qiita.com/Takenoko4594/items/2e9e171d60854d77652f"
created: 2026-04-20
updated: 2026-04-20
---

# AG-UI Protocol：AI エージェントとフロントエンドを繋ぐイベント標準

AI エージェントとフロントエンドを接続するためのイベントベース標準プロトコル。トランスポート層（WebSocket、SSE 等）を問わず、**どのイベントをどのように流すか**を規定する。

## プロトコル構造

28 種類のイベントタイプを 7 カテゴリに分類：

| カテゴリ | 役割 |
|---------|------|
| Lifecycle | エージェントの開始・終了 |
| Text messaging | メッセージのストリーミング |
| Tool calls | ツール呼び出しと結果 |
| State management | 状態の同期 |
| Activities | 処理中の活動表示 |
| Reasoning | 思考過程の可視化 |
| Custom functions | 拡張イベント |

## StrandsAgents（AWS）での実装

AWS の StrandsAgents SDK は Bedrock の ConverseStream API を使用しているため、AG-UI への変換アダプターが必要：

```
Bedrock ConverseStream → StrandsAgents events → AG-UI events
```

### アダプターの主な責務

1. **スレッド管理** — マルチターン会話の文脈維持
2. **ツール同期** — フロントエンド定義のツールをプロキシツールで代理
3. **ToolBehavior 設定** — 実行動作のカスタマイズ（状態スナップショット、ストリーミング制御）

## HTTP に相当するポジション

AG-UI は AI エージェントと UI の間で **HTTP が Web に果たした役割**を果たしうる：
- 実装（フレームワーク）に依存しない標準インターフェース
- 異なるエージェントバックエンド（OpenAI、Anthropic、Bedrock）とフロントエンドを組み合わせ自由に

## MCP との関係

[[wiki/tool/mcp]] が LLM とツール・データソースを繋ぐ標準とすれば、AG-UI は LLM がフロントエンドと通信する標準。どちらも **エージェントのインターフェース標準化**という同一トレンドの産物。

## 関連ページ

- [[wiki/mcp-mastra-integration]] — MCP による外部 API 統合（同じ標準化トレンド）
- [[wiki/openai-agents-sdk-v2]] — OpenAI の次世代エージェント SDK
- [[wiki/aws-frontier-agents]] — AWS エージェント基盤（StrandsAgents の上位）
- [[wiki/snapstate]] — エージェント状態管理（State management カテゴリと関連）
