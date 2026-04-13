---
type: entity
status: []
tags:
  - ai/computer-vision
sources:
  - "https://github.com/facebookresearch/sam3"
  - "https://huggingface.co/facebook/sam3.1"
  - "https://ai.meta.com/blog/segment-anything-model-3/"
created: 2026-04-10
updated: 2026-04-10
---

# SAM 3.1（Segment Anything Model 3.1）

Meta が開発した動画・画像セグメンテーションモデル **SAM（Segment Anything）シリーズの第 3.1 世代**（2026年3月27日リリース）。SAM 3（2025年11月）に対して精度を維持しながら **最大 7× のスループット向上**を達成し、マルチオブジェクト追跡のボトルネックを解消した。

## SAM 3 との違い（何が変わったか）

| 改善点 | 内容 |
|------|------|
| **Object Multiplex** | 複数オブジェクトを 1 パスで処理（共有メモリによる Joint マルチオブジェクト追跡） |
| **CPU-GPU 同期削減** | 検出器とトラッカーの紐付け処理での同期を削減 |
| **torch.compile 強化** | オペレーション融合とバッチ後処理の改善 |
| **ビジョンエンコーダ最適化** | GPU 使用率の向上 |
| **API 互換性** | SAM 3 のコードをそのまま使用可能（ドロップイン置き換え） |

## アーキテクチャ（SAM 3 系共通）

- **ビジョン-言語バックボーン**: Perception Encoder（PE）— 54億枚の画像-テキストペアで事前学習
- **Presence Token**: 「白いユニフォームの選手」vs「赤いユニフォームの選手」のような類似したテキストプロンプトを精確に区別
- **Decoupled Detector-Tracker**: 検出器とトラッカーを分離した設計でスケールしやすい
- **Dual Encoder-Decoder Transformer**: 画像レベルの認識能力を持つ

## パフォーマンス

### スループット（H100 GPU 1 枚）

| オブジェクト数 | SAM 3.1 vs SAM 3 |
|------------|----------------|
| 128 オブジェクト | **7× 高速** |
| 中程度 | フレームレート 2× 向上 |

### ベンチマーク結果

- YT-Temporal-1B: +2.1 cgF1 改善
- MOSEv2（VOS）: +2.0 改善
- 7 つの VOS ベンチマーク中 6 つで向上

### 実業務での効果

- 密なビデオアノテーション（交通・小売・スポーツ）チームで **スループット 2× 向上**

## ユースケース

- **データラベリング**: 大規模ビデオのオブジェクトアノテーション（人物・車両・商品）
- **ロボティクス**: リアルタイムな多物体追跡
- **AR/VR**: 単一 GPU で複数オブジェクトを同時追跡
- **スポーツ分析**: 複数選手・ボールの同時セグメンテーション
- **医療画像**: 臓器や病変の動的追跡

## バージョン履歴

| バージョン | リリース | 主な特徴 |
|----------|-------|--------|
| SAM 1 | 2023年4月 | 最初の汎用セグメンテーションモデル |
| SAM 2 | 2024年 | 動画セグメンテーション対応 |
| SAM 3 | 2025年11月 | Vision-Language バックボーン、Presence Token |
| **SAM 3.1** | **2026年3月** | **7× スループット向上、Object Multiplex** |

## リンク

- [GitHub: facebookresearch/sam3](https://github.com/facebookresearch/sam3)
- [HuggingFace: facebook/sam3.1](https://huggingface.co/facebook/sam3.1)
- [Meta AI ブログ](https://ai.meta.com/blog/segment-anything-model-3/)

## 関連ページ

- [[wiki/token-warping]] — 空間認識の別アプローチ（視点変換推論）
- [[wiki/agentic-mme]] — マルチモーダル AI の評価ベンチマーク
