---
type: entity
status: []
tags:
  - ai/computer-vision
  - media/3d
sources:
  - "https://3dnchu.com/archives/liveactionaov/"
created: 2026-04-30
updated: 2026-04-30
---

# LiveActionAOV — 実写映像から AI で AOV パスを抽出する OSS

## 概要

Leonardo Paolini が制作・公開したオープンソースツール。実写（ライブアクション）映像から AI を使って複数の AOV（Arbitrary Output Variables）パスを自動抽出し、VFX 合成に使える Nuke 対応 EXR ファイルとして出力する。

## 生成できる AOV パス

| パス | 内容 |
|------|------|
| Z-depth | 奥行き情報 |
| Surface Normals | 面の法線ベクトル |
| Position | ワールド座標位置 |
| Optical Flow（前後方） | 動きベクトル |
| RGBA Hero Matte | セマンティックセグメンテーションによるマスク |
| SSAO | スクリーンスペースアンビエントオクルージョン |

## 特徴

- 実写素材から「CG品質のAOVパス」を生成
- シングルコマンドで処理完結
- 出力: Nuke 対応サイドカー EXR ファイル

## 技術スタック

| 技術 | 用途 |
|------|------|
| PyTorch | 推論フレームワーク |
| Depth Anything V2 | 奥行き推定 |
| SAM 3 | セグメンテーション |
| RAFT | オプティカルフロー |
| OpenImageIO | 画像入出力 |

## 要件・ライセンス

- NVIDIA GPU 必須（RTX 5090 でテスト済み）
- MIT ライセンス（モデル固有の制限あり）
- GitHub: lettidude/LiveActionAOV

## 意義

これまで CG 素材でしか利用できなかった AOV パスが、実写素材に対しても自動生成できるようになる。VFX コンポジターのワークフローを大幅に簡素化できる可能性がある。

## 関連ページ

- [[wiki/zibragds-ue5]] — ZibraGDS（UE5 向けジオメトリシーケンス高速再生）
- [[wiki/sam3-1]] — Meta SAM 3.1（セグメンテーションの基盤技術）
