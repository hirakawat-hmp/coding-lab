---
type: entity
status: []
tags:
  - ai/llm
  - infra/hardware
sources:
  - "https://blog.google/innovation-and-ai/technology/developers-tools/multi-token-prediction-gemma-4/"
created: 2026-05-06
updated: 2026-05-06
---

# Gemma 4 MTP Drafters（Multi-Token Prediction）

![Gemma 4 MTP](https://storage.googleapis.com/gweb-uniblog-publish-prod/images/Hero_Visual.width-200.format-webp.webp)

Googleが2026年5月5日にリリースしたGemma 4モデル向けの推論高速化ドラフターモデル群。Speculative Decoding技術により出力品質を損なわず最大3倍の推論速度向上を実現。

## 技術アーキテクチャ

**Speculative Decoding:**
- 軽量なドラフターモデルが複数の未来トークンを同時予測
- ターゲットモデルが並列検証
- ドラフター・ターゲット間でKVキャッシュを共有（冗長計算を排除）

## パフォーマンス

| プラットフォーム | スピードアップ |
|----------------|-------------|
| 全般 | 最大3× |
| Apple Silicon (バッチ4-8) | 約2.2× |
| Nvidia A100 | 同等の改善 |

**出力品質:** ゼロ劣化（ターゲットモデルが最終検証を保持）

## 対応プラットフォーム

LiteRT-LM・MLX・Hugging Face Transformers・vLLM

## ライセンス・配布

Apache 2.0。Hugging Face・Kaggleで利用可能。

## 技術的意義

LLM推論のボトルネックはメモリ帯域幅。MTPドラフターは複数トークンを並列で予測・検証することでエッジデバイス（Apple Silicon）からデータセンターGPU（A100）まで大幅なスループット向上を実現。

## 関連ページ

- [[wiki/gemma4-on-device]] — Gemma4スマートフォンオンデバイスモデル
- [[wiki/google-tpu-8]] — Google第8世代TPU
