---
type: insight
status: []
tags:
  - ai/agent
  - ai/llm
sources:
  - "https://reflex.dev/blog/computer-use-is-45x-more-expensive-than-structured-apis/"
created: 2026-05-06
updated: 2026-05-06
---

# Computer Use（視覚エージェント）はStructured APIより45倍コスト高

![Computer Use is 45x More Expensive](https://web.reflex-assets.dev/blog/computer-use-is-45x-more-expensive-than-structured-apis.webp)

ReflexがAIエージェントの2アプローチ（視覚ベース vs APIベース）を同一タスクでベンチマークし、視覚エージェントが約45倍のトークンコストを消費することを実証した（2026年5月）。

## 実験設定

- **テストアプリ:** react-adminベースの管理パネル（Posters Gloreデモ模倣）
- **タスク:** 顧客「Smith」を探し、未処理注文を見つけ、レビューを承認し、配送済みにマーク
- **データセット:** 顧客900件・注文600件・レビュー324件
- **モデル:** 両パスともClaude Sonnet

## 測定結果

| 指標 | 視覚エージェント | APIエージェント |
|------|--------------|--------------|
| ステップ数 | 53 | 8 |
| 実行時間 | ~1,003秒 | ~19.7秒 |
| 入力トークン | 550,976 | 12,151 |
| トークン比 | **45倍** | 1 |

## 重要な発見

1. **視覚エージェントは初回タスク失敗**（ページネーション部分を見落とし）→ 14ステップの詳細UIウォークスループロンプトが必要
2. **視覚の高い分散:** 実行時間749〜1,257秒、トークン407k〜751k
3. **APIは一貫性高い:** 全試行で安定した結果

## なぜ解決できないか

視覚エージェントのアーキテクチャ的制約: 全中間状態の視覚的レンダリングを処理しなければならない。視覚モデルの改善はスクリーンショット1枚あたりのエラーを減らすが、スクリーンショット数自体は減らせない。

## 示唆

内部管理アプリケーションでは**自動生成APIサーフェスを活用した構造化APIアプローチ**が経済的。視覚エージェントは外部制御不可のUIに対してのみ正当化される。

## 関連ページ

- [[wiki/karpathy-agentic-engineering]] — エージェントエンジニアリングの概念
- [[wiki/disposable-ui-paradigm]] — 使い捨てUIパラダイム（AI時代のUI設計）
