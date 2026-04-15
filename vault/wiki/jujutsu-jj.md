---
type: entity
status: []
tags:
  - dev/git
sources:
  - "https://steveklabnik.github.io/jujutsu-tutorial/introduction/what-is-jj-and-why-should-i-care.html"
  - "https://github.com/jj-vcs/jj"
created: 2026-04-15
updated: 2026-04-15
---

# Jujutsu (jj)

Git と Mercurial の長所を統合した現代的な分散バージョン管理システム（DVCS）。CLI ツールは `jj`。「Git より簡単で、しかしより強力」を謳う。

## 概要

- **開発元**: Google（当初）、現在はオープンソースプロジェクト
- **特徴**: Git の分散モデル + Mercurial のクリーンなワークフローを融合
- **CLI**: `jj`（Jujutsu の略）

## Git との比較

### 優れている点

| 機能 | jj | Git |
|------|----|----|
| 同時ブランチ編集 | ✅ ワークスペース機能で対応 | ❌ ブランチ切り替えが必要 |
| スタック PR | ✅ ネイティブ対応 | ❌ 複雑な rebase が必要 |
| コンフリクト処理 | ✅ コンフリクトを「状態」として保持 | ❌ 即時解決が必要 |
| コマンド数 | ✅ 少ない（統合されたツールセット） | ❌ 多い（パッチワーク的） |

### Git 互換性

- **リポジトリ変換不要**: 既存 Git リポジトリ上でそのまま使用可
- **コラボレーター**: Git ユーザーと並行して作業可能
- **リバート可**: いつでも Git に戻れる（データロスなし）

## 主な概念

### Operation Log

すべての `jj` 操作がログとして記録され、過去の任意の状態に戻れる。Git の `reflog` より包括的。

### Working Copy as Commit

作業ディレクトリ自体がコミットとして扱われる。`git stash` や `git add` が不要。

### Revsets

強力なクエリ言語でコミット集合を指定。`jj log -r "ancestors(main)"` のように使う。

## インストール

```bash
cargo install --git https://github.com/jj-vcs/jj jj-cli
# または
brew install jujutsu
```

## 典型的なワークフロー

```bash
jj new            # 新しい作業コミット開始
jj describe -m "my change"  # コミットメッセージ設定
jj git push       # プッシュ（Git リモートへ）
```

## 採用状況

Google 社内では Chrome などの大規模リポジトリで使用されている（一部）。

Hacker News で 2026年4月14日に 479 ポイントを獲得。

## 関連ページ

- [[wiki/github-stacked-prs]] — スタック PR 管理ツール（Git ベース）
