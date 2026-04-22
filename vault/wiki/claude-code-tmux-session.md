---
type: how-to
status: [draft]
tags:
  - tool/claude-code
  - dev/bash
sources:
  - "https://qiita.com/take-yoda/items/00f05b0b517ee3a7c427"
created: 2026-04-22
updated: 2026-04-22
---

# Claude Code + tmux でターミナルを閉じても安全に実行する

長時間実行される Claude Code タスク中にターミナルウィンドウを閉じても、セッションが継続する構成。

## 前提

- tmux インストール済み
- Ghostty ターミナル（推奨）または他の端末エミュレータ

## 手順

### 1. tmux の設定

```bash
# ~/.tmux.conf に追加（Ghostty 互換のため必要）
echo 'set -g extended-keys on' >> ~/.tmux.conf
tmux source-file ~/.tmux.conf
```

### 2. Claude Code を tmux モードで起動

```bash
# worktree（分離ブランチ）＋ tmux classic モード
claude --worktree --tmux=classic

# 短縮形
claude -w --tmux=classic
```

### 3. ターミナルを閉じる

Claude Code の実行中でも安全にウィンドウを閉じられる。プロセスは tmux セッションとしてバックグラウンドで継続する。

### 4. セッションに再接続

```bash
# セッション一覧確認
tmux ls

# 再アタッチ
tmux attach-session -t <session-name>
```

## ポイント

- `--worktree`: 独立した git ブランチを作成し、メインブランチへの意図しない変更を防ぐ
- `--tmux=classic`: tmux の「classic」モードで統合。セッション管理が自動化される
- Ghostty: GPU アクセラレーション・フルカラー・日本語描画が良好

## 関連ページ

- [[wiki/claude-code-routines]] — Claude Code の自動実行機能全般
- [[wiki/tdd-parallel-workflow]] — Claude Code サブエージェントの並列化
