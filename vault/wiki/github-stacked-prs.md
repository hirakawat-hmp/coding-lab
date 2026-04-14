---
type: entity
status: []
tags:
  - dev/git
  - infra/ci-cd
sources:
  - "https://github.github.com/gh-stack/"
created: 2026-04-14
updated: 2026-04-14
---

# GitHub Stacked PRs

大規模な変更を「互いに積み重ねられた小さなプルリクエストのチェーン」に分割するGitHubネイティブのツール。`gh stack`コマンドとして提供される。

## 課題と解決

**大規模PRの問題点：**
- レビューが難しい（変更量が多い）
- マージが遅い（承認に時間がかかる）
- コンフリクトが発生しやすい

**Stacked PRsの解決策：**
各PRを独立してレビューできるよう小さなチェーンに分割。最終的にまとめてマージする。

## 主な機能

| 機能 | 内容 |
|------|------|
| ネイティブGitHub統合 | GitHub UI内でスタック全体を管理 |
| カスケード型リベース | スタック全体への一括リベースを実行 |
| ブランチ保護ルール対応 | 各PRが最終ターゲットブランチを基準に検証 |
| CLIサポート | `gs`コマンドでターミナルから操作 |

## 基本的なワークフロー

```bash
gs init auth-layer    # スタック開始（最初の変更）
gs add api-routes     # 新しいレイヤーを追加
gs add tests          # さらに追加
gs push               # 全ブランチをプッシュ
gs submit             # PR一式を開く
```

## 関連ページ

- [[wiki/tdd-parallel-workflow]] — 並列作業のワークフロー設計
- [[wiki/claude-code-auto-merge]] — Claude Code GitHub Actionsの自動マージパターン
