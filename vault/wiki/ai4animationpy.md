---
type: entity
status: []
tags:
  - media/3d
  - ai/llm
sources:
  - "https://3dnchu.com/archives/ai4animationpy/"
  - "https://github.com/facebookresearch/ai4animationpy"
created: 2026-04-22
updated: 2026-04-22
---

# AI4AnimationPy

Meta Research（Paul Starke・Sebastian Starke）が 2026 年 4 月 21 日に公開した、**ニューラルネットワークを用いた AI 駆動キャラクターアニメーションの Python フレームワーク**。

Unity 依存だった元の [AI4Animation](https://github.com/sebastianstarke/AI4Animation) をゲームエンジン不要の Python 環境に移植。NumPy と PyTorch をベースとする。

## アーキテクチャ

- **ECS（Entity-Component-System）**: ゲームエンジン的なライフサイクル管理
- **ベクトル演算ライブラリ**: クォータニオン・行列・オイラー角対応
- **NN アーキテクチャ**: MLP、オートエンコーダ、フローマッチング、コードブックマッチング
- **IK ソルバー**: モーションモジュール（ルート軌跡・関節コンタクト）

## 入力フォーマット

GLB・FBX・BVH のインポートパイプライン対応。

## 実行モード

| モード | 説明 |
|---|---|
| standalone | 単体実行 |
| headless | UI なしバッチ処理 |
| manual | 手動ステップ制御 |

オプションで **Raylib** によるリアルタイムレンダリング可。

## 意義

従来の AI キャラクターアニメーション研究は Unity と密結合しており、再現・比較が困難だった。Python 化により研究コミュニティへのアクセシビリティが大幅に向上する。

## 関連ページ

- [[wiki/freemocap]] — ウェブカメラ複数台のオープンソースモーションキャプチャ
- [[wiki/sato-strips-as-tokens]] — SIGGRAPH 2026 採択の 3D メッシュ生成 AI
- [[wiki/meshtailor]] — グラフ Transformer による 3D メッシュ UV シーム自動生成
