# Microsoft Edge stores all passwords in memory in clear text, even when unused

Source: https://news.ycombinator.com/item?id=48012735
Fetched: 2026-05-05

## 問題の概要

セキュリティ研究者が、Microsoft Edgeがパスワードをメモリ内に平文（クリアテキスト）で保存していることを発見。使用中でないパスワードも含まれる。

## 技術的背景

- ブラウザはパスワードをディスク上で暗号化するが、暗号化キーはデバイス上のすべてのプロセスからアクセス可能
- 「Vault」に暗号化されていても、ブラウザのメモリ空間に読み込まれると復号される
- これはChromeやFirefoxでも類似の問題が存在するアーキテクチャ上の課題

## Microsoftの見解

「物理的なローカル攻撃やマルウェアはブラウザのスレットモデルの外」と主張。
一方で認証後の自動入力機能など軽減策も提供。

## HN上の反応

- ブラウザの設計上避けがたい問題との見方
- 専用パスワードマネージャー（Bitwarden、1Password等）の使用を推奨する意見多数
