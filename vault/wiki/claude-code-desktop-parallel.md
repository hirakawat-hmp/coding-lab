---
type: entity
status: []
tags:
  - tool/claude-code
  - ai/agent
sources:
  - "https://www.itmedia.co.jp/aiplus/articles/2604/15/news080.html"
created: 2026-04-16
updated: 2026-04-16
---

# Claude Code Desktop 並列エージェント対応

![Claude Code Desktop](https://image.itmedia.co.jp/aiplus/articles/2604/15/yu_claudecode.jpg)

Anthropic が 2026年4月14日に発表した Claude Code デスクトップアプリの大幅刷新。複数の AI エージェントを同時実行し、並列でタスクを処理できるようになった。

## 主要機能

### 並列タスク管理
- 複数のセッションを同時に管理するサイドバー UI
- キーボードショートカット（Ctrl+;）でのクイックタスク分割
- アクティブセッションのステータスインジケーター・プロジェクト整理・フィルタ

### 接続オプション
- **ローカル:** Mac 上でのターミナル統合
- **リモート:** SSH 経由のリモートマシン接続
- **クラウド:** Anthropic クラウドでのセッション実行

### ファイルプレビュー
- HTML・PDF ファイルのアプリ内表示

## 対応プラン

Pro / Max / Team / Enterprise（Claude API バックエンド経由）

## 関連機能

- **Routines（自動実行）:** スケジュール・API・GitHub webhook による自動タスク実行 → [[wiki/claude-code-routines]]
- **Claude Code Actions:** GitHub Actions 連携 → [[wiki/claude-code-github-actions]]

## 関連ページ

- [[wiki/claude-code-routines]] — 自動実行 Routines 機能（同時発表）
- [[wiki/claude-code-harness-patterns]] — Claude Code ハーネスパターン設計思想
- [[wiki/claude-code-job-queue]] — ジョブキュー活用のマルチセッション設計
