---
tags:
  - entity
sources:
  - "[[raw/2026-04-07-design-md-research.md]]"
created: 2026-04-07
updated: 2026-04-07
---

# Google Stitch

Google が開発した、デザインシステム仕様から UI を生成するツール。[[wiki/design-md|DESIGN.md]] フォーマットの提唱元。

## 概要

- Markdown で記述されたデザインシステム仕様を読み取り、UI コンポーネントを生成
- 9セクション構造の DESIGN.md フォーマットを標準化
- このフォーマットが [[wiki/awesome-design-md]] リポジトリのデファクト標準として採用されている

## DESIGN.md との関係

Stitch が定義した9セクション構造（Visual Theme, Color Palette, Typography, Component Stylings, Layout, Depth & Elevation, Do's/Don'ts, Responsive, Agent Prompt Guide）は、AI エージェント全般で使える汎用フォーマットとして広まった。Stitch 専用ではなく、Claude Code / Cursor / v0 等どのツールでも利用可能。
