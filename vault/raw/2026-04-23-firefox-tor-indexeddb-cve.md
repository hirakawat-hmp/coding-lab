# Firefox/Tor IndexedDB プライバシー脆弱性 CVE-2026-6770

Source: https://fingerprint.com/blog/firefox-tor-indexeddb-privacy-vulnerability/
Fetched: 2026-04-23

## 要点（WebSearchより）

CVE-2026-6770（Mozilla Bug 2024220）

- IndexedDB から返されるエントリの順序から、プロセスライフタイムで安定・決定論的・一意な識別子を導出できる
- プライバシー保護が期待されるコンテキストでも匿名性の分離保証を破る
- Tor Browser はFirefox（Gecko）ベースのため影響を受ける
- 全てのFirefoxベースブラウザが影響対象

## 修正版
- Firefox 150
- Firefox ESR 140.10.0
- Thunderbird 150
- Thunderbird 140.10

Sources:
- https://fingerprint.com/blog/firefox-tor-indexeddb-privacy-vulnerability/
- https://cve.threatint.eu/CVE/CVE-2026-6770
