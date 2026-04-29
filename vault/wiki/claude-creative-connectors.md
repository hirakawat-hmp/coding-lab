---
type: entity
status: []
tags:
  - ai/llm
  - ai/agent
  - tool/mcp
  - media/3d
sources:
  - "https://www.itmedia.co.jp/aiplus/articles/2604/29/news027.html"
created: 2026-04-29
updated: 2026-04-29
---

# Claude クリエイティブコネクタ（Blender・Photoshop 直接制御）

Anthropic が2026年4月28日発表。Claude を複数のクリエイティブソフトウェアに直接接続する「コネクタ」機能。クリエイティブ専門家が Claude を制作ワークフローに統合できる。

## 対応する 8 コネクタ

| コネクタ | 用途 |
|---|---|
| **Ableton Live/Push** | DAW ソフトウェアとのドキュメント連携 |
| **Adobe Creative Cloud** | Photoshop・Premiere 等 50 以上のツール |
| **Affinity by Canva** | 画像編集・レイアウト |
| **Autodesk Fusion** | 3D モデリング・編集 |
| **Blender** | Python API アクセスと統合 |
| **Resolume Arena/Wire** | VJ パフォーマンス対応 |
| **SketchUp** | 3D モデル設計 |
| **Splice** | オーディオサンプルライブラリ |

## 設計思想

> 「Claude はクリエイターのセンスを置き換えるものではなく、大規模なプロジェクトで実装をサポートする存在」— Anthropic

AI がクリエイターの意思決定の上位に立つのではなく、複雑な実装タスク（スクリプト記述・バッチ処理・アセット管理等）をサポートするポジショニング。

## 技術的含意

Blender コネクタは Python API 経由でオブジェクト操作・マテリアル設定・レンダリング制御が可能になる。[[wiki/blender-buddy]] が提供するローカル LLM による Blender 操作と異なり、Claude のクラウド推論能力を使う公式統合。

## 関連ページ

- [[wiki/blender-buddy]] — Blender Buddy（ローカル LLM ベースの類似ツール）
- [[wiki/claude-design]] — Claude Design（UI デザイン向けの Anthropic ツール）
- [[wiki/tool/mcp]] — MCP による外部ツール統合の仕組み
- [[wiki/hitem3d-2]] — 3D アセット生成 AI（クリエイティブ AI の別軸）
