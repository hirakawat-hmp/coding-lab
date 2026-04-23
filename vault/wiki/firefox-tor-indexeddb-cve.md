---
type: insight
status: []
tags:
  - security/web
  - security/privacy
sources:
  - "https://fingerprint.com/blog/firefox-tor-indexeddb-privacy-vulnerability/"
  - "https://cve.threatint.eu/CVE/CVE-2026-6770"
created: 2026-04-23
updated: 2026-04-23
---

# Firefox/Tor IndexedDB プライバシー脆弱性（CVE-2026-6770）

FirefoxおよびTor BrowserのIndexedDBに、**すべてのプライベートセッションを横断して同一ユーザーを特定できる安定した識別子が漏洩する**脆弱性が発見された（2026年4月22日報告）。

## 脆弱性の仕組み

IndexedDBから返されるエントリの**順序**から、プロセスライフタイム中に安定・決定論的・一意な識別子を導出できる。  
これは「異なるTorサーキットを使った別々のセッションが同一ユーザーである」ことを証明可能にし、Torが提供する匿名性の分離保証を破る。

## 影響範囲

Tor BrowserはFirefox（Gecko）ベースであるため、GeckoのIndexedDB実装を継承して影響を受ける。全てのFirefoxベースブラウザが対象。

## 修正版

| 製品 | 修正バージョン |
|------|------------|
| Firefox | **150** |
| Firefox ESR | **140.10.0** |
| Thunderbird | **150** |
| Thunderbird | **140.10** |

Mozilla Bug: 2024220

## 教訓

ブラウザのプライバシーモードや匿名化ツールは、OSやランタイムの実装に依存するため、下位レイヤーの側面チャネルによって無効化されるリスクがある。「匿名性」を前提にした設計は、常に攻撃面全体を検証する必要がある。

## 関連ページ
- [[wiki/iterm2-ssh-rce]] — iTerm2 SSH Integration RCEとターミナルの信頼性問題
- [[wiki/mcp-security-vulnerability-2026]] — MCPのシステム的脆弱性
- [[wiki/flock-lpr-privacy]] — 監視インフラとプライバシー法の問題
