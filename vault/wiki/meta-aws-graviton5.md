---
type: entity
status: []
tags:
  - infra/aws
  - infra/hardware
  - ai/llm
  - industry/tech
sources:
  - "https://www.itmedia.co.jp/news/articles/2604/25/news024.html"
created: 2026-04-25
updated: 2026-04-25
---

# Meta × AWS Graviton5 AI 推論提携（2026年4月）

![Meta × AWS Graviton5](https://image.itmedia.co.jp/news/articles/2604/25/yu_awsmeta.jpg)

Meta と AWS が 2026年4月25日に提携を発表。生成 AI の推論タスクに AWS の最新 Arm 系プロセッサ「Graviton5」を大量採用する。

## Graviton5 のスペック

| 項目 | 詳細 |
|------|------|
| プロセスノード | 3nm |
| コア数 | 192コア |
| パフォーマンス向上 | 前世代比最大 25% |
| キャッシュ | 前世代比 5倍 |
| コア間通信速度 | 前世代比 33% 向上 |

## Meta のマルチプロセッサ戦略

Meta は多様なコンピューティングニーズに応えるため複数プロセッサを採用：
- **学習**：主に NVIDIA GPU
- **推論**：CPU（Graviton5）が効率的

AI モデルの推論は学習ほど NVIDIA GPU を必要とせず、高並列 CPU が有利な場面が多い。これにより **コスト削減** と **省エネ目標達成** の両立を図る。

## 業界への示唆

NVIDIA 一強だった AI インフラ市場に、AWS Graviton（Arm 系 CPU）が推論用途で割り込む動き。

[[wiki/nvidia-ai-competition-2026]] でも指摘されているように、AI チップ設計の多様化が加速している。

## 関連ページ

- [[wiki/nvidia-ai-competition-2026]] — NVIDIA の優位性揺らぐか
- [[wiki/aws-frontier-agents]] — AWS DevOps Agent / Security Agent
- [[wiki/intel-advanced-packaging]] — Intel の先端パッケージング戦略
