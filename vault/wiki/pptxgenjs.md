---
tags:
  - entity
sources:
  - "[[raw/2026-04-06-claude-pptx-skill]]"
  - "[[raw/2026-04-06-ai-pptx-landscape]]"
created: 2026-04-06
updated: 2026-04-06
---

# PptxGenJS

JavaScript / TypeScript で PPTX ファイルをプログラマティックに生成するライブラリ。Claude Code 公式 pptx skill の中核技術。

- **リポジトリ**: https://github.com/gitbrent/PptxGenJS
- **言語**: JavaScript / TypeScript
- **依存**: ゼロ（ESM + CJS デュアルビルド）
- **動作環境**: Node.js, ブラウザ, React, Angular, Electron, Vite

## 主要機能

- **テキスト**: リッチテキスト配列、bullet リスト、charSpacing、margin 制御
- **画像**: ファイルパス / URL / Base64、sizing（contain, cover, crop）、SVG 対応
- **チャート**: BAR, LINE, PIE, DOUGHNUT, SCATTER, BUBBLE, RADAR
- **テーブル**: セル結合（colspan）、カスタムスタイル
- **シェイプ**: RECTANGLE, OVAL, LINE, ROUNDED_RECTANGLE、シャドウ、透過
- **Slide Master**: レイアウトテンプレートの定義と再利用
- **HTML テーブル変換**: `tableToSlides` で DOM テーブルをスライド化

## アイコン統合パターン

react-icons + sharp を組み合わせて SVG → PNG 変換し、Base64 で埋め込む:

```javascript
const React = require("react");
const ReactDOMServer = require("react-dom/server");
const sharp = require("sharp");

async function iconToBase64Png(IconComponent, color, size = 256) {
  const svg = ReactDOMServer.renderToStaticMarkup(
    React.createElement(IconComponent, { color, size: String(size) })
  );
  const pngBuffer = await sharp(Buffer.from(svg)).png().toBuffer();
  return "image/png;base64," + pngBuffer.toString("base64");
}
```

## 主要な落とし穴

1. **色指定に `#` をつけない**: `"FF0000"` が正しい（`"#FF0000"` はファイル破損）
2. **8桁 hex で透過を指定しない**: `opacity` プロパティを使う
3. **Unicode bullet (`•`) を使わない**: `bullet: true` を使う
4. **オプションオブジェクトを再利用しない**: PptxGenJS が内部で mutate するため毎回新規作成
5. **shadow の offset に負値を使わない**: ファイル破損。上方向は `angle: 270` で実現
6. **ROUNDED_RECTANGLE にアクセントバーを重ねない**: 角丸がカバーされない

## Claude Code との統合

公式 pptx skill では以下のワークフローで使用:

1. Claude がスライド内容を設計（カラーパレット、レイアウト選択）
2. JavaScript コードを生成して PptxGenJS API を呼び出し
3. `pres.writeFile()` で PPTX 出力
4. Visual QA: soffice → PDF → pdftoppm → JPEG → サブエージェント検査
5. 修正→再検証のループ

## 関連ページ

- [[wiki/ai-pptx-generation-overview]] — PPTX 生成の全体像
- [[wiki/pptx-generation-comparison]] — アプローチ比較
- [[wiki/python-pptx]] — Python 版の類似ライブラリ
