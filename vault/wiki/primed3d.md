---
type: entity
status: []
tags:
  - media/3d
sources:
  - "https://3dnchu.com/archives/primed3d/"
  - "https://primed3d.3drevolution.net/"
created: 2026-04-25
updated: 2026-04-25
---

# Primed3D

3D Revolution が開発する、マルチカラー FDM 3D プリンタ向けフルカラー表現ウェブツール。少数のフィラメント（3〜5色）でフルカラー出力を実現するディザリング技術を採用。

## 主な機能

| 機能 | 説明 |
|------|------|
| 直接ペイント | 3D モデル上にペイントツールで直接描画 |
| グラデーション | カラーグラデーション適用 |
| 画像投影 | 写真・画像をモデルに投影してテクスチャ化 |
| 3MF 出力 | 各種スライサー（BambuStudio、PrusaSlicer 等）に対応 |

## 技術

**ディザリング処理**：ピクセルの誤差拡散アルゴリズムを 3D プリンタ向けに応用。例えば黄色を表現する場合、赤と緑のフィラメントを細かく混在させることで目の錯覚により中間色に見せる。

## 制約

- 近距離では粗く見える（ディザリングの性質上）
- マルチカラー対応プリンタが必要
- 印刷時間が長くなる傾向

## 利用条件

無料で利用可能。URL：https://primed3d.3drevolution.net/

## 関連ページ

- [[wiki/hitem3d-2]] — AI 3D アセット生成（別アプローチ）
- [[wiki/sato-strips-as-tokens]] — AI によるアーティスト品質 3D メッシュ生成
