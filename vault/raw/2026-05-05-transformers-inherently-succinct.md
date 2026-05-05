# Transformers Are Inherently Succinct

Source: https://arxiv.org/abs/2510.19315
Fetched: 2026-05-05

## 著者

Pascal Bergsträßer, Ryan Cotterell, Anthony W. Lin（2025年10月提出、ICLR 2026 Outstanding Paper受賞）

## 主要貢献

Transformerの表現力の測度として「簡潔性（succinctness）」を提案。Transformerは有限オートマトンより指数的に、LTL（線形時間論理）やRNN/SSMより指数的に簡潔であることを証明。

## 主要結果

- Transformerは有限オートマトンより二重指数的に簡潔
- LTL（線形時間論理）よりも指数的に簡潔
- RNN（最新のState-Space Modelを含む）より指数的に簡潔

## 副産物

Transformerの性質検証は証明可能な意味でEXPSPACE完全（計算不可能に近い困難）であることが示された。

## 意義

Transformerがなぜ少ないパラメータで複雑な言語パターンを学習できるかの理論的裏付け。形式言語理論によるTransformerの正式な表現力評価。
