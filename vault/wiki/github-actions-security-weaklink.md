---
type: insight
status: []
tags:
  - security/supply-chain
  - infra/ci-cd
  - dev/git
sources:
  - "https://nesbitt.io/2026/04/28/github-actions-is-the-weakest-link.html"
created: 2026-04-29
updated: 2026-04-29
---

# GitHub Actions はセキュリティの最も弱いリンク

Andrew Nesbitt による調査（2026年4月28日）。GitHub Actions のデフォルト設定と設計上の特性が、オープンソースパッケージへの多数のサプライチェーン攻撃を可能にしているという分析。

## 5つの構造的脆弱性

### 1. `pull_request_target` トリガー
フォークからの PR を処理する際に **リポジトリシークレット + write-scoped トークン**で実行される。「PR を自動ラベリングするために存在する」トリガーが攻撃起点に悪用される。

### 2. ミュータブルなアクション参照
バージョンタグ（例: `@v3`）でアクションを参照すると、メンテナーによるタグ書き換えで悪意あるコードが注入される。コミット SHA でのピン留めが唯一の防御。

### 3. キャッシュポイズニング
GitHub Actions のキャッシュが信頼境界を越えており、悪意ある PR がキャッシュエントリを汚染 → 正当なワークフローが毒入りキャッシュを利用。

### 4. デフォルトの write-scoped トークン
2023年2月以前に作成されたリポジトリでは `GITHUB_TOKEN` が書き込み権限でデフォルト付与されており、非認証トリガーによる危険なアクセスが可能。

### 5. テンプレートインジェクション
シェルスクリプト内でクォートなし変数展開を使うと、PR タイトルやコメント経由で任意コマンドが実行される。

## 主要インシデント（2024年11月〜2026年4月）

| プロジェクト | 手口 |
|---|---|
| Ultralytics | タグハイジャック経由マルウェア配布 |
| tj-actions | アクション改ざんによるシークレット漏洩 |
| nx | キャッシュポイズニング |
| Trivy | サプライチェーン経由バックドア |
| elementary-data | PR_TARGET 悪用 |
| axios | 依存関係改ざん |
| Bitwarden | OIDC トークン窃取（→ [[wiki/bitwarden-cli-supply-chain-2026-04]]） |
| Vercel | サプライチェーン侵害（→ [[wiki/vercel-2026-breach]]） |

## 防御策

1. **zizmor** セキュリティリンターを CI に追加
2. 全アクションを**コミット SHA でピン**（タグ参照禁止）
3. 明示的な最小権限 `permissions:` ブロック
4. PR メタデータ（タイトル・コメント）を**悪意ある入力として扱う**
5. `pull_request_target` の使用を避け、`pull_request` を優先

## 関連ページ

- [[wiki/bitwarden-cli-supply-chain-2026-04]] — GitHub Actions 経由の Bitwarden 侵害詳細
- [[wiki/vercel-2026-breach]] — Vercel サプライチェーン侵害
- [[wiki/wordpress-plugin-supply-chain-attack]] — WordPress プラグインのサプライチェーン攻撃
- [[wiki/aws-supply-chain-monitor]] — AWS でのサプライチェーン攻撃検知システム
- [[wiki/ghostty-leaving-github]] — GitHub への信頼性問題（別側面）
