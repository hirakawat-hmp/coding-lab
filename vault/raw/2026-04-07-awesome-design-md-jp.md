# awesome-design-md-jp Research Notes (2026-04-07)

## Source
- Repository: https://github.com/kzhrknt/awesome-design-md-jp
- Author: kzhrknt
- License: MIT
- VoltAgent/awesome-design-md の日本語版フォーク

## 背景・動機

オリジナルの awesome-design-md は欧米フォントに最適化されており、日本語 UI では以下の問題がある:
- 和文フォントの指定がない
- line-height が欧文基準（1.4〜1.5）で日本語には狭すぎる（1.7〜2.0 が標準）
- letter-spacing/word-spacing が日本語向けでない（日本語は 0.04〜0.1em が読みやすい）
- 禁則処理（kinsoku shori）の指定がない
- 混植（和欧混合タイポグラフィ）の考慮がない

→ これらの積み重ねで日本語 UI のクオリティが出きらない

## 収録デザインシステム（9サービス）

1. Apple Japan — SF Pro JP
2. SmartHR（HR SaaS） — 游ゴシック
3. freee（Fintech SaaS） — Noto Sans JP
4. note（メディアプラットフォーム） — serif オプションあり
5. Novasell（AI Agency） — ネオングリーンテーマ
6. MUJI（リテール/ライフスタイル） — ミニマリスト、暖色系
7. Mercari（C2C マーケットプレイス） — 赤アクセント
8. STUDIO（ノーコードデザイン） — Inter + Noto Sans JP
9. WIRED.jp（テックメディア） — WiredMono 書体

## 構造

オリジナルの9セクション構造を踏襲しつつ、Typography Rules セクションを8つのサブセクションに拡張:
- フォント指定（和文→欧文→ジェネリックのフォールバックチェーン）
- サイズ/ウェイト階層
- line-height / letter-spacing 値
- 禁則処理（CJK 句読点の改行ルール）
- OpenType features（palt, kern）
- 混植ルール
- 縦書きモード

## 各エントリの構成
- DESIGN.md — デザインシステム本体
- preview.html — デザイントークンのプレビュー
- template/DESIGN.md — 新規エントリ用テンプレート

## MUJI の例
- 和欧統一階層（欧文フォント先、和文フォールバック）
- Noto Sans JP, Hiragino Kaku Gothic ProN, Meiryo
- line-height 1.6 統一（「穏やかで静かなリズム感」）
- font-feature-settings: normal（palt 不使用）
- MUJI Red #7f0019、Kinari #f4eede
