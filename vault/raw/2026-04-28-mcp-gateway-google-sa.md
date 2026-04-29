# AIに会社のGoogleアカウントを渡していませんか

- Source: https://zenn.dev/finatext/articles/mcp-gateway-google-sa
- Published: 2026-04-28
- Author: techan (Nowcast LLM Engineer)

## Summary

AIエージェントにユーザートークンを直接渡すと、意図しない情報（1on1メモ等）へのアクセスが発生するリスクがある。

**解決策:** ユーザーごとに専用サービスアカウント（SA）を発行。
- ユーザーがGoogle共有設定でAI専用アカウントに明示的にアクセス許可
- 2層SA構造：管理用SA（発行者）+ 個人用SA（実行者）
- トークン生成はInterceptor層のみ（AWS Lambda + Google Cloud Workload Identity Federation）
- 短命トークン・SAキーファイル保存ゼロ

**メリット:** 監査ログでAIと人間の行動を区別可能、コスト効率（SAは無料）
