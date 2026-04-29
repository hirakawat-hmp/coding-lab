---
type: how-to
status: [draft]
tags:
  - tool/mcp
  - security/api
  - infra/gcp
sources:
  - "https://zenn.dev/finatext/articles/mcp-gateway-google-sa"
created: 2026-04-29
updated: 2026-04-29
---

# MCP ゲートウェイと Google SA：AI への過剰権限付与を防ぐ設計

Nowcast LLM Engineer・techan（2026年4月28日）による実装事例。AI エージェントに会社の Google アカウント（ユーザートークン）を直接渡すリスクを解消するアーキテクチャ。

## 問題

AI エージェントがユーザートークンを直接利用すると、そのユーザーが見られるすべての情報（意図しない 1on1 メモ、機密 Drive ファイル等）にアクセスできてしまう。

## 解決策：ユーザーごとの専用サービスアカウント（SA）

```
User ─→ [MCP Server / Interceptor] ─→ [Admin SA] ─→ 発行 ─→ [User SA]
                                                            │
                                            明示的に共有した Google リソースのみアクセス
```

### 2 層 SA 構造

1. **Admin SA（管理 SA）**: トークン発行専用。AWS Lambda + GCP Workload Identity Federation 経由でのみ使用
2. **User SA（個人 SA）**: 各ユーザーに 1 つ。ユーザーが Google 共有設定で明示的に許可したリソースのみアクセス可能

### 短命トークン運用

- SA キーファイルを保存しない
- AWS Lambda が Workload Identity Federation 経由で短命トークンを都度生成
- トークン生成は Interceptor 層にのみ許可

## メリット

| 観点 | 効果 |
|---|---|
| 監査 | Google ログでAIと人間の行動を区別可能 |
| 認可 | Google の標準共有機能がそのまま使える |
| コスト | SA は無料（ユーザーアカウントのライセンス不要） |
| 安全性 | SA キー管理ゼロ・最小権限を自然に実現 |

## 関連する問題事例

- [[wiki/ai-tool-security-incidents-8-2026]] の「ChatGPT連携 → Google Drive 自動抽出」はトークン管理の失敗例
- [[wiki/google-apikey-gemini-billing]] — API キー漏洩から 13 時間で 900 万円請求

## 関連ページ

- [[wiki/mcp-security-vulnerability-2026]] — MCP のシステム的脆弱性
- [[wiki/claude-code-security-incidents]] — Claude Code セキュリティ事故
- [[wiki/mcp-mastra-integration]] — MCP で外部 API をラップする設計
