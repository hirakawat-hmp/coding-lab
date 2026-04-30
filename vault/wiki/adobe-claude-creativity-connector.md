---
type: entity
status: []
tags:
  - ai/image-gen
  - tool/claude-code
  - tool/mcp
sources:
  - "https://qiita.com/katoriko/items/d3d6fa09e226999a6dd1"
created: 2026-04-30
updated: 2026-04-30
---

# Adobe for Creativity Connector — Claude から Adobe Creative Cloud を直接操作

## 概要

2026年4月28日にリリースされた Claude 公式コネクタ。Claude のチャットインターフェイスから Adobe Creative Cloud の各アプリケーションを直接操作できる。

## 対応機能

### 画像編集（Photoshop・Lightroom）

- 明るさ・露出・色温度・HSL 調整
- Generative Fill（AI 生成塗りつぶし）
- 背景削除・被写体選択・画像拡張

### デザイン作成（Illustrator・Adobe Express）

- テンプレート生成、アニメーション
- マルチステップワークフロー

### 映像編集（Premiere）

- 簡易カット編集
- フォーマット変換・リサイズ

### アセット管理

- Adobe Stock 統合
- ブランドガイドラインの参照
- データマージ・PDF 変換

## 制限事項

- 大幅なアスペクト比差（4.5倍以上）のレイアウト自動変換は非対応
- 一部の複雑な操作は手動介入が必要

## 位置付け

[[wiki/claude-creative-connectors]] で説明されているクリエイティブコネクタ群の一部。Adobe が 8 ツール連携の中でも最も機能が豊富なコネクタの一つとして位置付けられる。

## 関連ページ

- [[wiki/claude-creative-connectors]] — Claude クリエイティブコネクタ全体（Blender・Photoshop 等 8 ツール）
- [[wiki/chatgpt-images-2]] — ChatGPT Images 2.0（競合の AI 画像生成機能）
