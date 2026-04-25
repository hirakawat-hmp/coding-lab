---
type: insight
status: []
tags:
  - security/web
  - security/privacy
sources:
  - "https://www.itmedia.co.jp/news/articles/2604/24/news126.html"
created: 2026-04-25
updated: 2026-04-25
---

# CAMPFIRE 個人情報漏洩（2026年4月）

![CAMPFIRE個人情報漏洩](https://image.itmedia.co.jp/news/articles/2604/24/d_y_f.jpg)

クラウドファンディングプラットフォーム「CAMPFIRE」の GitHub アカウントへの不正アクセスにより、最大 **22万5,846人** の個人情報が流出した。2026年4月24日に発表。

## 漏洩データの規模

| カテゴリ | 人数 |
|----------|------|
| プロジェクト実行者（連絡先情報） | 約 12万9,290 人 |
| PayPal 等決済サービスユーザー | 約 13万1,550 人 |
| 2025年3月までの登録ユーザー | 1,282 人 |
| **合計（最大）** | **22万5,846 人** |

クレジットカード番号は含まれていないが、データベースへのアクセスが確認されている。

## タイムライン

- 2026年2月：不正アクセスを検知
- 2026年3月：公表（データベースアクセスも確認）
- 2026年4月24日：詳細な被害規模を発表

## 教訓：GitHub アカウントのセキュリティ

攻撃経路が GitHub アカウントであった点は重要。以下の対策が必要：

1. **GitHub アクセストークンの最小権限化**：リポジトリへの読み書き権限を必要最小限に
2. **CI/CD シークレットの定期ローテーション**：GitHub Actions に設定したシークレットの定期見直し
3. **2FA（二要素認証）の強制**：組織内の全メンバーに強制適用

## 関連インシデント

[[wiki/bitwarden-cli-supply-chain-2026-04]] や [[wiki/vercel-2026-breach]] と同様に、2026年前半に日本でも大規模な個人情報漏洩が続いている。

## 関連ページ

- [[wiki/bitwarden-cli-supply-chain-2026-04]] — Bitwarden CLI サプライチェーン侵害
- [[wiki/vercel-2026-breach]] — Vercel 2026年セキュリティインシデント
- [[wiki/hatena-breach-2026]] — はてな 11億円資金流出（同月）
