---
type: concept
status: []
tags:
  - security/web
  - industry/tech
sources:
  - "https://zenn.dev/kimifan/articles/pqc-kuwashii"
created: 2026-04-23
updated: 2026-04-23
---

# Go 1.24 TLS × 耐量子暗号（PQC）

Go 1.24（2025年2月）でTLSのデフォルト設定に**耐量子暗号（Post-Quantum Cryptography: PQC）**が組み込まれた。気づかないうちにPQCで通信しているGoアプリが世界中で稼働している。

## 背景：なぜ今PQC か

「**Harvest Now, Decrypt Later**（今傍受して後で復号）」攻撃への対策。  
攻撃者が今の暗号化通信を保存し、量子コンピュータ実用化後に復号する脅威に対し、**通信が将来解読されるリスクに今から備える**ことが必要。

## NISTの標準化（2024年8月）

| アルゴリズム | 用途 |
|---|---|
| **ML-KEM** | 鍵カプセル化（旧CRYSTALS-Kyber）|
| **ML-DSA** | デジタル署名（旧CRYSTALS-Dilithium）|
| **SLH-DSA** | デジタル署名（旧SPHINCS+）|

## Go 1.24での変更

- `X25519MLKEM768`（X25519 + ML-KEM-768の複合鍵交換）がデフォルト有効に
- クライアント対応状況：
  - Chrome/Firefox：2024年11月〜
  - Safari：2025年10月〜
- ハンドシェイクオーバーヘッド：約1KBの増加のみ
- 計算速度：MLWEベースは従来アルゴリズムより高速

## 実務への含意

Goでサーバーを書いている場合、**すでにPQCで通信している可能性が高い**。意図せずPQCが有効になっているケースでは、古いクライアントとの互換性問題が起きうる。ファイアウォールや IDS がPQCハンドシェイクを誤検知するリスクも注意が必要。

## 関連ページ
- [[wiki/openssl-4]] — OpenSSL 4.0.0でのPQC対応（ECH・ポスト量子暗号）
- [[wiki/quantum-128bit-symmetric]] — 量子コンピュータと128bit対称鍵の安全性分析
- [[wiki/lets-encrypt-ari]] — TLS証明書管理の課題
