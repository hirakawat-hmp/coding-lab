---
type: entity
status: []
tags:
  - ai/agent
  - industry/tech
sources:
  - "https://zed.dev/blog/parallel-agents"
created: 2026-04-23
updated: 2026-04-23
---

# Zed Parallel Agents

Zedエディターが2026年4月22日に発表した**複数AIエージェントの並列実行機能**。単一ウィンドウ内で複数のエージェントスレッドを同時管理できる。

## 主要機能

### Threads Sidebar
- 複数のエージェントスレッドをプロジェクト単位でグループ化して一覧表示
- スレッドの停止・アーカイブ・新規作成などの操作が可能
- フォルダとリポジトリへのアクセス制御

### 新デフォルトレイアウト
- Threads Sidebar と Agent Panel が左側に配置
- Project Panel と Git Panel は右側に移動
- 自由にレイアウトカスタマイズ可能

## 思想：Agentic Engineering

Zedは「AIツールと人間の職人技を組み合わせてソフトウェアを構築する」という**Agentic Engineering**のコンセプトを強調。完全自動化と完全手動の中間を目指す姿勢。

## 比較

| エディタ | 並列エージェント機能 |
|---|---|
| Zed | Parallel Agents（Threads Sidebar）|
| Cursor | [[wiki/cursor-3]]（マルチエージェント） |
| Claude Code Desktop | [[wiki/claude-code-desktop-parallel]]（複数セッション）|

## 関連ページ
- [[wiki/cursor-3]] — Cursor 3.0 マルチエージェント
- [[wiki/claude-code-desktop-parallel]] — Claude Code Desktop 並列エージェント
- [[wiki/tdd-parallel-workflow]] — 並列エージェントのワークフロー設計
