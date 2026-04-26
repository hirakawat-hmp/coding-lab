# Google agents-cli — Cloud Next '26発表のエージェント開発CLI

**ソース:** https://zenn.dev/makocchan/articles/whats_agents_cli
**取得日:** 2026-04-26
**公開日:** 2026-04-25

## 記事内容

Google Cloud Next'26で発表されたツール。「AIエージェント開発に必要となる実装、評価、デプロイといったプロセスを実行するためのインタフェース」を提供。

### 主な特徴
- 手動操作とコーディングエージェント（Gemini CLI、Claude Code等）からの実行に対応
- 7つのスキルセット（ワークフロー定義、スキャフォーディング、実装リファレンス、評価、デプロイ、公開、可観測性）を提供
- 細かく分割されたコマンド設計により部分的な導入が容易

### 主要コマンド
1. scaffold create - プロジェクト作成
2. lint - コード静的解析
3. run - エージェント実行
4. eval run - 評価機能実行
5. deploy - Cloud Run/GKE/Agent Runtimeへのデプロイ

### 著者評価
既存の開発プロセスとの組み合わせやすさが利点

OGP画像: https://static.zenn.studio/user-upload/deployed-images/1cac8724722bf1b14753a244.png
