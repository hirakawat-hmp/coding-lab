---
type: entity
status: []
tags:
  - ai/llm
sources:
  - "https://introspective-diffusion.github.io/"
  - "https://arxiv.org/abs/2604.11035"
created: 2026-04-15
updated: 2026-04-15
---

# Introspective Diffusion Language Model (I-DLM)

拡散言語モデル（DLM）と自己回帰（AR）モデルのギャップを埋める研究。「AR モデルは自分が生成したものに同意するが、DLM はそうではない」という根本的な問題を解決する。

## 背景: 拡散言語モデルの問題

従来の AR 訓練では生成と検証が 1 回のフォワードパスで統合されている。拡散モデルはこれを欠いており、生成品質が AR に劣っていた。

## 主な貢献

### 1. Introspective Consistency フレームワーク

生成と検証を同時に行う専用訓練を導入。モデルが「生成しながら検証する」ことを学習する。

### 2. Introspective Strided Decoding (ISD)

- N トークンを 1 フォワードパスで生成しながら、既存トークンを同時検証
- 受容確率: `min(1, p(x)/q(x))`（AR 分布と同等の出力保証）

### 3. AR 互換アーキテクチャ

厳密な因果的 Attention を使用 → SGLang 等の既存 AR サービングインフラをそのまま使用可能。

## 訓練

- 事前訓練済み AR モデルから因果的 Attention マスキングで変換
- 4.5B トークン、8× H100 GPU

## ベンチマーク結果（I-DLM-8B）

| ベンチマーク | I-DLM-8B | LLaDA-2.1-mini |
|------------|---------|----------------|
| AIME-24 | **69.6** | 43.3 |
| LiveCodeBench-v6 | **45.7** | 30.4 |

- スループット: LLaDA-2.1-mini 比 2.9-4.1× 向上
- 受容率: **0.984**（SDAR の 0.699 と比較）

## リソース

- 論文: [arXiv:2604.11035](https://arxiv.org/abs/2604.11035)
- コード: [GitHub](https://github.com/Introspective-Diffusion/I-DLM)
- モデル: [HuggingFace](https://huggingface.co/collections/yifanyu/introspective-diffusion-language-models-i-dlm)

所属: Together AI、UIUC、Princeton、Stanford、UT Austin

HN: 220 pts, 42 comments（2026-04-14）

## 関連ページ

- [[wiki/triattention]] — KV キャッシュ圧縮による推論高速化
