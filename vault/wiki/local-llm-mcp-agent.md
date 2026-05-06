---
type: how-to
status: [draft]
tags:
  - ai/llm
  - tool/mcp
sources:
  - "https://www.gizmodo.jp/2026/05/what_is_mcp_in_local_llm.html"
created: 2026-05-06
updated: 2026-05-06
---

# ローカルLLMをMCPサーバーでAIエージェント化する

MCPサーバーを活用してローカルLLMをチャットボットから自律エージェントに変換する実践ガイド。ゼロコストでAIエージェントを構築できる。

## MCPサーバーとは

Model Context Protocol（MCP）サーバーは、LLMに新機能を付与する「AIエクステンションプログラム」。スマートフォンのアプリのように、LLMにファイル操作・Web取得・専門データアクセスなどの能力を追加する。

## 主要MCPサーバー例

| MCPサーバー | 提供機能 |
|-----------|---------|
| Filesystem MCP | PCファイルの読み書き・作成・検索 |
| Web Fetch MCP | Webページアクセス・AI生成ファイル名で保存 |
| 国土交通省地理空間MCP | 不動産・地理データ分析 |
| draw.io MCP | 概念図の自動生成 |

## セットアップの流れ

1. MCPサーバーを選択（公式リポジトリまたは信頼できるソース）
2. JSON設定ファイルを編集してサーバーを登録
3. ローカルLLMに設定を読み込ませる

```json
{
  "mcp_servers": {
    "filesystem": {
      "command": "npx",
      "args": ["-y", "@modelcontextprotocol/server-filesystem", "/path/to/dir"]
    }
  }
}
```

## 重要な注意事項

### セキュリティリスク
- MCPソースの信頼性を必ず確認（設定ミスで悪意あるコードが実行される）
- サードパーティMCPは特に慎重に

### 技術的ハードル
- JSON直接編集が必要
- コマンドラインターミナル操作必須
- 設定が複雑（ChatGPTやGeminiで補助推奨）

## チャットボット→エージェント

基本MCP + 専門拡張の組み合わせで:
- 受動的チャットボット → 自律的な調査・文書生成エージェント
- ファイル操作・Web収集・データ分析を自動化

## 関連ページ

- [[wiki/mcp-token-optimization]] — MCPトークン消費削減パターン
- [[wiki/mcp-security-vulnerability-2026]] — MCPシステム的脆弱性
- [[wiki/microsoft-sql-mcp-server]] — SQL MCP Server実例
