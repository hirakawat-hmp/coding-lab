---
type: entity
status: []
tags:
  - dev/javascript
  - industry/tech
sources:
  - "https://www.publickey1.jp/blog/26/vercelwebwtermwebassemblyweb.html"
created: 2026-04-22
updated: 2026-04-22
---

# Vercel wterm

![Vercel wterm](https://www.publickey1.jp/2026/vercel-wterm-ossrelease.png)

Vercel が 2026 年 4 月にオープンソース公開した **ブラウザ組み込み型ターミナルエミュレータ**。コアは **Zig 言語**で実装され **WebAssembly** にコンパイルされており、ネイティブに近い実行速度を実現する。

## 特徴

| 機能 | 詳細 |
|---|---|
| レンダリング | DOM ベース（テキスト選択・コピペ・ブラウザ検索対応） |
| パフォーマンス | Zig → WebAssembly でネイティブ級 |
| 互換性 | Alternate Screen Buffer（vim, less, htop 対応） |
| 接続 | WebSocket 経由のリモートシェル |
| カスタマイズ | CSS テーマ・24bit カラー・オートリサイズ |
| 組み込み | Vanilla JS / React 対応 |

## 技術スタック

- コア: **Zig** → **WebAssembly**
- DOM ベースレンダリング（Canvas 非使用）
- WebSocket による双方向通信

## 用途

- Web アプリへの組み込みターミナル（ブラウザベース IDE、クラウドシェル等）
- ターミナルの "Web first" 化の加速

## 関連ページ

- [[wiki/bun-headless-browser]] — Bun エコシステムのブラウザ統合
- [[wiki/smolvm]] — ブラウザ／サンドボックス実行環境（Rust 製）
