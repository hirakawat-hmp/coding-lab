# Raw: LiveActionAOV

Source: https://3dnchu.com/archives/liveactionaov/
Fetched: 2026-04-30

## Summary

Leonardo Paolini 制作のオープンソースツール。実写映像から AI を使って複数の AOV パスを抽出する。

## 生成できる AOV パス

- Z-depth マッピング
- サーフェス法線
- ポジションデータ
- 光学フロー（前方・後方）
- RGBA ヒーローマット（セマンティックセグメンテーション）
- スクリーンスペースアンビエントオクルージョン

## 出力

Nuke 対応サイドカー EXR ファイル

## 技術スタック

PyTorch、OpenImageIO、Depth Anything V2、SAM 3、RAFT

## 要件

NVIDIA GPU（RTX 5090 でテスト済み）

## ライセンス

MIT（モデル固有の制限あり）

GitHub: lettidude/LiveActionAOV
