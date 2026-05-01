---
type: troubleshooting
status: [investigating]
tags:
  - tool/claude-code
  - security/api
sources:
  - "https://news.ycombinator.com/item?id=47963204"
  - "https://www.xda-developers.com/claude-subscribers-just-lost-access-to-openclaw-and-other-third-party-toolsunless-they-pay-more/"
  - "https://help.apiyi.com/en/openclaw-claude-llm-request-rejected-extra-usage-fix-en.html"
created: 2026-05-01
updated: 2026-05-01
---

# Claude Code OpenClaw バグ — コミット言及で課金ルート変更

2026年4月30日にHacker Newsで報告されたClaude Codeのバグ。Gitコミット履歴に「OpenClaw」という文字列が含まれていると、Claude CodeがMax/Teamサブスクリプションを無視してExtra Usage（従量課金）で請求するか、リクエスト自体を拒否するという挙動。

## 背景：OpenClawとは

OpenClawはサードパーティ製のClaude Codeクライアント。2025年末にユーザーがClaude Pro/MaxのOAuthトークンを転用してAPI課金を回避できることを発見（API換算で$1,000+/月相当を$200のサブスクで利用可能）。2026年1月にAnthropicが対策としてOAuthトークンのサードパーティ利用を禁止した。

## バグの内容

コミット履歴に「OpenClaw」の文字列があるだけで課金ルートが変わる:

- Max/Teamサブスクリプションのクレジット残量が十分あるにもかかわらず従量課金（Extra Usage）が発生
- またはリクエストが拒否される

## 類似事例

[[wiki/claude-code-hermes-billing-bug]]（HERMES.md課金バグ）と同様の構造:
- コミットメッセージやファイル名に特定文字列が含まれると課金ルートが変わる
- いずれもAnthropicのコンテンツフィルタリングや課金ロジックの副作用とみられる

## 暫定回避策

コミット履歴から「OpenClaw」の文字列を除去するか、履歴を整理することで正常な課金ルートに戻る可能性がある。

## Anthropicへの報告状況

2026年4月30日時点でHNのフロントページに掲載（investigating）。公式対応は未確認。

## 関連ページ

- [[wiki/claude-code-hermes-billing-bug]] — HERMES.md課金バグ（同様のパターン）
- [[wiki/claude-code-pro-tier-removal]] — Claude Code Proプラン削除の経緯
