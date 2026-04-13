---
tags:
  - concept
sources:
  - "[[raw/2026-04-06-transformers-are-bayesian-networks]]"
created: 2026-04-06
updated: 2026-04-06
---

# Belief Propagation（確率伝播）

確率的グラフィカルモデル上でのメッセージパッシングによる推論アルゴリズム。ベイジアンネットワークやマルコフ確率場での周辺確率計算に使用される。Judea Pearl が提案。

## 基本概念

- **因子グラフ（Factor Graph）**: 変数ノードと因子ノードからなる二部グラフ。確率分布の分解構造を表現
- **メッセージパッシング**: ノード間でメッセージ（局所的な確率情報）を反復的に交換し、各変数の周辺確率を計算
- **Gather/Update アルゴリズム**: Pearl の定式化。各ノードが隣接ノードからメッセージを収集（gather）し、自身の信念を更新（update）する

## 分類

### Exact BP（厳密な確率伝播）
- 木構造のグラフィカルモデルでは、有限回のメッセージパッシングで厳密な周辺確率が得られる
- 循環依存がない場合に保証される

### Loopy BP（ループ確率伝播）
- 循環を含むグラフに BP を適用したもの
- 収束の理論的保証は一般にないが、実用上は多くのケースで良好な近似を与える
- [[wiki/transformers-are-bayesian-networks]] では、Transformer の各層がループ BP の1ラウンドに対応することが示された

## Transformer との関係

Coppola (2026) の "[[wiki/transformers-are-bayesian-networks]]" により、以下の対応が確立された:

| Transformer 構成要素 | BP における役割 |
|---|---|
| Attention 層 | AND 演算（gather） |
| FFN 層 | OR 演算（update） |
| 1 Transformer 層 | BP 1ラウンド |
| Sigmoid activation | 確率の計算 |

この対応は、Transformer がなぜ機能するかについて確率的推論の観点から説明を与える。

## 関連ページ

- [[wiki/transformers-are-bayesian-networks]] — Transformer = ベイジアンネットワークの証明
