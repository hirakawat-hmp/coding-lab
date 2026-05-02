---
type: insight
status: []
tags:
  - security/incident
  - security/api
  - dev/git
  - security/supply-chain
sources:
  - "https://zenn.dev/awesome_kou/articles/moneyforward-github-source-leak"
  - "https://corp.moneyforward.com/news/info/20260501-mf-press-1/"
created: 2026-05-02
updated: 2026-05-02
---

# マネーフォワードGitHub不正アクセス事件（2026年5月）

2026年5月1日、フィンテック大手マネーフォワードがGitHubへの不正アクセスを公表した。認証情報の漏えいによりソースコードと一部個人情報が流出した可能性がある大型インシデント。

## 被害の実態

- ビジネスカード保持者 **370件**の名前と下4桁が流出
- GitHub リポジトリのソースコードが第三者にコピーされた可能性
- ソースコード内に**本番認証キー・パスワード**が含まれていた
- 本番データベースの直接流出は確認されていない

## 問題の本質：設計と運用の双方に欠陥

エンジニア視点で見ると、今回の事件は単なる「運用ミス」ではなく構造的な問題を露呈している。

### ①本番データのテストコードへの混入
本番カード情報をテストデータとして使用する慣行は、開発現場で珍しくない。「本番から持ってきたいエンジニアの気持ちを否定するのではなく、持ってきても大丈夫な状態に変換する経路を提供する」ことが設計上の解答になる。

### ②シークレット管理の未整備
- AWS Secrets Manager / HashiCorp Vault 等の導入不足
- Personal Access Token のハードコードが横行
- Git 履歴に残った過去の秘匿情報

### ③認証情報漏えいの主要経路
1. **開発者 PC のマルウェア感染**（Stealer 型）
2. 公開リポジトリへの誤コミット
3. サードパーティ連携の侵害
4. フィッシング攻撃

## 推奨対策

| レイヤー | 手段 |
|----------|------|
| 事前検知 | gitleaks（pre-commit/CI）+ TruffleHog（履歴スイープ） |
| GitHub 機能 | Secret Scanning + Push Protection の有効化 |
| 履歴クリーン | git-filter-repo / BFG Repo-Cleaner |
| 認証管理 | GitHub App/OIDC への移行・PAT 廃止 |
| テストデータ | Faker 等での合成化・仮名化・マスキング |

## 初動評価

公式発表の初動対応自体は「教科書通り」だった。ただし第二報での透明性開示（「何が漏れたのか」の明示）が重要で、以降の信頼回復にかかわる。

## 関連ページ

- [[wiki/campfire-breach-2026]] — CAMPFIRE 個人情報漏洩（GitHub 不正アクセス、同様のパターン）
- [[wiki/github-crisis-2026-04]] — GitHub の6日間の危機（2026年4月）
- [[wiki/github-actions-security-weaklink]] — GitHub Actions の構造的脆弱性
- [[wiki/bitwarden-cli-supply-chain-2026-04]] — Bitwarden CLI サプライチェーン侵害
- [[wiki/envguard]] — AI ツールへの秘密鍵漏洩を事前チェック
