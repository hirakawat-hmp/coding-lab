---
type: insight
status: []
tags:
  - tool/claude-code
  - security/web
  - ai/agent
sources:
  - "https://zenn.dev/renue/articles/4687cb5e5c0031"
created: 2026-04-26
updated: 2026-04-26
---

# renue — Claude Codeで全社員セキュリティ演習（ECサイトハッキング）

![renue Claude Codeセキュリティ演習](https://static.zenn.studio/user-upload/92c11005bf03-20260424.png)

株式会社renueが2026年4月10日の「renue SUMMIT」で実施した、全社員参加型のAIエージェントを活用したセキュリティ演習。Claude Codeを使って意図的に脆弱性を組み込んだ架空ECサイトを攻撃した。

## 演習の設計

### 対象システム
顧客情報・注文・法人契約などを含む実在システムに近い構造の架空ECサイトに **14種の脆弱性を意図的に組み込み**。

### 脆弱性の構成
- OWASP Top 10 カテゴリ
- クラウド設定ミス
- ログ改ざん

### 評価軸
「脆弱性発見数」ではなく **「最も価値の高い損失を生み出したチーム」** を勝者とすることで、複数の脆弱性を連鎖させた攻撃戦略の立案を促した。

## 達成された効果

- 参加者が権限昇格から情報流出までの攻撃チェーンを体験
- 仮説立案→検証→結果解釈のサイクルを習得
- 技術知識と事業インパクト理解の統合

## 洞察

Claude Codeは脆弱性の仮説生成・コード解析・攻撃ペイロード作成を支援するツールとして機能した。非エンジニア社員でも攻撃思考を体験できる教育効果がある一方、**攻撃ツールとしての悪用リスク**を適切なスコープ設定で制御することが重要。

今後は防御側の演習設計も検討し、攻撃・防御両側からのアプローチでAI前提の業務設計を推進する計画。

## 関連ページ

- [[wiki/n-day-bench]] — LLMのサイバー脆弱性発見能力ベンチマーク
- [[wiki/claude-code-enterprise-adoption-2026]] — Claude Code企業導入動向
- [[wiki/bitwarden-cli-supply-chain-2026-04]] — セキュリティ関連の実際のインシデント
