---
type: entity
status: []
tags:
  - tool/claude-code
  - tool/cursor
  - ai/agent
  - infra/ci-cd
sources:
  - "https://zenn.dev/microsoft/articles/agent-package-manager-handson"
created: 2026-04-26
updated: 2026-04-26
---

# Microsoft APM（Agent Package Manager）

![Microsoft APM](https://static.zenn.studio/user-upload/deployed-images/d5099117b6e2005fc1279098.png)

MicrosoftがOSSとして公開したAIエージェント設定管理ツール（MIT、v0.9.1以上）。「AIエージェント設定のための package.json」として機能し、複数のAIハーネス（Copilot・Claude Code・Cursor等）への設定配布を一元管理する。

## コンセプト

ハーネスエンジニアリングの複雑さを吸収し、チーム全体で一貫したAIエージェント設定を維持するためのパッケージ管理システム。`apm install` 1コマンドでオンボーディングが完了する。

## 主な機能

### 統一的な依存管理
- `apm.yml` で依存を宣言
- `apm install` で全ハーネスに一括展開
- `apm.lock.yaml` に **40桁コミットハッシュ**でピン留め → 再現性を保証

### セキュリティ対策
- 不可視Unicode文字の自動検出
- `apm-policy.yml` によるローカル・CI両段階での違反ブロック
- 40桁フルSHAによる改ざん防止

## 開発者へのメリット

| シナリオ | 効果 |
|--------|------|
| 新メンバーオンボーディング | `apm install` 1コマンドで完了 |
| ルール更新 | Gitの履歴に乗り、チーム全員へ自動伝搬 |
| ハーネス追加 | 既存ルールがそのまま機能 |

## 対応プラットフォーム

macOS、Linux、Windows（PowerShell）

## 関連ページ

- [[wiki/ai-engineering-harness-era]] — ハーネスエンジニアリングの概要
- [[wiki/claude-code-hooks]] — Claude Code Hooksとの連携
- [[wiki/claude-code-enterprise-adoption-2026]] — 企業でのAI開発ツール採用動向
