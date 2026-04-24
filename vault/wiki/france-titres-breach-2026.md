---
type: insight
status: []
tags:
  - security/web
  - security/privacy
  - policy/regulation
sources:
  - "https://www.bleepingcomputer.com/news/security/french-govt-agency-confirms-breach-as-hacker-offers-to-sell-data/"
created: 2026-04-24
updated: 2026-04-24
---

# フランス France Titres データ漏洩（2026年4月）

![France Titres 侵害](https://www.bleepstatic.com/content/hl-images/2026/04/21/Titres.jpg)

フランスの公式身分証明書発行機関 **France Titres**（ANTS: Agence Nationale des Titres Sécurisés）がサイバー攻撃によるデータ漏洩を公式確認した事件（2026-04-15 発見）。

## 機関の概要

- **正式名称**: France Titres（旧称 ANTS）
- **所管**: フランス内務省
- **管理対象**: 運転免許証、国家身分証、パスポート、入国書類

フランス国民の重要書類のほぼ全てを管理する中枢機関。

## 漏洩詳細

| 項目 | 内容 |
|------|------|
| 発見日 | 2026-04-15 |
| 漏洩データ種別 | ログイン ID、フルネーム、メールアドレス、生年月日、住所、出生地、電話番号 |
| 影響人数 | 未公開 |
| ハッカーの主張 | 最大 **1,900 万件**のレコードを盗んだと「breach3d」が主張し売却申し出 |

## 機関の対応と評価

ANTS の声明: 「露出情報は電子ポータルへの不正アクセスには使用できない」

しかし実際のリスクは**フィッシングと社会工学的攻撃**にあり、生年月日・住所・電話番号の組み合わせは成りすましに十分な情報。

## 関与した機関

- **CNIL**（Commission Nationale de l'Informatique et des Libertés）— データ保護当局
- **パリ検察局**
- **ANSSI**（国家サイバーセキュリティ機関）

## 教訓

政府機関のデータ漏洩は「使えない」と言っても、二次・三次利用（フィッシング、SIM スワッピング、社会工学攻撃）のリスクが残る。1,900 万件という規模はフランスの成人人口（約 5,500 万人）の約 35% に相当する可能性がある。

## 関連ページ

- [[wiki/nist-cve-enrichment-end]] — NIST が CVE エンリッチメントを断念（政府機関セキュリティ体制の課題）
- [[wiki/mcp-security-vulnerability-2026]] — MCP のシステム的脆弱性（2026年4月）
- [[wiki/google-ice-data-surveillance]] — Google が ICE へデータ提供した件
