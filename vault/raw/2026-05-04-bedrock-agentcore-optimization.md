# Bedrock AgentCore Optimization: 本番エージェントのプロンプトをデータドリブン改善 (2026-05-04)

Source: https://qiita.com/leomarokun/items/1ae7df3747a45abbfb84
Published: 2026-05-03

Key points:
- AWS Bedrock AgentCore Optimization（2026年4月30日公開プレビュー）
- 3つの構成要素:
  1. Configuration bundles: システムプロンプト・Model ID・ツール説明をコードとは独立してバージョン管理
  2. Recommendations: 本番トレースと評価指標から最適化案をAIが自動生成
  3. A/B testing: Gateway経由でトラフィック分割し統計的検証
- 統計的有意差判定: p値（p < 0.05で有意）と信頼区間を使用
- 実例: Treatment（0.915）がControl（0.830）を上回るも統計的有意差なし
- AgentCore CLIでエージェント作成・デプロイ → Configuration bundle作成 → Recommendations → Online Evaluation → A/B test
