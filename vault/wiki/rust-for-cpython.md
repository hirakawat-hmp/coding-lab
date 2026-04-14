---
type: concept
status: []
tags:
  - dev/python
  - dev/rust
sources:
  - "https://atmarkit.itmedia.co.jp/ait/articles/2604/14/news017.html"
  - "https://github.com/rust-for-cpython"
created: 2026-04-14
updated: 2026-04-14
---

# Rust for CPython — Python 3.16 への Rust 統合計画

## 概要

CPython（Python の参照実装）に Rust を段階的に統合するイニシアティブ。
2025年11月に Emma Smith によって「Pre-PEP: Rust for CPython」が提案され、
2026年4月時点で PEP（Python Enhancement Proposal）の正式策定が進行中。

## 動機

| 課題 | Rust 導入による解決 |
|---|---|
| メモリ安全性 | バッファオーバーフロー問題を型システムレベルで排除 |
| スレッド安全性 | 所有権モデルにより複数スレッドのアクセス管理を自動化 |
| パフォーマンス | 標準データ構造をゼロコスト抽象化で効率化 |

## ロードマップ（2026年）

| 月 | マイルストーン |
|---|---|
| 4月 | Rust API 設計の開始、最初のモジュール（base64）実装 |
| 5月 | API 設計の確定、PyCon US での発表 |
| 6月 | PEP 審査開始 |
| 7月 | PEP ドラフト完成、討議開始 |

## 実装戦略

**段階的置き換え**: まず標準ライブラリの個別モジュールを Rust で再実装し、
C API の互換性を保ちながら内部をすげ替える手法。

**先例**: CPython はすでに一部を C 以外（Python 自体も）で実装しているため、
Rust モジュールの追加は原理的に障壁が低い。

**PoC**: `base64` モジュールを Rust で再実装する概念実証が進行中。

## 意義

Python 言語自体のメモリ安全性改善に向けた「言語のアーキテクチャ変更」であり、
単なるパフォーマンス改善を超えた長期的な安全性投資。

Mozilla が Firefox に Rust を導入した流れ（Servo プロジェクト）と同様のアプローチ。

## 関連ページ

- [[wiki/bitnet-cpp]] — Rust 製の高効率推論エンジン（Rust の AI 領域での活用事例）
