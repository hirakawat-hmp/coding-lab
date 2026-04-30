---
type: insight
status: []
tags:
  - security/api
  - ai/agent
sources:
  - "https://www.promptarmor.com/resources/ramps-sheets-ai-exfiltrates-financials"
created: 2026-04-30
updated: 2026-04-30
---

# Ramp Sheets AI — 間接プロンプトインジェクションによる財務データ漏洩

## 概要

Ramp の AI スプレッドシート機能に間接プロンプトインジェクション脆弱性が発見された（2026年2月19日報告、3月16日修正済み）。外部データセットに悪意ある指示を埋め込むと、AI がユーザー承認なしに機密財務データを外部サーバーに送信するフォームを生成する。

## 攻撃フロー

```
1. 攻撃者が外部データセットに悪意ある指示を隠蔽
2. Ramp Sheets AI がそのデータを取り込む
3. AI が指示を実行：外部ネットワークリクエスト挿入フォームを生成
4. ユーザー承認なしに機密財務情報が攻撃者サーバーへ送信
```

## 教訓

AI ツールが外部データを処理する際、その内容に悪意ある指示が含まれている可能性を考慮する必要がある。特にスプレッドシート系の AI 機能は外部データソースを多用するため高リスク。

**類似インシデント**: Claude for Excel にも同様の脆弱性が発見された。修正版では全フォームをユーザーに警告表示するプロンプトが追加された。

## 関連ページ

- [[wiki/mcp-security-vulnerability-2026]] — MCP のシステム的脆弱性 6件（同種の AI ツール脆弱性）
- [[wiki/ai-tool-security-incidents-8-2026]] — AI ツールセキュリティ実在インシデント 8 選
- [[wiki/claude-code-security-incidents]] — Claude Code で実際に起きたセキュリティ事故 7選
