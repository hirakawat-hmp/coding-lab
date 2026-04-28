---
type: how-to
status: [draft]
tags:
  - tool/mcp
  - security/api
  - policy/regulation
sources:
  - "https://qiita.com/Takashi_Masumori/items/5045c0d46a756f0a49fd"
created: 2026-04-28
updated: 2026-04-28
---

# Copilot Studio における MCP セキュリティ対策

Microsoft Copilot Studio で MCP（Model Context Protocol）サーバーをツールとして使用する際のセキュリティベストプラクティス。

## MCP コネクタの2種類

### 1. 事前構築済み Microsoft MCP コネクタ

**特徴**：Power Platform の通常コネクタと同様に扱われる。「Work IQ」など新コネクタが頻繁に追加される。

**リスク**：アップデート速度が速く、意図しないコネクタへのアクセスが発生する可能性がある。

**対策：**
- DLP（Data Loss Prevention）ポリシーで制御
- Copilot Studio 環境専用のポリシー見直しサイクルを短縮化
- 新規追加コネクタはデフォルトで「ブロック済み」または「非ビジネス」グループに設定
- レビュー・承認後に「ビジネス」グループへ移行

### 2. カスタム MCP サーバー

**技術的詳細**：内部的にはカスタムコネクタとして動作するため、**カスタムコネクタ側の DLP 設定で制御可能**。

**リスク**：未承認の外部 MCP サーバーへの接続が発生する可能性がある。

**対策：**
- 既存のカスタムコネクタ審査運用プロセスをそのまま流用
- デフォルトで全カスタム MCP サーバーをブロック
- 個別申請時に **URL 単位**での許可付与
- 必要に応じて環境分離を実施

## 運用ポイント

「既存のカスタムコネクタ審査運用をそのまま流用できる」ため、新たなセキュリティフレームワーク構築は不要。

ただし Copilot Studio 専用環境では、新コネクタ追加頻度に対応した**DLP ポリシーの見直しサイクルの短縮化**が重要。

## 関連

- [[wiki/microsoft-sql-mcp-server]] — Microsoft 公式 SQL MCP サーバー
- [[wiki/prolog-mcp-server]] — MCP × 論理推論の活用例
- [[wiki/salesforce-headless-360]] — MCP 経由での Salesforce アクセス
