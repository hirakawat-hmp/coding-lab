---
type: insight
status: []
tags:
  - tool/claude-code
  - ai/llm
sources:
  - "https://gigazine.net/news/20260430-why-cancelled-claude/"
created: 2026-04-30
updated: 2026-04-30
---

# Claude 有料プラン解約の実態：トークン制限・品質低下・サポート不備

![Claude解約理由](https://i.gzn.jp/img/2026/04/30/why-cancelled-claude/00_m.jpg)

## 概要

ドイツ人エンジニアが Claude 有料プランを解約した理由を詳述した記事（Gigazine、はてブ上位）。Claude の実ユーザーが感じるペインポイントを整理した一次資料として価値がある。

## 主な解約理由

### 1. トークン制限問題

- Claude Haiku に簡単な質問2つでトークン枯渇
- 当初は3プロジェクト同時作業が可能だったが、後に1プロジェクト2時間で上限到達
- 制限の不透明さ・予測困難さが問題

### 2. カスタマーサポートの不備

- テンプレート返信のみ、実際の問題解決なし
- 問題が解決していないのに「問題は解決しました」とチケットを閉じる
- 個別対応がなく自動化された印象

### 3. 出力品質の低下

- Claude Opus がジュニア開発者でも提案しないような手抜きの回避策を提示
- 指摘すると「そうですね、ずさんでした」と認め再実行 → その修正で日次トークンの 50% を消費
- 品質低下の認識とトークン消費が二重に痛い

### 4. キャッシュ失効問題

会話履歴が消えてコードベースを再ロードする必要があり、事実上の二重課金状態。

## 考察

この事例は [[wiki/claude-code-tokenocalypse]] で記録されたトークン爆発問題と連動している。Anthropic は [[wiki/anthropic-claude-code-postmortem-2026-04]] でいくつかの品質問題を公式に認めているが、ユーザー体験の改善には時間がかかる。

## 関連ページ

- [[wiki/claude-code-tokenocalypse]] — Claude Code v2.1.88 Tokenocalypse（トークン3〜50倍爆発）
- [[wiki/anthropic-claude-code-postmortem-2026-04]] — Claude Code 品質低下 3 問題の公式ポストモーテム
- [[wiki/claude-code-pro-tier-removal]] — Claude Code の Pro プラン削除（告知なし・コミュニティ反発）
- [[wiki/claude-code-hermes-billing-bug]] — HERMES.md コミットメッセージによる課金バグ
