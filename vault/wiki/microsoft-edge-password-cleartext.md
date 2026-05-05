---
type: insight
status: []
tags:
  - security/web
  - security/privacy
created: 2026-05-05
updated: 2026-05-05
sources:
  - "https://news.ycombinator.com/item?id=48012735"
---

# Microsoft Edge パスワード平文メモリ保存問題

Microsoft Edgeが使用中でないパスワードも含め、すべてのパスワードをメモリ内に平文（クリアテキスト）で保存していることがセキュリティ研究者によって発見された。HN上で大きな議論を呼んだ。

## 問題の内容

- Edgeはパスワードをディスク上では暗号化しているが、メモリに読み込むと復号される
- **使用していないパスワードも含め**、すべてがクリアテキストとしてRAM上に存在
- 暗号化キーはデバイス上のすべてのプロセスからアクセス可能

## これはEdge固有の問題か？

いいえ。Chrome、Firefoxでも類似の問題が存在するアーキテクチャ上の制約。ブラウザが自動入力のためにパスワードを「使える状態」にする必要があるため、どこかでクリアテキストになる。

## Microsoftの見解

「物理的なローカル攻撃やマルウェアはブラウザのスレットモデルの外」と主張。ただし認証後の自動入力機能など軽減策も提供。

## セキュリティ上の示唆

- **マルウェア感染時のリスク**: メモリをスキャンする攻撃コードがパスワードをダンプ可能
- **推奨**: ブラウザの組み込みパスワードマネージャーより、専用ツール（Bitwarden、1Password等）の利用が安全

## 関連ページ

- [[wiki/iterm2-ssh-rce]] — iTerm2 SSH Integration RCE
- [[wiki/claude-code-security-incidents]] — Claude Code セキュリティ事故7選
- [[wiki/firefox-tor-indexeddb-cve]] — Firefox/Tor プライバシーセッション識別子漏洩
