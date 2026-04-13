---
type: entity
status: []
tags:
  - tool/python-pptx
  - dev/python
  - project/aaas-ai-planner
sources:
  - "[[raw/2026-04-06-ai-pptx-landscape]]"
  - "[[raw/2026-04-06-pptagent]]"
created: 2026-04-06
updated: 2026-04-06
---

# python-pptx

Python で PPTX ファイルを読み書きする定番ライブラリ。AI エージェントによるプレゼン生成・解析の基盤技術として広く採用されている。

- **PyPI**: https://pypi.org/project/python-pptx/
- **言語**: Python
- **ライセンス**: MIT

## 主要機能

- スライドの追加・削除・並べ替え
- テキスト（段落、フォント、箇条書き）
- テーブル（セル結合対応）
- チャート（棒、折れ線、円、散布図等）
- 画像の挿入・サイズ調整
- シェイプ（矩形、楕円、フリーフォーム）
- スライドレイアウト・マスターの操作
- プレースホルダーの検出と内容置換
- OLE オブジェクト（埋め込み Excel 等）の読み取り

## AI エージェントとの組み合わせパターン

### パターン 1: LLM → Python コード → python-pptx

LLM が python-pptx を呼び出す Python コードを生成。最もシンプルなアプローチ。

```python
from pptx import Presentation
from pptx.util import Inches, Pt

prs = Presentation()
slide = prs.slides.add_slide(prs.slide_layouts[1])
slide.shapes.title.text = "AI Generated Slide"
slide.placeholders[1].text = "Content here"
prs.save("output.pptx")
```

### パターン 2: テンプレート + コンテンツ注入

既存テンプレートのプレースホルダーに AI 生成コンテンツを注入:

```python
prs = Presentation("template.pptx")
for slide in prs.slides:
    for shape in slide.shapes:
        if shape.has_text_frame:
            # プレースホルダーテキストを AI 生成テキストで置換
            pass
```

### パターン 3: リファレンスベース生成（PPTAgent）

[[wiki/pptagent]] が採用するアプローチ。リファレンス PPTX からスライドの機能タイプとスキーマを学習し、新しいコンテンツで再構築する。

### パターン 4: 解析 → 構造化 → 再生成

[[wiki/pptx-analysis-pipeline]] で記述されている3段階解析パイプラインの入力側で使用。コンテンツ抽出（テキスト、表、グラフ、埋め込み Excel）を担当。

## Python エコシステムとの連携

- **pandas**: DataFrame → テーブルスライド
- **matplotlib / plotly**: チャート画像 → スライド埋め込み
- **openpyxl**: 埋め込み Excel の読み取り
- **pdfplumber**: PDF からのデータ抽出と組み合わせ

## PptxGenJS との比較

| 観点 | python-pptx | [[wiki/pptxgenjs]] |
|------|-------------|------------|
| 言語 | Python | JavaScript |
| テンプレート操作 | 強い（既存 PPTX の読み書き） | 弱い（新規作成のみ） |
| チャート品質 | ネイティブ OOXML チャート | ネイティブ OOXML チャート |
| データ分析連携 | pandas / matplotlib と直接連携 | 外部処理が必要 |
| Claude Code 相性 | Bash で Python 実行 | Node.js で直接実行（公式 skill） |

## 関連ページ

- [[wiki/ai-pptx-generation-overview]] — PPTX 生成の全体像
- [[wiki/pptx-generation-comparison]] — アプローチ比較
- [[wiki/pptxgenjs]] — JavaScript 版の類似ライブラリ
- [[wiki/pptagent]] — python-pptx を基盤とするエージェント
- [[wiki/pptx-analysis-pipeline]] — PPTX 解析パイプライン
