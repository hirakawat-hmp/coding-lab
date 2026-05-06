---
type: how-to
status: [draft]
tags:
  - ai/agent
  - security/api
  - tool/claude-code
sources:
  - "https://blog.takuros.net/entry/2026/05/05/151623"
created: 2026-05-06
updated: 2026-05-06
---

# AIエージェントへの認証情報の安全な渡し方

![AI Agent Credential Management](https://cdn-ak.f.st-hatena.com/images/fotolife/d/dkfj/20260505/20260505130034.png)

Claude Code等のAIエージェントにAWS認証情報やAPIキーを安全に渡すための4段階セキュリティモデル。実践的な選択基準を提供。

## 4段階セキュリティモデル

| レベル | 方法 | リスク |
|-------|------|-------|
| ① | AIが `.env` を直接読む | 最高リスク |
| ② | ホスト上のプレーンテキスト `.env` | 低セキュリティ |
| ③ | 1Password + `op run` 環境変数注入 | 中程度 |
| ④ | IAMロール/Bedrock（シークレット不要） | 最高セキュリティ |

## Level ③（1Password）が適する場面

- 人間が起動時に立ち会いTouch ID認証できる
- 静的・長期的なAPIキー（短期トークンではない）
- 数分以内に完了するタスク
- アクセス自体が監査ポイントになる

```bash
# 1Password を使った環境変数注入
op run --env-file=.env.tpl -- claude code
```

## Level ③ の限界

- 無人バッチジョブ（Touch ID不可）
- AWS STSトークン等の短命クレデンシャル
- 長時間の自律実行

## 推奨方向性：Level ④

**AWS IAM ロール + クレデンシャルプロバイダーチェーン:**
- AIプロセスに認証情報を渡す必要がなくなる
- ロールベースで権限を最小化
- Amazon Bedrockでの統合が最適

## セキュリティの脅威モデル

AIエージェントへの認証情報渡しに伴うリスク:
1. bash履歴への露出
2. ログへの記録
3. プロンプトインジェクション攻撃

## 関連ページ

- [[wiki/nvidia-nemoclaw]] — NVIDIAのAIエージェント特権管理スタック
- [[wiki/claude-code-security-ops-5items]] — Claude Codeセキュリティ運用5項目
- [[wiki/mcp-token-optimization]] — MCPトークン消費削減パターン
