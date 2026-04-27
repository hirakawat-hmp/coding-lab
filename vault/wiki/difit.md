---
type: entity
status: []
tags:
  - tool/claude-code
  - dev/git
sources:
  - "https://findy-code.io/media/articles/aisaji-yoshiko_pg"
  - "https://github.com/yo-yo-yo-jbo/difit"
created: 2026-04-27
updated: 2026-04-27
---

# difit

![difit](https://storage.findy-code.io/storage/blobs/proxy/eyJfcmFpbHMiOnsiZGF0YSI6MTE0NjQwLCJwdXIiOiJibG9iX2lkIn19--e280a3670a1cb715bdaa761e95d2b2a7414f1a68/AI%25E3%2581%25AE%25E3%2581%2595%25E3%2581%2597%25E3%2582%2599%25E5%258A%25A0%25E6%25B8%259B_%25E3%2582%2588%25E3%2581%25A8%25E3%2581%2597%25E3%2581%2593%25E3%2581%2595%25E3%2582%2593_%25E3%2583%25AC%25E3%2583%2592%25E3%2582%2599%25E3%2583%25A5%25E3%2583%25BC%25E6%25B8%2588.png)

AI エージェントが生成したコード差分をブラウザで視覚的に確認できるオープンソースツール。GitHub の PR 画面を再現したローカル環境での差分表示を実現する。よしこ氏が 2025年6月に Claude Code で開発。

## インストール

```bash
npm install -g difit
```

## 基本操作

| コマンド | 説明 |
|---------|------|
| `difit` | HEAD コミットの差分を表示 |
| `difit .` | 未コミット差分を表示 |
| `difit HEAD main` | ブランチ間の差分を表示 |

## 主な機能

### AI エージェント連携
NPM スキルとしてインストール可能。AI エージェントが実装後に自動で difit を起動し、人間レビューを要求するワークフローを構築できる。

### コメント機能
- 差分に対して直接コメントを付与
- 「Copy Prompt」ボタンでファイル名・行番号付きプロンプトとしてコピー
- コピーしたプロンプトを AI に貼り付けて修正指示を出す

### difit-review スキル
AI によるコード自動レビュー・実装内容の自動解説機能を提供。

## オプション

| オプション | 説明 |
|-----------|------|
| `--no-open` | ブラウザ自動起動なし |
| `--keep-alive` | タブ閉じ時もプロセス継続 |
| `--comment` | 初期コメントを注入 |
| `--clean` | 永続化コメントのリセット |

## 開発背景・実績

2025年6月、著者よしこ氏が Claude Code で要件定義書に基づき開発。指示一発で帰宅時に完成していたエピソードが有名。
- リリース翌日: 100 Star
- 3 週間後: 1000 Star 達成

## 関連ページ

- [[wiki/claude-code-hooks]] — Claude Code のフック活用（difit 連携の基盤）
- [[wiki/cc-canary]] — Claude Code リグレッション早期検出 Agent Skill
- [[wiki/tdd-parallel-workflow]] — Claude Code subagent による並列開発ワークフロー
