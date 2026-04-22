---
type: how-to
status: [draft]
tags:
  - ai/agent
  - infra/ci-cd
sources:
  - "https://qiita.com/wan-code/items/7138654568f8ef43785b"
created: 2026-04-22
updated: 2026-04-22
---

# n8n で RSS ニュースを自動翻訳・要約して Discord に通知する

BBC ニュースの RSS フィードを 1 時間ごとに取得し、Google Gemini で日本語に翻訳・要約して Discord へ通知する n8n ワークフロー。

## ワークフロー構成

```
RSS Feed Trigger (1時間毎)
  → Remove Duplicates（重複排除）
  → Gemini AI（翻訳・要約）
  → Discord（投稿）
  → Error Handling（障害分離）
```

## AI プロンプト設計

```
以下の英語記事を日本語に翻訳・要約してください。
出力形式:
- 見出し（1文）
- 要点（2-3箇条書き）
必ず日本語で出力すること。
```

## 実装上のポイント

- **Remove Duplicates**: 同じ記事の重複通知を防ぐ。n8n のビルトインノードを使用
- **Error Handling**: 1 記事の失敗がパイプライン全体を止めないよう障害を分離
- **フォーマット**: Discord の Markdown に対応した出力形式

## 改善アイデア

1. 元記事 URL を Discord メッセージに追加
2. トピック別に Discord チャンネルを分ける
3. 重要度フィルタリング（ワードスコアリング等）
4. データベースへのアーカイブ

## 関連ページ

- [[wiki/claude-code-routines]] — Claude Code の自動実行ルーティン（同様の自動化パターン）
- [[wiki/writeback-rag]] — 情報収集・蓄積の自動化パターン
