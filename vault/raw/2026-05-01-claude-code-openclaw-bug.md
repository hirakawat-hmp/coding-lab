# Claude Code OpenClaw Bug — コミット言及で課金・リクエスト拒否

source: https://news.ycombinator.com/item?id=47963204
source: https://www.xda-developers.com/claude-subscribers-just-lost-access-to-openclaw-and-other-third-party-toolsunless-they-pay-more/
source: https://help.apiyi.com/en/openclaw-claude-llm-request-rejected-extra-usage-fix-en.html
fetched: 2026-05-01

## 概要

Hacker News フロントページに登場した問題。Gitコミットメッセージに「OpenClaw」という文字列が含まれていると、Claude Codeがリクエストを拒否するか、Max/Teamサブスクリプションを無視してExtra Usage（従量課金）で請求されるというバグ。

## 背景

OpenClawはサードパーティの Claude Code クライアント。2025年末〜2026年初頭にかけて、ユーザーがClaudeのOAuthトークンをOpenClawに転用することでAPI課金を回避できることが発覚。

2026年1月: Anthropicが対策としてClaude Pro/Max サブスクリプションのOAuthトークンをサードパーティ利用禁止に  
2026年4月: 「OpenClaw」という文字列がコミット履歴に含まれているだけで影響が出るバグを発見

## 影響

- コミット履歴にOpenClaw言及があるだけで課金ルートが変わる
- HERMES.md バグ（CVE-2026-31431の課金バグ）と類似の構造
- サブスクリプション残量が残っているにもかかわらず従量課金が発生

## 関連

- HERMES.md 課金バグ: `vault/wiki/claude-code-hermes-billing-bug.md`
