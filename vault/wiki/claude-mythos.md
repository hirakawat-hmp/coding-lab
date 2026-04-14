---
type: entity
status: []
tags:
  - ai/llm
  - ai/eval
  - security/web
sources:
  - "https://www.itmedia.co.jp/aiplus/articles/2604/14/news064.html"
created: 2026-04-14
updated: 2026-04-14
---

# Claude Mythos

## 概要

Anthropic が開発したサイバーセキュリティ特化の最新 AI モデル「Claude Mythos Preview」。
英国の AI Security Institute（AISI）が 2026年4月に独立した性能検証を実施し、公開した。

## AISI 検証結果

### CTF（Capture The Flag）タスク

- **2025年4月以前は他モデルが完了できなかった課題で73%の成功率**を記録
- セキュリティ特化モデルとしての能力向上を実証

### ネットワーク攻撃シミュレーション

32個のネットワーク脆弱性シミュレーションを実施:

| モデル | 成功率 |
|---|---|
| Claude Mythos | 10回中3回完全成功 |
| Claude Opus 4.6（比較） | 16個で限定的な成功 |

### セキュリティリスク評価

ネットワークへのアクセス後に「攻撃システムへ自動で悪意あるコード注入する能力」も検証。
実世界での適用可能性には不確実性が残るとも指摘されている。

## 位置付け

Claude のメインライン（Opus / Sonnet / Haiku）とは異なる特化型モデル。
サイバーセキュリティ・脆弱性評価・ペネトレーションテストなどの専門ドメインに特化。

## セキュリティ上の注意点

高度なセキュリティ能力を持つモデルは、防御用途と攻撃用途の両方に利用可能。
AISI は以下の基本的防御策を推奨:
- 継続的なセキュリティ更新
- アクセス制限
- 適切なログ記録

## 関連ページ

- [[wiki/n-day-bench]] — LLM の N-Day 脆弱性発見能力ベンチマーク（Mythos の評価文脈）
- [[wiki/claude-code-harness-patterns]] — Claude Code ハーネス設計とセキュリティ考慮事項
