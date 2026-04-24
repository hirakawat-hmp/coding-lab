---
type: entity
status: []
tags:
  - ai/agent
  - industry/tech
  - infra/hardware
sources:
  - "https://monoist.itmedia.co.jp/mn/articles/2604/24/news066.html"
created: 2026-04-24
updated: 2026-04-24
---

# Fujitsu Kozuchi Physical AI OS

![Fujitsu Physical AI OS](https://image.itmedia.co.jp/mn/articles/2604/24/kmishima_fujitsu_physicalai111_w290.jpg)

富士通が 2026 年にリリース予定のロボット・自動運転車向け物理 AI 専用 OS。Carnegie Mellon University との共同研究センターで開発中。

## 物理 AI（Physical AI）とは

> 「ロボットや自動運転車などの現実世界で行動するために必要な知識を学習し、学習方法を工夫することで現実的なシナリオを生成・実行する AI」

LLM 等のバーチャル空間での AI とは異なり、物理的な制約（センサー、モーター、安全性）を持つ実世界への対応が特徴。

## OS の主要機能

- ロボットタスクの**自動適応**
- センサデータのリアルタイム処理
- **複数ロボット間の協調制御**
- 過去の行動データからの学習活用

## コア技術

| 技術 | 説明 |
|------|------|
| Takane | 富士通独自の AI 基盤技術 |
| ロボットタスク設計 | タスク分解・計画立案 |
| マルチロボット対応 | 複数エージェントの協調 |
| **Sim2Real** | シミュレーション→実世界への移植 |

## 研究パートナーシップ

**Fujitsu-Carnegie Mellon Physical AI Research Center**（ペンシルベニア州）を設立し共同研究を推進。

## ロードマップ

| 年度 | バージョン | 主な追加機能 |
|------|-----------|-------------|
| 2026 | v1 | SDK 公開・初期リリース |
| 2027 | v2 | ロボットスキル拡張 |
| 2028 | v3 | 複雑なロボット動作対応 |
| 2030 | v4 | 異なる環境への対応 |

2026 年度中に SDK を公開し、外部開発者のフィードバックを通じた改善サイクルを開始。

## 文脈

富士通は「2030 年にドラえもんのような世界を実現する」というビジョンを掲げ、Physical AI を中核技術と位置付けている。NVIDIA が Physical AI 基盤（Cosmos）を発表し競争が激化する中、日本企業として産業用ロボット領域での差別化を図る。

## 関連ページ

- [[wiki/hitachi-physical-ai]] — 日立 フィジカルAI：熟練工の暗黙知をデジタル化
- [[wiki/gaia-local-ai-agent]] — AMD のローカルハードウェア上で動作するオープンソース AI エージェントフレームワーク
- [[wiki/gemini-robotics-er]] — Gemini Robotics-ER 1.6（産業現場向け高精度 AI）
