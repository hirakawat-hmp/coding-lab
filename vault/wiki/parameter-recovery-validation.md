---
type: concept
status: []
tags:
  - stats/mmm
  - stats/bayesian
  - dev/python
  - ai/eval
sources:
  - "parameter_recovery_implementation_plan.md"
  - "parameter_recovery_validation_implementation.md"
created: 2026-04-06
updated: 2026-04-06
---

# パラメータリカバリー検証

ベイズモデルの推定パラメータが真の値をどれだけ正確に復元できているかを検証する手法。Simulation-Based Calibration (SBC) の簡易版に相当する。

## 基本的な考え方

1. 既知の真のパラメータでシミュレーションデータを生成する
2. そのデータでモデルを推定する
3. 事後分布と真の値を比較し、推定精度を評価する

## 実装パターン: Single Source of Truth

真のパラメータを JSON ファイルに一元管理し、データ生成スクリプトとバリデーションスクリプトの両方がこの JSON を参照する。これにより再現性が保証される。

```
true_parameters.json (Single Source of Truth)
  |
  +-> データ生成スクリプト（JSON から読み込み、シミュレーションデータを生成）
  +-> バリデーションスクリプト（JSON の真値と事後分布を比較）
```

## 診断指標

| 指標 | 説明 | 判定基準 |
|------|------|----------|
| Posterior Mean | 事後分布の平均値 | 真値に近いほど良い |
| 95% Credible Interval | ベイズ信用区間 | 真値を含むべき |
| Bias | 事後平均 - 真値 | 0 に近いほど良い |
| Relative Bias | Bias / 真値 (%) | |Bias| < 20% で許容 |
| Coverage Rate | 95% CI が真値を含む割合 | >= 80% で well-calibrated |
| RMSE | 二乗平均平方根誤差 | 低いほど良い |

### 判定閾値

- **Good**: 95% CI が真値を含む、|Bias| < 10%
- **Acceptable**: 90% CI が真値を含む、|Bias| < 20%
- **Poor**: 90% CI 外、|Bias| > 20%

## 可視化

3種類のプロットで結果を表現する:

1. **Adstock Parameters Plot**: 事後分布のヒストグラムに真値（赤破線）と事後平均（緑実線）を重ねる
2. **Media Coefficients Forest Plot**: Stage 別に色分けした95% CI の横棒グラフ。真値を赤ダイヤモンドで表示
3. **Coverage Summary Plot**: パラメータごとのカバレッジ状況を横棒グラフで表示（緑=含む、赤=含まない）

## LightweightMMM での適用実績

Beauty Brand MMM チュートリアルに Step 11.5 として統合。TDD で実装し、テストカバレッジ 98%。

- Adstock パラメータ: 10個（チャネル別 lag_weight）
- Media Coefficients: 17個（Stage 1/2/3 の各係数）
- 合計: 27 パラメータの検証
- 再利用可能モジュール: `lightweight_mmm/parameter_recovery.py`

## 汎用的な知見

- パラメータリカバリーはモデルのフィッティングが悪い原因の切り分けに有効（パラメータ推定の問題 vs モデル構造の問題）
- 理論的には 95% CI のカバレッジ率は 95% に近いべき（nominal coverage）
- 飽和パラメータ（Hill function）は複雑な変換を含むため直接的な復元が難しい場合がある
- TDD で実装すると設計が明確になり、モジュール化も自然に進む

## 関連ページ

- [[wiki/lightweight-mmm-intermediate-kpi]] -- パラメータリカバリーの適用対象となった MMM 拡張
