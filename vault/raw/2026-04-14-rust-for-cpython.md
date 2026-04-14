# Rust for CPython — Python 3.16 計画

source: https://atmarkit.itmedia.co.jp/ait/articles/2604/14/news017.html
related: https://github.com/rust-for-cpython
fetched: 2026-04-14

## 概要

CPython（Pythonの参照実装）にRustを統合する取り組み。
2025年11月にEmma Smithによって「Pre-PEP: Rust for CPython」が提案され、
正式なPEP（Python Enhancement Proposal）の策定が目指されている。

## 導入の理由

- メモリ安全性: バッファオーバーフロー問題の削減
- スレッド安全性: 複数スレッドへのアクセス管理が自動化
- パフォーマンス向上: 標準データ構造の効率化

現在、base64モジュールをRustで再実装する概念実証が進行中。

## Python 3.16 へのロードマップ

- 4月: Rust API設計の開始、最初のモジュール実装
- 5月: API設計の確定、PyCon USでの発表
- 6月: PEP審査開始
- 7月: PEPドラフト完成、討議開始

## 技術的背景

CPython のC実装に Rust を段階的に導入する戦略。
まず標準ライブラリの一部モジュール（base64等）をRust再実装し、
将来的にはコア部分への適用も視野に入れる。
