---
type: entity
status: []
tags:
  - security/api
  - tool/claude-code
  - security/privacy
sources:
  - "https://zenn.dev/winky/articles/envguard-ai-env-secret"
created: 2026-04-25
updated: 2026-04-25
---

# envguard

AI コーディングツールへの秘密鍵・機密情報の意図せぬ流出を事前にチェックするセキュリティツール。Claude Code・Cursor などのリスクを可視化する。

## 問題の背景

Claude Code・Cursor などの AI ツールはターミナルから起動するプロセスであり、**親プロセスの環境変数をそのまま継承** する。以下の経路から秘密情報が混入しうる：

- `~/.zshrc` / `~/.bashrc` に直接記載された環境変数
- `launchctl` / `LaunchAgents`（macOS サービス管理）
- `direnv`（ディレクトリ単位の環境変数管理）

## envguard の機能

- **Read-only 動作**：ファイル変更・ネットワーク通信なし
- **5段階リスク分類**：CRITICAL〜INFO で重要度を表示
- **マスキング表示**：発見した値はマスクして出力（ログへの漏洩防止）
- 検出対象：AWS キー、GitHub トークン、API キー、DB 接続文字列など

## 対処方法

| 期間 | 方法 |
|------|------|
| 短期 | `env -i command` で隔離起動 |
| 長期 | aws-vault、1Password CLI への移行 |

## 関連インシデント

[[wiki/claude-code-security-incidents]] に記録された事例と連動する課題。AI ツールを安全に使うための必須チェックとなりつつある。

## 関連ページ

- [[wiki/claude-code-security-incidents]] — Claude Code で実際に起きたセキュリティ事故
- [[wiki/mcp-security-vulnerability-2026]] — MCP のシステム的脆弱性
- [[wiki/google-apikey-gemini-billing]] — API キー流出による請求インシデント
