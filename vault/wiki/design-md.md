---
type: concept
status: []
tags:
  - design/system
  - dev/markdown
  - tool/claude-code
sources:
  - "[[raw/2026-04-07-design-md-research.md]]"
created: 2026-04-07
updated: 2026-04-07
---

# DESIGN.md

AI エージェントが一貫した UI を生成するためのプレーンテキスト・デザインシステム記述フォーマット。[[wiki/google-stitch]] が提唱し、プロジェクトルートに置くだけで LLM が自然にパースできる。

## コンセプト

- デザインシステム（カラー、タイポグラフィ、コンポーネント、レイアウト）を **1つの Markdown ファイル** に凝縮
- Figma や Sketch のような専用ツール不要 — テキストエディタだけで編集可能
- LLM にとって Markdown は最も読みやすいフォーマットであり、特別なパーサーが不要
- 非デザイナーでも既存の DESIGN.md をコピーするだけで高品質な UI を AI に生成させられる

## 9セクション構造（Stitch 標準フォーマット）

| # | セクション | 内容 |
|---|-----------|------|
| 1 | Visual Theme & Atmosphere | ムード、密度、デザイン哲学 |
| 2 | Color Palette & Roles | セマンティック名、hex値、機能的用途 |
| 3 | Typography Rules | フォントファミリー、階層テーブル |
| 4 | Component Stylings | ボタン、カード、インプット、ナビゲーション（各状態含む） |
| 5 | Layout Principles | スペーシングスケール、グリッドシステム、余白哲学 |
| 6 | Depth & Elevation | シャドウシステム、サーフェス階層 |
| 7 | Do's and Don'ts | デザインガードレール、アンチパターン |
| 8 | Responsive Behavior | ブレークポイント、タッチターゲット、折りたたみ戦略 |
| 9 | Agent Prompt Guide | クイックカラーリファレンス、すぐ使えるプロンプト |

## AI ツールでの使い方

1. 対象サイトの DESIGN.md をプロジェクトルートにコピー
2. AI エージェントに「DESIGN.md に従ってスタイリングして」と指示
3. Claude Code、Cursor、v0 等どの AI コーディングツールでも動作

## 実例：Stripe の DESIGN.md

- カスタム `sohne-var` フォント、20以上のタイポグラフィロール
- 8px ベースユニットのスペーシング、1080px max-width グリッド
- 5段階のシャドウ階層（ブランドネイビーを反映した「chromatic depth」）
- ボタン3バリアント、カード、バッジ、インプットの詳細スタイル指定

## 関連リソース

- [[wiki/awesome-design-md]] — 58サイト分の DESIGN.md コレクション
- [[wiki/awesome-design-md-jp]] — 日本語版（和文タイポグラフィ対応、9サービス）
- [[wiki/google-stitch]] — DESIGN.md フォーマットの提唱元ツール
