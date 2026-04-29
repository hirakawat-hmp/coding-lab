---
type: insight
status: []
tags:
  - security/api
  - security/supply-chain
  - ai/agent
sources:
  - "https://prtimes.jp/main/html/rd/p/000000068.000118521.html"
created: 2026-04-29
updated: 2026-04-29
---

# AIツールセキュリティ実在インシデント 8 選（2026年4月）

![AIセキュリティインシデント8選](https://prcdn.freetls.fastly.net/release_image/118521/68/118521-68-03ce3ea21fdf0537d9231555e3325d93-1280x720.png)

株式会社 MONO BRAIN（2026年4月28日）による企業事例まとめ。「クリック不要で機密流出、AI が DB を削除、OAuth で全権限漏洩」といった事例から、設計上の根本問題を抽出。

## 8つのインシデント概要

| # | 製品 | 手口 | 被害 |
|---|---|---|---|
| 1 | **M365 Copilot** | メール経由の間接プロンプトインジェクション | データ自動送信 |
| 2 | **Lovable** | API 権限設計ミス | コード・チャット履歴露出 |
| 3 | **ChatGPT 連携** | 外部 API 悪用 | Google Drive / GitHub 情報自動抽出 |
| 4 | **Replit AI Agent** | 制御不能な自律実行 | 本番 DB 削除（1,000 件以上） |
| 5 | **GitHub Copilot** | インジェクション | 情報窃取 |
| 6 | **Copilot** | トークン漏洩 | - |
| 7-8 | **Vercel** | OAuth / サプライチェーン | 情報窃取 |

## 共通リスク要因

1. **過剰な権限での無防備な運用** — AI に必要以上の権限を与えた状態で放置
2. **外部入力への過信** — LLM の出力が攻撃者のコントロール下にある可能性を無視
3. **自動実行制御の不足** — 人間の確認なしで危険な操作が実行できる状態
4. **OAuth / API ガバナンスの欠如** — 認可スコープの管理が属人的

## 推奨対策

- **最小権限の原則**: AI に付与するアクセス範囲を必要最小限に絞る（→ [[wiki/mcp-gateway-google-sa]]）
- **外部連携統制**: サードパーティ API への接続を一元管理
- **入出力のサニタイズ**: LLM の出力もユーザー入力と同様に危険視
- **人間承認フロー**: 危険な操作（DB 変更・ファイル削除等）に人間の確認ステップを挿入（→ [[wiki/ccgate]]）

## 他事例との比較

- DB 削除事例は [[wiki/ai-agent-db-destruction-pocketos]] と構造が完全に一致
- Vercel 関連は [[wiki/vercel-2026-breach]] でより詳細に解析済み
- Bitwarden インシデントは [[wiki/bitwarden-cli-supply-chain-2026-04]] 参照

## 関連ページ

- [[wiki/claude-code-security-incidents]] — Claude Code で実際に起きたセキュリティ事故 7 選
- [[wiki/ai-agent-db-destruction-pocketos]] — AI エージェントが本番 DB を 9 秒で破壊
- [[wiki/mcp-security-vulnerability-2026]] — MCP のシステム的脆弱性
- [[wiki/mcp-gateway-google-sa]] — Google SA による過剰権限問題の対策
- [[wiki/ccgate]] — Permission 確認の自動化による制御
