---
type: insight
status: []
tags:
  - dev/git
  - infra/ci-cd
  - industry/tech
sources:
  - "https://mitchellh.com/writing/ghostty-leaving-github"
created: 2026-04-29
updated: 2026-04-29
---

# Ghostty が GitHub を離れる：信頼性問題の臨界点

Mitchell Hashimoto（Vagrant 作者・Terraform 共同創業者）が2026年4月28日、ターミナルエミュレータ「Ghostty」を GitHub から移行すると発表した。GitHub ユーザー #1299（2008年2月〜）として 18 年以上にわたり使い続けてきた人物による決断として注目される。

## 移行理由

**継続的な信頼性の欠如。** Hashimoto は個人的な障害日誌を記録しており、「ほぼ毎日 X（障害）がある」状態が続いていると報告。問題の中心は Git そのものではなく、GitHub のインフラ（Issues・PR・Actions）。

## 移行の詳細

- GitHub.com には**読み取り専用ミラー**を現在の URL で維持
- 移行先は非公開（商用・FOSS 両プロバイダーと協議中）
- 移行はグラジュアルに実施
- 個人プロジェクトは GitHub に残す

## 示唆するもの

### GitHub への依存リスクの顕在化

Ghostty 移行は、GitHub が事実上の独占ポジションに慣れることで信頼性投資が不十分になるリスクを示す。開発者ツールの CI/CD は単一プラットフォームへの依存が高く、障害の業務影響が大きい。

### 代替エコシステムの成熟

Forgejo・Gitea・GitLab 等の代替プラットフォームが技術的に成熟し、真剣な検討対象になっている。同じ週に「Carrot Disclosure: Forgejo」（セキュリティ上の良品質事例として）も HN でトレンド入り。

### Hashimoto の感情的葛藤

ブログには「批判が過激だったかもしれない」という自省も含まれており、単なる批判ではなく深い関係性からの決断であることが伝わる。

## 関連ページ

- [[wiki/github-rce-cve-2026-3854]] — GitHub のセキュリティ脆弱性（信頼性問題の別側面）
- [[wiki/github-actions-security-weaklink]] — GitHub Actions のセキュリティ問題
- [[wiki/warp-terminal-oss]] — Warp の OSS 化（開発者ツール再編動向）
- [[wiki/jujutsu-jj]] — Git 代替 VCS（エコシステム変化）
