---
type: entity
status: []
tags:
  - infra/hardware
  - infra/gcp
  - ai/llm
sources:
  - "https://www.itmedia.co.jp/news/articles/2604/23/news059.html"
  - "https://blog.google/innovation-and-ai/infrastructure-and-cloud/google-cloud/eighth-generation-tpu-agentic-era/"
created: 2026-04-23
updated: 2026-04-23
---

# Google 第8世代TPU「8t」「8i」

Googleが[[wiki/google-cloud-next-2026]]で発表したAI向けチップ第8世代。**学習用「8t」と推論用「8i」の2機種**に分化させたのが特徴（2026年4月22日）。

## TPU 8t（学習用）

| 指標 | 値 |
|------|-----|
| 学習性能 | 前世代「Ironwood」比 **3倍** |
| コスト効率 | 最大 **2.7倍** 向上 |
| 最大スケール | 単一スーパーポッドで **9,600チップ** |

## TPU 8i（推論用）

| 指標 | 値 |
|------|-----|
| オンチップSRAM | 前世代比 **3倍** |
| ネットワーク | 新トポロジー「**Boardfly**」採用 |
| 推論コスト削減 | **80%** 削減 |
| ネットワーク性能 | 最大 **2倍** 向上 |

## 提供時期

2026年下半期予定。NVIDIA製GPUとの併用も可能（Virgo Networkで接続）。

## 背景

LLM推論と学習では要件が大きく異なる（推論は低レイテンシ、学習は高スループット）。専用チップに分化することで、各ワークロードの効率を最適化する戦略。

## 関連ページ
- [[wiki/google-cloud-next-2026]] — GCN 2026全体まとめ
- [[wiki/intel-advanced-packaging]] — Intel先端パッケージング（競合比較）
- [[wiki/nvidia-ai-competition-2026]] — NVIDIAとGoogleの競争
