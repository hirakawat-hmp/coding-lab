---
type: insight
status: []
tags:
  - ai/agent
  - tool/claude-code
  - infra/ci-cd
sources:
  - "https://ai.acsim.app/articles/introducing-self-merge-policy"
created: 2026-04-29
updated: 2026-04-29
---

# AI コードレビュー自己マージポリシー（Acsim の事例）

Acsim エンジニアリングチームの Ryota Sasazawa（2026年4月28日）による実践レポート。AI 駆動開発の加速に伴う PR バックログ問題への解決策として「自己マージポリシー」を導入した事例。

## 問題設定

AI によるコード生成が加速し、PR 量が増大した一方、人間のレビュー速度は変わらない。「本当に全 PR に人間の承認が必要なのか？」という問いを立て、システマティックに判断基準を設計した。

## 判断フレームワーク：One-Way Door / Two-Way Door

Jeff Bezos が提唱した意思決定フレームワーク: **「その変更を容易に元に戻せるか？」** を人間レビューの必要性の基準にする。

### 人間レビュー必須（One-Way Door）

- DB スキーマ変更・RLS ポリシー・認証/認可システム
- インフラ / CI-CD デプロイ
- 基盤ライブラリの追加・置換
- チーム合意文書（Design Docs・ADR・コーディング規約）

### 自己マージ可（Two-Way Door）

上記以外の変更。Claude Code Action が PR を自動評価し、自己マージ可否と根拠をコメントとして投稿。

## 定量的効果（2週間）

| 指標 | Before | After |
|---|---|---|
| self-merge 承認率 | 0% | 80%（159件中127件） |
| p90 リードタイム | 132〜316時間 | 92時間 |
| 24時間以内マージ率 | - | 77% |

## 実装

`Claude Code Action` が PR を評価。ガイドラインに基づいて自己マージ可否を判断し、理由付きでコメントを投稿。

## リスク軽減策

1. **Design Docs による事前合意** — 実装前に方針を人間がレビュー
2. **ドキュメント基準の向上** — AI レビュー精度向上
3. **AI レビューツールの拡充** — コード品質の継続的担保

## 関連ページ

- [[wiki/ccgate]] — AI による Permission 判断の自動化（類似パターン）
- [[wiki/claude-code-auto-merge]] — Claude Code GitHub Actions の auto-merge 実装
- [[wiki/agentic-uat]] — AI エージェントがユーザーを演じてテストする手法
- [[wiki/genai-shift-left-testing]] — 生成 AI によるシフトレフト
