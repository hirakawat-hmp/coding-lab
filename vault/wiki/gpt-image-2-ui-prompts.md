---
type: how-to
status: [draft]
tags:
  - ai/image-gen
  - ai/prompt-engineering
  - design/system
sources:
  - "https://qiita.com/nogataka/items/fed4cba1439d0073f2d5"
created: 2026-04-26
updated: 2026-04-26
---

# gpt-image-2 UI生成プロンプトテンプレート集

![gpt-image-2 UIプロンプト](https://qiita-user-contents.imgix.net/https%3A%2F%2Fraw.githubusercontent.com%2Fnogataka%2Fqiita-images%2Fmain%2Fgpt-image-2-ui-prompt-templates%2Fcover.png)

gpt-image-2（OpenAI）を使ってUIのラフ案・ビジュアルカンプを効率的に作成するための実務向けプロンプトテンプレート集。

## gpt-image-2の主な改善点（gpt-image-1対比）

- テキスト描画精度の向上
- 非ラテン文字（日本語・中国語等）の可読性改善
- 推論機能搭載
- 複数画像の同時生成（最大8枚）
- 最大2K解像度対応

## プロンプト設計の基本構成（6要素）

```
1. 目的（What）:    UIの用途（管理画面、LP、モバイルアプリ等）
2. スタイル（Style）: デザインの雰囲気（モダン、ミニマル等）
3. レイアウト（Layout）: 画面構成（2カラム、カード型等）
4. 内容（Content）: 載せるべき情報・要素
5. トーン（Tone）:  色・印象（ブランドカラー、明暗等）
6. 出力仕様（Output）: サイズ・言語・ライト/ダークモード
```

## 5つのテンプレート

### 1. SaaSダッシュボード
データ可視化や管理画面向け。グラフ・KPI・テーブルを組み合わせたレイアウト。

### 2. ランディングページ（LP）
サービス紹介・集客用。ヒーローセクション・CTA・特徴説明。

### 3. モバイルアプリUI
スマートフォン画面設計向け。iPhone/Android標準UIパターンに準拠。

### 4. ロゴデザイン
サービスロゴ・アイコン作成用。ブランドカラーとアイコン方向性を指定。

### 5. 提案資料スライド
プレゼンテーション資料作成用。スライド1枚単位での生成。

## 精度向上のコツ

- 参考画像を添付する
- HEXコードで色を具体的に指定する
- フォントの方向性を明示する（例：「Notosansライク」）
- 余白・レイアウトを具体化する
- NG要素を明確に指定する

## 注意事項

生成画像は**完成品ではなく検討用の叩き台**として位置づける。最終成果物にはデザイナーによる仕上げが必要。ブランドガイドラインへの準拠とプロンプトの属人化回避も重要。

## 関連ページ

- [[wiki/chatgpt-images-2]] — ChatGPT画像生成機能（gpt-image-2ベース）
- [[wiki/google-stitch]] — デザイン仕様からUI生成するGoogleツール
