---
type: concept
status: []
tags:
  - ai/llm
  - stats/optimization
created: 2026-05-05
updated: 2026-05-05
sources:
  - "https://arxiv.org/abs/2510.19315"
---

# Transformers Are Inherently Succinct — ICLR 2026 Outstanding Paper

ICLR 2026のOutstanding Paper（最優秀論文）。Transformerの表現力を形式言語理論の観点から定量化し、「簡潔性（succinctness）」という新しい測度を提案した。

## 著者

Pascal Bergsträßer, Ryan Cotterell, Anthony W. Lin（2025年10月提出）

## 主要定理

Transformerは有限オートマトン・LTL・RNN/SSMと比較して**指数的〜二重指数的に簡潔**である。

| 比較対象 | Transformerの簡潔性 |
|---------|------------------|
| 有限オートマトン | 二重指数的に簡潔 |
| LTL（線形時間論理） | 指数的に簡潔 |
| RNN / SSM（State-Space Model） | 指数的に簡潔 |

## 副産物（重要）

Transformerの性質検証は**EXPSPACE完全**（計算不可能に近い困難）であることが証明された。これはTransformerの「解釈可能性」問題の理論的下限を示す。

## 意義

- Transformerがなぜ少ないパラメータで複雑な言語パターンを学習できるかの**理論的裏付け**
- SSMやRNNがTransformerに劣る理由の形式的説明
- 同時に「Transformerを完全に理解するのは計算論的に困難」という限界も示す

## 関連ページ

- [[wiki/triattention]] — プリ-RoPE Q/K集中性を利用したKVキャッシュ圧縮
- [[wiki/deep-learning-theory]] — 深層学習の科学理論（2026年4月arXiv）
- [[wiki/introspective-diffusion-lm]] — 拡散LMとARモデルのギャップを埋めるI-DLM
