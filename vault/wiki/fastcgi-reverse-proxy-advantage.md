---
type: concept
status: []
tags:
  - infra/sre
sources:
  - "https://www.agwa.name/blog/post/fastcgi_is_the_better_protocol_for_reverse_proxies"
created: 2026-04-30
updated: 2026-04-30
---

# FastCGI はリバースプロキシに HTTP より優れているという主張

## 概要

30年前のプロトコル FastCGI が、HTTP よりもリバースプロキシ用途に適しているという技術エッセイ（HN 224 ポイント）。HTTP/1.1 の根本的な設計上の欠陥を指摘し、FastCGI の構造的優位性を解説する。

## HTTP のリバースプロキシとしての問題点

### 1. メッセージフレーミングの曖昧さ

HTTP/1.1 は明示的なメッセージフレーミングを持たない。これにより:
- **デシンク攻撃（Request Smuggling）**: プロキシとバックエンドがメッセージ境界を異なる解釈
- Discord メディアプロキシ侵害等のセキュリティ事故の原因

### 2. ヘッダーインジェクション脆弱性

- `X-Real-IP` 等のヘッダーがクライアント制御かプロキシ制御か不明瞭
- ミドルウェア間のヘッダー削除ロジックの不一致を攻撃者が悪用

## FastCGI の構造的優位性

### 明確なメッセージフレーミング

30年前から「メッセージ境界の明確化」を実装済み。HTTP/2 は同様の問題を後から解決しているが、FastCGI はより広いプロキシサポートと単純な設計で同じ目標を達成。

### 信頼データの構造的分離

HTTP ヘッダーは `HTTP_` プレフィックスで識別し、プロキシ信頼情報（`REMOTE_ADDR` 等）は無プレフィックスで管理。構造上、クライアントがプロキシ信頼値を偽装できない。

## FastCGI の制限

- WebSocket 非対応
- HTTP と比べてツールの最適化・エコシステムが貧弱

## 対応プロキシ

nginx、Apache、Caddy、HAProxy がネイティブ FastCGI をサポート。

## 関連ページ

- [[wiki/lets-encrypt-ari]] — Let's Encrypt 短期証明書と ARI（プロキシ周辺の関連トピック）
