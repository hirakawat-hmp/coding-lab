---
type: insight
status: []
tags:
  - tool/claude-code
  - industry/tech
sources:
  - "https://www.wheresyoured.at/news-anthropic-removes-pro-cc/"
  - "https://news.ycombinator.com/item?id=47854477"
  - "https://github.com/anthropics/claude-code/issues/45236"
created: 2026-04-22
updated: 2026-04-22
---

# Claude Code が Pro プランから削除された件

2026 年 4 月 21 日頃、Anthropic が Claude Code を月額 $20 の Pro プランから**告知なしに削除**した。ドキュメントが更新され、利用条件が「Pro または Max」から「**Max のみ**」に変更された。

## 経緯

- 事前の変更ログ・プレスリリースなし
- GitHub Issue #45236「Breaking Change: Claude Code CLI Removed from Pro Plan Without Notice」が提出された
- Anthropic の Amol Avasare による説明:「新規 Pro ユーザーの約 2% を対象とした小規模テスト。既存 Pro・Max ユーザーへの影響はない」

## 影響と反応

- コミュニティは強い反発。ローカルモデル（Ollama 等）推進派の論拠を強化
- Claude Code が Teams プランや Enterprise へ移行する可能性、または単独プレミアムアドオン化の観測

## 教訓

- 大幅な機能変更でも告知なしに実施されることがある。重要機能のライセンス条件の定期確認が必要
- [[wiki/backblaze-cloud-sync-exclusion]] の事例と類似した「サービス範囲の突然の縮小」パターン

## 関連ページ

- [[wiki/claude-code-routines]] — Claude Code の機能全般
- [[wiki/claude-47-tokenizer-costs]] — 別のコスト増加事例
