# Matz の Ruby AOT コンパイラ Spinel を試してみました

source: https://zenn.dev/geeknees/articles/edc3cb36ea251c
fetched: 2026-04-27

## 概要

RubyKaigi 2026 で発表された Matz による Ruby の AOT（事前コンパイル）コンパイラ。

## 処理フロー

Ruby ソースコード → Prism でparse → AST → C コード生成 → C compiler → ネイティブバイナリ

## 特徴

- Prism/libprism でパースし AST テキストに変換
- spinel_codegen（Ruby で実装）が型推論と C コード生成を担当
- 自己ホスト（compiler 自体も Spinel でコンパイル可能）
- 計算集約的な処理で CRuby 比較で大きなスピードアップ

## 制限事項

「eval」「send」「動的メタプログラミング」「Thread」などは未対応。型推論しやすい Ruby 部分に限定。

## 適用可能な用途

- CLI ツール配布
- CI ヘルパー
- AI コーディングエージェント向けの小規模ツール

## 開発背景

Matz が AI を活用し、数週間で実装。強い設計者が生成 AI を活用することで低レイヤーソフトウェアの探索速度が向上することを示唆。
