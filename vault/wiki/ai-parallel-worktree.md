---
type: how-to
status: [draft]
tags:
  - tool/claude-code
  - ai/agent
  - dev/git
sources:
  - "https://qiita.com/nogataka/items/1156e2d3a40c4dab3398"
created: 2026-04-26
updated: 2026-04-26
---

# AI並列開発 — git worktree × tmux で Claude/Codex/Gemini を同時実行

複数のAIエージェント（Claude Code・Codex CLI・Gemini CLI）を同一リポジトリで並列実行する際の衝突を回避するパターン。`git worktree` で物理的に作業ディレクトリを分離する。

## 問題

同一リポジトリで複数AIを並列実行すると以下で衝突が起きる：
- `node_modules`
- ロックファイル（package-lock.json, yarn.lock）
- `.next/` などのビルド成果物

## 解決策：git worktree による隔離

```bash
# 各AIエージェント用のworktreeを作成
git worktree add ../work-claude feature/claude-branch
git worktree add ../work-codex feature/codex-branch
git worktree add ../work-gemini feature/gemini-branch

# tmuxで3ペインに分割して各worktreeで実行
```

git worktreeはGitオブジェクトを共有しつつ、物理的に独立したディレクトリを提供する。

## 3AIの実測比較（同一Issue）

| AI | 強み | 実装時間 |
|---|---|---|
| Claude Code | テスト充実度、リファクタリング | 約6分 |
| Codex CLI | 型安全性、ロジック実装 | 約4分 |
| Gemini CLI | UI実装の初期案 | 約5分 |

重要な知見：**「勝率はモデルの優劣より制約条件との相性で決まる」**

## 並列管理ツール

| ツール | 並列数 | セットアップ | 可視化 |
|--------|--------|------------|--------|
| workmux | 多 | 容易 | 良好 |
| vibe-kanban | 中 | 普通 | 良好 |
| conductor | 多 | 複雑 | 優秀 |
| 生worktree | 制限なし | 手動 | なし |

## 運用上の注意

- 人間が現実的に監視できるのは **2〜3並列が上限**
- 設計方針が割れるUIタスクで並走が有効
- 機械的・単純な作業では非効率

## 関連ページ

- [[wiki/claude-codex-planner-executor]] — Claude/Codexの役割分担
- [[wiki/claude-code-desktop-parallel]] — Claude Code Desktop並列エージェント
