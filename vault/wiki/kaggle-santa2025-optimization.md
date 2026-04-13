---
tags:
  - source
sources:
  - "santa2025_architecture.md"
created: 2026-04-06
updated: 2026-04-06
---

# Kaggle Santa 2025 最適化コンペ

Kaggle Santa 2025 コンペティションのソリューションアーキテクチャ。15頂点の多角形（ツリー）を n 個、最小面積のバウンディングボックスに配置する二次元パッキング問題。

## 最適化パイプライン

5段階のパイプラインで解を改善する:

1. **初期配置生成**: ランダムまたはヒューリスティックで初期解を作成
2. **Simulated Annealing (SA)**: 指数減衰の温度スケジュールで探索。近傍操作は位置微調整と回転
3. **Squeeze（圧縮）**: 配置を圧縮して隙間を詰める
4. **Local Search（局所探索）**: 局所的な改善を繰り返す
5. **Compaction（最終圧縮）**: 最終的な圧縮処理

並列リスタート（OpenMP）で複数の初期状態から並列探索し、各スレッドが独立した RNG を使用する。

## データ構造

- **Cfg (Configuration)**: n 個のツリー配置を管理。位置 (x, y) と角度 (deg) を保持。`side()` でバウンディングボックスサイズ、`anyOvl()` で衝突判定
- **Poly (Polygon)**: 15頂点の多角形。衝突判定に SAT (Separating Axis Theorem) を使用

## スコア計算

```
LB = sum(side^2 / n) for n = 1 to 200
```

効率指標は `efficiency = side / theoretical_min_side` で、低いほど良い（改善余地が少ない）。

## 精度管理

C++ の double 精度と Python/Shapely の精度差が問題になる。C++ 内部は15桁精度で計算し、CSV 出力は6桁精度（コンペ制約）。最終検証は Python の `finalize.py` で微小衝突を修正する。

## 重点最適化対象

n=1-30 は LB スコア寄与が大きく効率が悪い（改善余地あり）ため、集中最適化の対象。
