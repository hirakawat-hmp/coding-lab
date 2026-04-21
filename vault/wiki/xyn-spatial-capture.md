---
type: entity
status: []
tags:
  - media/3d
  - ai/computer-vision
sources:
  - "https://3dnchu.com/archives/xyn-spatial-capture-solution/"
created: 2026-04-21
updated: 2026-04-21
---

# XYN Spatial Capture Solution（Sony）

Sony が2026年4月14日に法人向けに提供開始した空間キャプチャーソリューション。実在する物体・空間から高品質な 3D CG アセットを作成し、映画・ゲーム・メタバース制作のワークフローを効率化する。

## 3 つの構成要素

### 1. XYN Spatial Scan Navi（スマートフォンアプリ）

- Sony α シリーズミラーレスカメラによる空間コンテンツキャプチャを支援
- AR ナビゲーション・リアルタイムプレビュー・スマートアシスト機能
- 撮影ガイドによって非専門家でも一定品質を担保

### 2. XYN Spatial Scan（クラウドアプリ）

- Sony 独自アルゴリズムで被写体の形状・テクスチャを精密推定
- 最小設定で高品質な 3D アセットを自動生成

### 3. XYN Spatial Renderer Plugin（ベータ、レンダリングプラグイン）

- 対応ソフトウェア: **Unreal Engine**, **Disguise**, **Pixotope**
- プロダクション品質のレンダリング出力

## 主な用途

- **バーチャルプロダクション**: In-Camera VFX、グリーンスクリーン代替
- **映画/VFX 制作**: リアル素材から 3D プロップ生成
- **ゲーム**: フォトリアルな実環境アセット

## 制限

- **Sony α シリーズミラーレスカメラが必須** → 個人クリエイターより **プロダクションスタジオ向け** の位置付け

## 関連ページ

- [[wiki/niagara-automotive-ue5]] — UE5.7 Niagara VFX コース（Unreal Engine 利用の隣接領域）
- [[wiki/sam3-1]] — Meta の Segment Anything Model 3.1（空間理解 AI の関連技術）
- [[wiki/meshtailor]] — AI による 3D メッシュ UV シーム生成（3D アセット生成の別アプローチ）
