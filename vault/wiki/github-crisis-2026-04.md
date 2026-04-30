---
type: insight
status: []
tags:
  - infra/ci-cd
  - security/supply-chain
  - industry/tech
sources:
  - "https://qiita.com/crowdy/items/c3e06c47b350ef230352"
created: 2026-04-30
updated: 2026-04-30
---

# GitHub の6日間の危機（2026年4月23〜29日）

## 概要

2026年4月23日〜29日の6日間、GitHub でガバナンス・稼働率・セキュリティ・コストの問題が同時多発した。Hacker News トップ5の4件が GitHub 関連記事に占められる事態となった。

## タイムライン

### 4月23日

Merge Queue のスカッシュマージ機能が **不正コミットを生成**。658リポジトリ・2,092 PR に影響。

### 4月27日

- Elasticsearch ベースの GitHub Search がボットネット攻撃疑いで障害
- Copilot Code Review が **2026年6月1日から GitHub Actions 分を消費**（二重課金問題）

### 4月28日

- Wiz が **CVE-2026-3854**（CVSS 8.7・Critical）を開示（GitHub.com + Enterprise Server）→ [[wiki/github-rce-cve-2026-3854]]
- GitHub Enterprise Server の **88% がパッチ未適用**
- Mitchell Hashimoto が「Ghostty is leaving GitHub」を公開 → [[wiki/ghostty-leaving-github]]
- Hacker News に複数の批判的記事が同時上位

### 4月29日

Hacker News トップ5の4件が GitHub 関連コンテンツ

## 構造的な問題

| 領域 | 問題の本質 |
|------|-----------|
| ガバナンス | 2025年以降 CEO 実質空席、Microsoft CoreAI への統合で意思決定が不明確 |
| インフラ | AI エージェント駆動ワークフローで「30倍の容量拡張が必要」 |
| セキュリティ | GitHub Actions のデフォルト設定が RCE 脆弱性を許容、PyPI の 91% がミュータブルタグ参照 |
| サプライチェーン | tj-actions・nx/s1ngularity 等の連鎖インシデントが下流に波及 |

## 教訓

単一プラットフォームへの依存集中のリスクが露わになった。Ghostty の GitHub 離脱は「氷山の一角」であり、重大サービスプロバイダとしての GitHub への過信を見直す契機となっている。

## 関連ページ

- [[wiki/github-rce-cve-2026-3854]] — CVE-2026-3854 詳細
- [[wiki/ghostty-leaving-github]] — Ghostty が GitHub を離れる決断
- [[wiki/github-actions-security-weaklink]] — GitHub Actions の5つの構造的脆弱性
- [[wiki/github-copilot-usage-billing]] — GitHub Copilot 利用量ベース課金（2026年6月移行）
