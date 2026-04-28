---
type: entity
status: []
tags:
  - industry/tech
  - ai/llm
  - tool/gh-cli
sources:
  - "https://github.blog/news-insights/company-news/github-copilot-is-moving-to-usage-based-billing/"
  - "https://www.itmedia.co.jp/aiplus/articles/2604/28/news051.html"
created: 2026-04-28
updated: 2026-04-28
---

# GitHub Copilot 利用量ベース課金（2026年6月移行）

2026年6月1日より、GitHub Copilot がプレミアムリクエスト単位（PRU）の定額制から **GitHub AI Credits** によるトークン消費ベースの利用量課金へ移行する。

## 新料金体系

| プラン | 月額 | 含有クレジット |
|--------|------|---------------|
| Copilot Pro | $10 | $10 相当 |
| Copilot Pro+ | $39 | $39 相当 |
| Copilot Business | $19/ユーザー | $19 相当 |
| Copilot Enterprise | $39/ユーザー | $39 相当 |

## 変わらないもの

- コード補完（Code completions）と Next Edit Suggestions は全プランでクレジット消費なし
- 基本プランの月額価格は据え置き

## 廃止されるもの

- **Fallback experiences（フォールバック体験）**：クレジット不足時の低コストモデルへの自動切替は廃止
- Premium Request Units（PRU）の概念そのもの

## 移行タイムライン

- **月次サブスクライバー**：2026年6月1日に自動移行
- **年間プラン**：更新時に移行
- **法人・エンタープライズ**：2026年8月まで促進的な含有利用あり

## 新機能（法人向け）

- チーム横断のクレジットプール管理
- コストセンター・ユーザーレベルでのバジェット管理

## 背景

Copilotがコード補完からエージェント型プラットフォーム（マルチステップタスク実行）へ進化し、計算需要が大幅に増加したことへの対応。「トークン消費量に応じた透明な価格設定」への移行。

## 関連

- [[wiki/tokenmaxxing]] — トークン消費最大化がエンジニア評価基準になりつつあるトレンド
- [[wiki/openai-codex-enterprise]] — OpenAI Codex エンタープライズ価格設定の動向
