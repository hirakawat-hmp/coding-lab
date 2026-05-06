# AIエージェントに認証情報を安全に渡したい：1Passwordで試して、用途で使い分けに着地した話

Source: https://blog.takuros.net/entry/2026/05/05/151623
Retrieved: 2026-05-06
OGP Image: https://cdn-ak.f.st-hatena.com/images/fotolife/d/dkfj/20260505/20260505130034.png

## Summary

AIエージェント（Claude Code等）にAWS認証情報やAPIキーを安全に渡すための4段階セキュリティモデルを検討した実践記録。1Passwordで試した結果、用途によって使い分けることに。

## 4段階セキュリティモデル

- **Level ① (最高リスク):** AI が `.env` ファイルを直接読む
- **Level ② (低セキュリティ):** ホスト上のプレーンテキスト `.env`
- **Level ③ (中程度):** 1Password + `op run` による環境変数注入
- **Level ④ (最高セキュリティ):** IAMロール/Bedrock — AIはシークレットに触れない

## 1Password が適する場面

- 人間が起動時に立ち会えてTouch ID認証できる
- 静的・長期的なAPIキー（短期トークンでない）
- 数分以内に完了するタスク（週次Google Analytics取込等）
- アクセス自体が監査可能なセキュリティチェックポイントになる

## 1Password の限界

- 無人バッチジョブ（実行時に誰もいないためTouch ID不可）
- AWSのSTSトークンなど短命クレデンシャル
- 長時間の自律実行

## 推奨方向性

Level ④（AWSIAMロール、クレデンシャルプロバイダーチェーン、Bedrock統合）— AIプロセスに認証情報を渡す必要がなくなる。
