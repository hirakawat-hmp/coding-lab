---
type: entity
status: []
tags:
  - design/system
  - dev/markdown
sources:
  - "[[raw/2026-04-07-awesome-design-md-jp.md]]"
created: 2026-04-07
updated: 2026-04-07
---

# awesome-design-md-jp

[[wiki/awesome-design-md]] の日本語版。kzhrknt が作成。日本語タイポグラフィに最適化された [[wiki/design-md|DESIGN.md]] ファイルを収集している。

- **GitHub**: https://github.com/kzhrknt/awesome-design-md-jp
- **収録数**: 9 サービス（+ テンプレート）

## なぜ必要か

オリジナルの DESIGN.md は欧米フォントに最適化されており、日本語 UI では品質が出きらない:

| 項目 | 欧文基準 | 日本語基準 |
|------|---------|-----------|
| フォント | Latin のみ | 和文→欧文→ジェネリックのフォールバックチェーン |
| line-height | 1.4〜1.5 | 1.7〜2.0 |
| letter-spacing | 0 or minimal | 0.04〜0.1em |
| 禁則処理 | 不要 | CJK 句読点の改行ルール必須 |
| OpenType | 基本的 | `palt`, `kern` で混植を調整 |
| 混植 | 不要 | 和欧フォントの組み合わせルール |

## 収録デザインシステム

| サービス | カテゴリ | 特徴的なフォント |
|----------|---------|-----------------|
| Apple Japan | Consumer Tech | SF Pro JP |
| SmartHR | HR SaaS | 游ゴシック |
| freee | Fintech SaaS | Noto Sans JP |
| note | メディア | serif オプションあり |
| Novasell | AI Agency | ネオングリーンテーマ |
| MUJI | リテール | ミニマリスト、Noto Sans JP |
| Mercari | C2C | 赤アクセント |
| STUDIO | ノーコード | Inter + Noto Sans JP |
| WIRED.jp | テックメディア | WiredMono |

## 構造の違い

Google Stitch 標準の9セクションを踏襲しつつ、**Typography Rules を8サブセクションに拡張**:
フォント指定、サイズ/ウェイト階層、line-height/letter-spacing、禁則処理、OpenType features、混植ルール、縦書きモード

## 関連

- [[wiki/design-md]] — DESIGN.md の概念
- [[wiki/awesome-design-md]] — オリジナル（欧米版、58サイト）
