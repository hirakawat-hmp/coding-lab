---
type: entity
status: []
tags:
  - ai/llm
  - ai/computer-vision
  - infra/gcp
sources:
  - "https://www.itmedia.co.jp/aiplus/articles/2604/15/news108.html"
created: 2026-04-16
updated: 2026-04-16
---

# Gemini Robotics-ER 1.6

Google DeepMind が 2026年4月15日に発表したロボット向け視覚言語モデル。産業現場での計器読み取り・作業完了判定・物体位置特定に特化。Boston Dynamics の Spot と連携。

## 3つのコア機能

| 機能 | 説明 |
|---|---|
| Pointing（指差し） | 方向指示による物体位置の特定 |
| Success Detection（成功検出） | カメラ映像によるタスク完了評価 |
| Instrument Reading（計器読み取り） | アナログ計器・ゲージの数値解釈 |

## 精度向上

計器読み取りタスクにおける精度の比較:

| モデル | 精度 |
|---|---|
| Gemini Robotics-ER 1.5 | 23% |
| Gemini 3.0 Flash | 72% |
| **Gemini Robotics-ER 1.6** | **93%** |

## アクセス方法

- Gemini API
- Google AI Studio
- Google Colaborate ノートブック（実装サンプル付き）

## 実世界展開

Boston Dynamics の Spot ロボットへの統合。製造・インフラ点検などの産業現場を想定。

## 関連

- ITmedia AI+ では同日（2026-04-15）、日立の「フィジカルAI」記事も掲載。物理世界での AI 活用という同一トレンド。
- [[wiki/hitachi-physical-ai]] — 熟練工の暗黙知を AI でデジタル化する日立の戦略
