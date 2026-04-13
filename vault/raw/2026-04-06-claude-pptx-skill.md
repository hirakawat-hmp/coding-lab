---
url: "https://github.com/anthropics/claude-code-config (local: ~/repos/claude-code-config/skills/pptx/)"
title: "Claude Code PPTX Skill — PptxGenJS + XML 編集ベースのプレゼンテーション生成"
date_fetched: 2026-04-06
---

# Claude Code PPTX Skill

Anthropic 公式の Claude Code skill。PPTX ファイルの読み取り・編集・新規作成を統合的にカバーする。

## 3つのワークフロー

1. **Reading**: `markitdown` でテキスト抽出、`thumbnail.py` でビジュアル概要
2. **Editing（テンプレートベース）**: unpack → XML 直接編集 → clean → pack
3. **Creating（ゼロから作成）**: PptxGenJS で JavaScript コードから生成

## PptxGenJS による新規作成

- Node.js ライブラリ、ゼロ依存
- テキスト、画像、チャート、テーブル、シェイプを API で追加
- react-icons + sharp でアイコンを SVG → PNG 変換して埋め込み
- Slide Master でレイアウトテンプレートを定義可能

### デザインガイドライン（skill 内蔵）

- トピック固有のカラーパレット選択（10パターン提供）
- フォントペアリング（Georgia + Calibri 等）
- レイアウトバリエーション（2カラム、アイコングリッド、大数値コールアウト等）
- アクセントライン禁止（AI 生成の典型パターンを避ける）

## XML 編集ワークフロー

- `unpack.py`: PPTX → XML（pretty-print、スマートクォート処理）
- `add_slide.py`: スライド複製・レイアウトからの追加
- `clean.py`: 孤立ファイル除去
- `pack.py`: 再パック + バリデーション
- Edit ツールで XML 直接編集（sed やスクリプトではなく）

## QA プロセス

- Content QA: markitdown でテキスト確認
- Visual QA: soffice → PDF → pdftoppm → JPEG → サブエージェントで目視検査
- 最低1回の修正→再検証サイクル必須
