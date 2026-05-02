# MCPサーバーのトークン消費9割削減Tips

source: https://zenn.dev/aircloset/articles/4c5f49f89db19f
retrieved: 2026-05-02

## 概要
エアークローゼットCTO辻亮佑氏による、自作MCPサーバーでのトークン消費削減実践例。
ペイロードを外部に退避してKeyやURLのみをMCP通信路に流すことで70〜90%削減。

## 問題点
- MCPツール呼び出しでファイル全体やクエリ結果の全件をコンテキストに乗せると数万トークン消費
- ペイロードサイズ上限エラーも発生

## 解決パターン

### リクエスト最適化（Sandbox MCP事例）
- ファイルをMCPで送る代わりに、Git Serverに退避
- MCPはGit URLだけを返す
- AIがgit pushで実体転送

### レスポンス最適化（DB Graph MCP事例）
- 大規模クエリ結果をGoogle Spreadsheetにエクスポート
- URLとメタデータのみ返却
- 行数超過時は自動的にフォールバック

### Google Workspace OAuth活用
- ユーザー認証とWorkspaceアプリ権限を統合取得
- ユーザー本人のドライブにデータ保存可能
