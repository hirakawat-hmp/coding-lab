# GitHub Stacked PRs — Raw Source

Source: https://github.github.com/gh-stack/
Fetched: 2026-04-14
Feed: Hacker News (Top)

## 概要

GitHub Stacked PRsは、大規模な変更を「互いに積み重ねられた小さなプルリクエストのチェーン」に分割するツール。GitHubネイティブ統合。

## 主な特徴

- **ネイティブGitHub統合**：GitHub UI内でスタックを管理でき、各レイヤーのステータスを一目で確認できる
- **カスケード型リベース**：スタック全体に対してカスケード型リベースを実行できる
- **強力なCLI**：`gh stack`コマンドラインツールを使用
- **スマートな仕組み**：各PRは最終的なターゲットブランチに対して実行されるため、ブランチ保護ルールが正しく適用される

## 使用方法

```bash
gs init auth-layer    # スタック開始
gs add api-routes     # 新しいレイヤー追加
gs push               # すべてプッシュ
gs submit             # PRを開く
```

## 利点

大規模PRは「レビューが難しく、マージが遅く、競合が発生しやすい」という問題を、焦点を絞った小さなPRに分割することで解決する。
