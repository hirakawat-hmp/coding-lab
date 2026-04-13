---
tags:
  - insight
sources:
  - "dotfiles/claude-code-config/vault 分離作業 (2026-04-06)"
created: 2026-04-06
updated: 2026-04-06
---

# 開発環境アーキテクチャ — リポジトリ分離パターン

## 背景

従来の dotfiles 一括管理から、関心ごとにリポジトリを分離した。
「何を管理しているか」ではなく「変更のライフサイクルが違うもの」を分ける。

## 3リポジトリ構成

```
~/repos/
  dotfiles/              # ツール設定（mise, helix, zellij, alacritty, ...）
  claude-code-config/    # Claude Code（agents, skills, hooks, rules, settings）
  vault/                 # ナレッジベース（Obsidian + qmd + LLM Wiki）
```

### 分離の判断基準

| 基準 | dotfiles | claude-code-config | vault |
|------|----------|-------------------|-------|
| 変更頻度 | 低（ツール追加時） | 中（スキル・ルール追加） | 高（日常的に ingest） |
| ファイル数 | 少（~15） | 多（80+） | 増加し続ける |
| 構造の独自性 | 標準的な config | 独自（agents/skills/hooks） | LLM Wiki パターン |
| 利用者 | シェル・エディタ | Claude Code | Claude Code + Obsidian + qmd |

## dotfiles の設計方針

- mise の `config.toml` がツールの Single Source of Truth
- 各ツールの設定は `~/.config/` への symlink で管理
- `install.sh` でべき等にセットアップ可能
- シェル設定（.zshrc 等）は管理しない — sheldon + starship に委譲

## claude-code-config の設計方針

- `~/.claude/` 配下への symlink で接続
- グローバル `CLAUDE.md` を持ち、`@` import で vault の CLAUDE.md を参照
- MCP サーバー登録、プラグインインストールも install.sh に含む
- rules/ にはClaude Code が Bash で実際に使うツールのみ記載（helix, zellij 等の人間専用ツールは除外）
- hooks/ に [[wiki/claude-code-hooks]] の実装を配置（[[wiki/claude-code-hooks-patterns]] 参照）
  - `block-dangerous.sh` — 危険コマンドブロック
  - `rtk-rewrite.sh` — [[wiki/rtk]] によるトークン節約リライト

## vault の設計方針

- [[wiki/llm-wiki-pattern]] に基づく `raw/` + `wiki/` の2層構造
- タグ（source, entity, concept, insight, comparison）で分類
- qmd MCP で Claude Code からセマンティック検索可能
- Obsidian でグラフビュー・タグ検索による閲覧
- serena メモリはプロジェクト内に閉じるが、vault は横断的知見を蓄積
- [[wiki/claude-code-hooks-patterns]] の Vault 自動同期パターンで SessionStart/End に git 同期

## symlink 構造

```
~/.claude/CLAUDE.md      → claude-code-config/CLAUDE.md
~/.claude/settings.json  → claude-code-config/settings.json
~/.claude/agents/*.md    → claude-code-config/agents/*.md
~/.claude/rules/*.md     → claude-code-config/rules/*.md
~/.claude/hooks/*.sh     → claude-code-config/hooks/*.sh
~/.config/mise/config.toml → dotfiles/mise/config.toml
~/.config/helix/*        → dotfiles/helix/*
~/.config/starship.toml  → dotfiles/starship.toml
（他も同様）
```

## セットアップ手順

```bash
# 1. dotfiles — mise + 全ツール設定
~/repos/dotfiles/install.sh
mise install

# 2. claude-code-config — Claude Code 設定
~/repos/claude-code-config/install.sh

# 3. vault — qmd コレクション登録
qmd collection add ~/repos/vault --name vault
qmd embed
```

## 教訓

- dotfiles に全部入れるのは古い — ライフサイクルが違うものは分ける
- 「1ファイルしかないなら分けない」は正しい判断（mise config は dotfiles のまま）
- symlink + install.sh のパターンはシンプルで十分に再現性がある
- グローバル CLAUDE.md → `@` import で別リポジトリの指示を参照できる
