---
type: entity
status: []
tags:
  - infra/hardware
  - ai/llm
sources:
  - "https://wired.jp/article/why-chip-packaging-could-decide-the-next-phase-of-the-ai-boom/"
created: 2026-04-19
updated: 2026-04-19
---

# Intel 先端チップパッケージング事業

![Intel Advanced Packaging](https://media.wired.jp/photos/69d5e0536c25831ed9c20168/master/w_2560%2Cc_limit/Intel-Copackaging-Business-DSC01068.jpg)

Intel が AI ブームの次フェーズを見据えてニューメキシコ州の Fab 9 施設に多額投資し、先端チップパッケージング事業を本格化させている（2026年4月）。

## 先端パッケージングとは

複数のチップレット（ダイ）を1つのパッケージ内に統合する技術。「チップを製造する」から「チップをどう繋ぐか」へのパラダイムシフト。

## Intel の主要技術

| 技術 | 特徴 |
|------|------|
| **EMIB-T** | 電力効率と信号安定性を向上させる埋め込みマルチダイ相互接続ブリッジ |

## 競合との比較

| 企業 | 技術 |
|------|------|
| TSMC | CoWoS（Chip on Wafer on Substrate）, SoIC |
| Intel | EMIB-T, Foveros |

## 事業目標

- **収益目標**: パッケージング事業から数千億円超（$1 billion+）
- **顧客**: Google・Amazon などビッグテック企業と交渉中
- **CFO コメント**: 「パッケージング収益はウェーハ全体収益に先行して計上される」

## AI インフラにおける重要性

AI アクセラレーター（GPU/NPU）の性能ボトルネックは演算コアそのものではなく、コア間の帯域幅・電力効率に移行しつつある。先端パッケージングはこのボトルネックを解消する鍵。

## 関連ページ

- [[wiki/gemini-robotics-er]] — AI ハードウェア需要の加速
- [[wiki/smolvm]] — ハードウェア最適化の動向
