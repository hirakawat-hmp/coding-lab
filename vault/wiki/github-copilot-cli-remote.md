---
type: entity
status: []
tags:
  - ai/agent
  - infra/ci-cd
sources:
  - "https://zenn.dev/microsoft/articles/github-copilot-cli-remote-session"
created: 2026-04-15
updated: 2026-04-15
---

# GitHub Copilot CLI リモートセッション

GitHub Copilot CLI v1.0.25（2026年4月13日）で追加されたパブリックプレビュー機能。ローカルで実行中の Copilot CLI セッションを GitHub.com や GitHub Mobile からリモートで監視・操作できる。

## 概要

- **バージョン**: v1.0.25
- **ステータス**: パブリックプレビュー
- **対応**: GitHub.com / GitHub Mobile（ベータ）/ QR コード

## 動作の仕組み

セッションはローカルマシン上で継続実行。ローカルの出力を GitHub にリアルタイムストリーミングし、リモート側から監視・操作が可能。

```
ローカルマシン（CLI 実行）← → GitHub（リモートUI）
                              ↑
                         スマートフォン / ブラウザ
```

## 有効化方法

| 方法 | コマンド/設定 |
|------|-------------|
| セッション中 | `/remote` スラッシュコマンド |
| 起動時 | `copilot --remote` |
| 常時有効 | `~/.copilot/config.json` に `"remoteSessions": true` |

## リモートから可能な操作

- 権限リクエストの承認/拒否
- フォローアップ質問への回答
- 操作プランの承認/拒否
- 新しいプロンプトの送信
- モード切り替え（Interactive / Plan / Autopilot）
- 現在タスクのキャンセル

## 制限事項

| 制限 | 詳細 |
|------|------|
| 出力サイズ | 60MB/セッション |
| スラッシュコマンド | リモート UI では使用不可 |
| リポジトリ | GitHub ホスト型のみ |
| 組織利用 | Business/Enterprise 管理者の有効化が必要 |

## Claude Code との比較

Claude Code にも同様のリモートセッション概念が [[wiki/claude-code-routines]] の Routines 機能に含まれているが、アーキテクチャが異なる:

| 項目 | Copilot CLI Remote | Claude Code Routines |
|------|-------------------|---------------------|
| 実行場所 | ローカルマシン | Anthropic クラウド |
| アクセス | GitHub.com / Mobile | claude.ai |
| 目的 | 遠隔監視・承認 | 自律実行 |

## 関連ページ

- [[wiki/claude-code-routines]] — Anthropic の自律実行仕組み（比較）
- [[wiki/claude-code-job-queue]] — Claude Code マルチセッション設計
