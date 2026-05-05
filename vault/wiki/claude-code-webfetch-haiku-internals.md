---
type: insight
status: []
tags:
  - tool/claude-code
  - ai/llm
created: 2026-05-05
updated: 2026-05-05
sources:
  - "https://zenn.dev/zhizhiarv/articles/claude-code-webfetch-haiku-summary"
---

# Claude Code WebFetch の内部動作 — Haiku による要約の実態

Claude CodeのWebFetchツールは、ユーザーが全文を読んでいると認識していても、実際にはHaikuモデルが要約した内容のみをOpus/Sonnetに返している。この透明性の欠如が実務上の問題を引き起こす。

## 処理フロー

1. ユーザーがWebFetchでURLを指定
2. Claude CodeがHTTPで取得（上限10MiB）
3. HTML→Markdown変換時に先頭1MiBで切断
4. Haiku処理前に10万文字で再切断
5. **Haikuが要約を生成**
6. その要約のみがOpus/Sonnetに渡される

## バイパス条件（全条件を満たすと要約スキップ）

1. `Content-Type: text/markdown` をサポートするサイト
2. 80以上の**信頼ドメイン**（AWS、Mozilla、Google Docsなど）に含まれる
3. Markdown長が10万文字以下

## 著作権制約

Haikuは以下をシステムプロンプトで実装：
- 引用は125文字以内に制限
- 歌詞の出力禁止

## 透明性の問題

「Received 204.4KB」と表示されるが、実際にOpusが受け取るのは数百文字の要約のみ。ユーザーは全文が読まれていると誤解する。

## 設計意図

- **コスト削減**: HaikuはOpusより大幅に安価
- **セキュリティ**: Prompt Injection対策
- **著作権保護**: 大量の著作権コンテンツの再利用防止

## 実務への影響

- 技術仕様書の細部が要約で失われる可能性
- コードの完全なコピーは要約されてしまう
- 信頼ドメイン外のMarkdownサイトは全文取得不可

## 関連ページ

- [[wiki/claude-code-hooks]] — Claude Code ライフサイクルハンドラ
- [[wiki/rtk]] — Claude Code トークン消費削減ツール
- [[wiki/claude-code-token-reduction-5tips]] — トークン消費5テクニック
- [[wiki/claude-code-precompact-hook]] — PreCompact Hook 介入設計
