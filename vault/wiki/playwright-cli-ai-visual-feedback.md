---
type: how-to
status: [draft]
tags:
  - tool/playwright
  - ai/agent
  - dev/testing
sources:
  - "https://azukiazusa.dev/blog/playwright-cli-ai-agent-visual-feedback/"
created: 2026-05-04
updated: 2026-05-04
---

# Playwright CLI で AI エージェントに視覚的フィードバックを与える

![Playwright CLI](https://images.ctfassets.net/in6v9lxmm5c8/ud2v4jmPh9FBFLlJiG3oi/504d81605de7050f0b0a3ea40bd8048b/bird_uguisu_11328-768x640.png)

Playwright CLI v0.1.9のアノテーション機能を使い、AIエージェントにブラウザUIの問題点を視覚的に伝えて修正させる手法。

## 背景

AIエージェントはコードを書けるが、実際のUIの見た目・使い勝手を評価するには人間のフィードバックが必要。テキストで「ボタンの位置がおかしい」と伝えるより、**要素を直接指定してコメント**する方が正確。

## セットアップ

```bash
npm install -g @playwright/cli
playwright-cli install --skills
```

## 使い方

```bash
# アノテーションモードでダッシュボード表示
playwright-cli show --annotate
```

1. UIをブラウザで確認
2. 問題のある要素をクリックして選択
3. コメントを入力（例: 「このボタンは左に移動してほしい」）
4. AIエージェントがコメントを読んでコードを修正

## アノテーションの仕組み

選択した要素に対してPlaywright CLIがセレクタを自動生成し、コメントと紐付けてファイルに保存する。AIエージェントはこのファイルを読み、どの要素をどう変更すべきか正確に把握できる。

## 注意点

- **すべてのフィードバックが自動化できるわけではない**: デザインの感覚的な判断は人間が担当
- 人間による実際のUI操作とフィードバック提供が組み合わさることで最大の効果
- Playwright CLI はブラウザテスト（`playwright test`）とは別のツール

## 適用シーン

- コードを書いたAIが生成したUIのレビュー・修正指示
- デザイナーがエンジニアの実装にフィードバックする際の言語化
- E2Eテスト作成前のUI確認

## 関連ページ

- [[wiki/agentic-uat]] — AIエージェントによるUAT手法（テスト全般）
- [[wiki/genai-shift-left-testing]] — 生成AIによるシフトレフト（テスト設計）
