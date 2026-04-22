---
type: how-to
status: [draft]
tags:
  - tool/claude-code
sources:
  - "https://qiita.com/i-inose/items/e644e9b620ee1c8d3c1b"
created: 2026-04-22
updated: 2026-04-22
---

# Claude Code 入門ガイド（初心者向け）

Qiita で人気の Claude Code 入門記事（i-inose, 2026-04-21）の要点まとめ。

## 従来ツールとの違い

| | GitHub Copilot | Claude Code |
|---|---|---|
| 動作 | コード補完（提案） | ワークフロー全実行 |
| 範囲 | 現在のファイル/カーソル | ファイル読書・コマンド実行・コード記述・検証まで |

## 最重要概念：コンテキストウィンドウ管理

Claude Code は**コンテキスト量が品質を直接左右する**。コンテキストが枯渇すると応答が劣化する。ファイル・会話を意図的に管理することが重要。

## 主要機能

### CLAUDE.md
プロジェクトレベルのメモリファイル。起動時に自動読み込みされ、毎回プロジェクト説明を繰り返す必要がなくなる。

### Plan Mode
`Shift+Tab` を 2 回押すと、実際にコードを変更する前に計画を提示するモードになる。破壊的変更の前に内容を確認できる。

### Skills（スラッシュコマンド）
`/skill-name` で再利用可能なワークフローを実行。繰り返し作業を自動化。

### Hooks
イベント駆動型のシェル実行。特定のアクション（コミット前・ツール実行後など）にフックして自動化。

### MCP（Model Context Protocol）
GitHub・Slack・データベース等の外部ツールを接続し、Claude Code の能力を拡張。

## 利用プラットフォーム

- ターミナル CLI (`claude`)
- VS Code 拡張
- JetBrains プラグイン
- デスクトップアプリ
- Web（claude.ai/code）

## 関連ページ

- [[wiki/claude-code-hooks]] — Hooks の詳細仕様
- [[wiki/skill-md-pattern]] — SKILL.md パターンの詳細
- [[wiki/claude-code-routines]] — 自動実行 Routines 機能
- [[wiki/claude-code-tmux-session]] — tmux との組み合わせ
