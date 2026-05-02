---
type: how-to
status: [draft]
tags:
  - tool/mcp
  - ai/agent
  - tool/claude-code
sources:
  - "https://zenn.dev/aircloset/articles/4c5f49f89db19f"
created: 2026-05-02
updated: 2026-05-02
---

# MCPサーバーのトークン消費を70〜90%削減する設計パターン

エアークローゼット CTO 辻亮佑氏による実践的トークン最適化手法。大きなペイロードを MCP 通信路から外し、参照用 Key/URL のみを流す設計で大幅削減を達成。

## 問題

- MCP ツール呼び出しでファイル全体・クエリ結果全件をコンテキストに乗せると **数万トークン消費**
- ペイロードサイズ上限エラーが発生することもある
- LLM が不要な詳細情報を「読む」ためのコストが積み上がる

## 解決パターン

### パターン1：リクエスト最適化（外部ストレージ退避）

**Sandbox MCP の事例:**
1. ファイルを MCP で送る代わりに、Git Server に退避
2. MCP は Git URL だけを返す
3. AI が `git push` で実体を転送

ファイルデータがコンテキストを通過しないため、大幅な削減になる。

### パターン2：レスポンス最適化（結果の外部エクスポート）

**DB Graph MCP の事例:**
1. 大規模クエリ結果を Google Spreadsheet にエクスポート
2. URL とメタデータのみを返却
3. 行数超過時は自動的にフォールバック

### パターン3：Google Workspace OAuth 統合

- ユーザー認証と Workspace アプリ権限を統合取得
- ユーザー本人のドライブにデータ保存
- 権限管理が簡潔化される

## 削減効果

| パターン | 削減率 |
|----------|--------|
| リクエスト最適化 | 70〜90% |
| レスポンス最適化 | ケース依存（件数が多いほど効果大） |

## 設計原則

**「MCPの通信路にはKeyとURLだけを流す」**

実体データはストレージ（Git/GCS/GDrive 等）に置き、LLM はそれを参照して自律的に取得する。MCP はインデックスとして機能させる設計思想。

## 関連ページ

- [[wiki/rtk]] — Claude Code トークン消費を 60-90% 削減する Rust 製 CLI プロキシ
- [[wiki/mcp-mastra-integration]] — MCP で外部 API をラップし Mastra エージェントに統合
- [[wiki/claude-code-three-layer-design]] — Claude Code 3層設計パターン
- [[wiki/prolog-mcp-server]] — Prolog × MCP で LLM 論理推論を向上
