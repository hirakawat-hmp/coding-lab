---
url: "https://github.com/karaage0703/llm-marp-slides"
title: "Marp + Claude Code によるスライド生成ワークフロー"
date_fetched: 2026-04-06
---

# Marp + Claude Code ワークフロー

Markdown → スライド変換を Claude Code で自動化するアプローチ。

## ワークフロー

1. ユーザーが `source/outline.md` にフリーフォーム・アウトラインを作成
2. Claude Code がアウトラインを Marp フォーマットの Markdown に変換
3. `generated/slides.md` に保存
4. Marp CLI で HTML / PDF / PPTX にエクスポート

## ディレクトリ構成

- `projects/{project}/source/` — 編集可能なアウトライン + 画像
- `projects/{project}/generated/` — AI 生成された Marp Markdown + テーマ

## Marp スライドの書式

- ヘッダー: `marp: true`, `theme`, `paginate` 設定
- `---` でスライド区切り
- 標準 Markdown の見出し階層
- 相対パスでの画像参照

## エコシステム

- Marp MCP Server: プロジェクト初期化、6レイアウトテンプレート、AI エディタ統合
- Marp Slide Quality Optimizer: 品質分析 + 自動改善
- llm-marp-slides: Claude Code 用 CLAUDE.md テンプレート

## 出力

- HTML（Web 公開向け）
- PDF（印刷 / 共有向け）
- PPTX（Chromium + LibreOffice 経由、非ネイティブ）
