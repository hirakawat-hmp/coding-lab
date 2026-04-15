---
type: entity
status: []
tags:
  - security/web
sources:
  - "https://github.com/openssl/openssl/releases/tag/openssl-4.0.0"
created: 2026-04-15
updated: 2026-04-15
---

# OpenSSL 4.0.0

2026年4月14日にリリースされた OpenSSL のメジャーバージョン。SSLv3 のサポート削除、ポスト量子暗号の追加、Encrypted Client Hello (ECH) サポートなど多数の破壊的変更を含む。

## 主な破壊的変更

| 変更点 | 詳細 |
|--------|------|
| SSLv2/SSLv3 削除 | SSLv3 は 2015 年より deprecated |
| Engine サポート削除 | `no-engine` が常に適用 |
| ASN1_STRING が opaque 化 | X509 処理に const 修飾子追加 |
| `atexit()` 使用廃止 | libcrypto のグローバルクリーンアップ変更 |
| 非推奨関数削除 | `ERR_get_state()`, `ERR_remove_state()` 等 |
| レガシーツール削除 | `c_rehash` スクリプト, `msie-hack` オプション |
| Darwin 32bit/PPC サポート終了 | |

## 新機能

### セキュリティ強化

- **Encrypted Client Hello (ECH)** — RFC 9849 準拠。TLS ハンドシェイクの SNI 暗号化でプライバシー強化
- **ML-DSA-MU** — ポスト量子暗号アルゴリズム（NIST 標準化済み）
- **cSHAKE** — NIST SP 800-185 準拠のハッシュ関数

### プロトコル拡張

- **FFDHE in TLS 1.2** — RFC 7919 による有限体 DH 交換のネゴシエーション
- **SNMP KDF / SRTP KDF** — 鍵導出関数の追加

### 運用改善

- **Deferred FIPS self-tests** — `-defer_tests` オプションで起動時のセルフテストを遅延
- **Windows**: 静的/動的 VC ランタイムリンクの選択肢

## 移行注意点

エンジン API を使用しているアプリケーション（カスタム暗号ライブラリ等）は**プロバイダー API への移行**が必要。OpenSSL 3.x の Provider モデルへの完全移行を意味する。

## バージョン系列

- OpenSSL 3.x: LTS として引き続きサポート
- OpenSSL 4.0.0: 新機能メインライン

## 関連ページ

- [[wiki/n-day-bench]] — LLM による脆弱性発見ベンチマーク
- [[wiki/claude-mythos]] — AI を使ったサイバーセキュリティの文脈
