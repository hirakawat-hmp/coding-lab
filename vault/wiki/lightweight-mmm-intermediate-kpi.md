---
type: concept
status: []
tags:
  - stats/mmm
  - dev/python
  - ai/eval
sources:
  - "intermediate_kpi_implementation_plan.md"
  - "implementation_qa_summary.md"
  - "modification_goals.md"
created: 2026-04-06
updated: 2026-04-06
---

# LightweightMMM 中間KPI拡張

Google の LightweightMMM を拡張し、メディア支出と最終KPI（売上など）の間に位置する中間KPI（サイト訪問、ブランド検索、エンゲージメントなど）をモデリングする機能を追加するプロジェクト。

## 背景と目的

標準的な MMM は `Media Spend -> Final KPI` の直接関係のみをモデル化する。中間KPI拡張は `Media Spend -> Intermediate KPIs -> Final KPI` というファネル構造を表現し、間接効果（媒介効果）を捉えることで ROI 推定精度を向上させる。

## モデル構造

### 統合推定（1回の fit）

2段階推定（Two-Stage Least Squares）ではなく、2つの likelihood を持つ統合モデルを1回の MCMC サンプリングで推定する。これにより不確実性が Stage 1 から Stage 2 へ正しく伝播する。

```
Stage 1: media -> intermediate KPI (likelihood 1)
Stage 2: media + intermediate KPI -> sales (likelihood 2)
```

NumPyro で `numpyro.sample("intermediate_kpi_obs", ...)` と `numpyro.sample("target", ...)` の2つの観測モデルを定義する構造方程式モデル（SEM）に相当する。

### パス設計（influenced_by）

`influenced_by` パラメータでどのメディアチャネルがどの中間KPIに影響するかを柔軟に制御できる。ドメイン知識を活用してパスを選択的に構築し、パラメータ数の削減と識別可能性の向上を図る。

### コストなし中間KPI

`own_channel=None` を指定することで、オーガニック検索のようなコストが発生しない中間KPIもサポートする。この場合、クロスメディア効果のみがモデル化される。

## 予算最適化

コストあり/なしの中間KPIが混在しても最適化ロジックは同一。JAX の自動微分が直接効果と間接効果（媒介効果経由）の両方を含む勾配を自動計算する。

## データ管理

- **入力形式**: Spend ベースを推奨（全チャネル統一、ROI 計算が直感的）
- **設定管理**: CSV（数値データ）+ YAML（構造・マッピング・日本語説明）の分離
- **バリデーション**: 設定ファイルとデータの整合性を検証する関数を実装

## 実務上の制約

- 中間KPIは実務的に2-3個が限界（計算時間、識別可能性）
- 中間KPI 3個で約21パラメータ（標準 MMM の4パラメータに対して）
- モデル比較は WAIC や LOO で実施
- ROI 推定精度 +30-50%、予算配分効率 +15-25% の改善が期待される

## 関連ページ

- [[wiki/parameter-recovery-validation]] -- 中間KPIモデルのパラメータ復元検証
