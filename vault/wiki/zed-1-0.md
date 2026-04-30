---
type: entity
status: []
tags:
  - tool/zed
  - industry/tech
sources:
  - "https://zed.dev/blog/zed-1-0"
created: 2026-04-30
updated: 2026-04-30
---

# Zed 1.0 — AI ネイティブテキストエディタ GA

## 概要

Rust 製 AI ネイティブテキストエディタ「Zed」が2026年4月30日に v1.0 に到達。5年間・100万行超のコードを経て GA となった。macOS・Windows・Linux の3プラットフォームに対応。

## 主要機能

- 複数の並列 AI エージェント管理（Claude Agent、Codex 等と統合）
- キーストローク単位の編集予測
- Git 統合・SSH リモーティング・デバッガー
- 包括的言語エコシステムサポート
- Zed for Business: 集中課金・RBAC・チーム管理

## 技術基盤

カスタム UI フレームワーク **GPUI**（Rust + GPU シェーダー）。GPU を直接活用したパフォーマンス重視の設計。

## DeltaDB（開発中）

CRDT ベースの同期エンジン。リアルタイムの人間-AI 共同作業コードベース管理を目的とする。

## 現状

「1.0 は完成を意味しない」—リリース時点で数十万人の開発者が定期利用。

## 関連ページ

- [[wiki/zed-parallel-agents]] — Zed Parallel Agents（並列エージェント管理・Threads Sidebar）※以前の関連ページ
- [[wiki/cursor-3]] — Cursor 3.0（競合 AI コードエディタ）
- [[wiki/warp-terminal-oss]] — Warp ターミナルのオープンソース化
