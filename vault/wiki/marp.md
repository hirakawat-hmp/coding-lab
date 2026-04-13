---
type: entity
status: []
tags:
  - tool/marp
  - dev/markdown
  - project/aaas-ai-planner
sources:
  - "[[raw/2026-04-06-marp-claude-workflow]]"
created: 2026-04-06
updated: 2026-04-06
---

# Marp

Markdown から HTML / PDF / PPTX スライドを生成するフレームワーク。テキストベースのためバージョン管理・AI 生成との相性が良い。

- **リポジトリ**: https://github.com/marp-team/marp
- **CLI**: `@marp-team/marp-cli`
- **言語**: TypeScript

## 基本構造

```markdown
---
marp: true
theme: default
paginate: true
---

# スライド1

内容

---

# スライド2

内容
```

- `---` でスライドを区切る
- フロントマターでテーマ・ページ番号等を設定
- 標準 Markdown（見出し、リスト、コードブロック、画像）

## 出力フォーマット

| フォーマット | コマンド | 品質 |
|------------|---------|------|
| HTML | `marp --html slides.md` | ネイティブ（最高） |
| PDF | `marp --pdf slides.md` | Chromium レンダリング（高品質） |
| PPTX | `marp --pptx slides.md` | Chromium + LibreOffice（非ネイティブ） |

**注意**: PPTX 出力はスライド画像をプレースホルダーに配置する方式のため、テキスト編集不可。ネイティブな PPTX が必要な場合は [[wiki/pptxgenjs]] や [[wiki/python-pptx]] を使うべき。

## テーマシステム

- 組み込みテーマ: `default`, `gaia`, `uncover`
- カスタム CSS テーマを `@import` で読み込み可能
- `<!-- _class: lead -->` でスライドごとにクラス適用

## Claude Code との統合パターン

### ワークフロー

1. ユーザーがアウトライン（自由形式）を作成
2. Claude Code がアウトラインを Marp Markdown に変換
3. Marp CLI で PDF / HTML にエクスポート
4. 必要に応じて反復改善

### エコシステム

- **Marp MCP Server**: プロジェクト初期化 + 6レイアウトテンプレート + AI エディタ統合
- **Marp Slide Quality Optimizer**: SlideGauge による品質分析・自動改善
- **llm-marp-slides**: CLAUDE.md テンプレート（source/generated ディレクトリ分離）

### 利点

- LLM は Markdown を生成するだけ（最も低コスト）
- Git で差分管理が容易
- CSS でデザインを一括制御
- テキストエディタだけで編集可能

### 制約

- PPTX 出力の編集性が低い（画像ベース）
- 複雑なレイアウト（マルチカラム、自由配置）は CSS ハックが必要
- チャート・グラフはネイティブ非対応（画像で挿入）

## 関連ページ

- [[wiki/ai-pptx-generation-overview]] — PPTX 生成の全体像
- [[wiki/pptx-generation-comparison]] — アプローチ比較
