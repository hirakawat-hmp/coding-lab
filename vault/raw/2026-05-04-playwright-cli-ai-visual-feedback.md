# Playwright CLI で AI エージェントに視覚的なフィードバックを与える (2026-05-04)

Source: https://azukiazusa.dev/blog/playwright-cli-ai-agent-visual-feedback/
Published: 2026-05-03

OGP Image: https://images.ctfassets.net/in6v9lxmm5c8/ud2v4jmPh9FBFLlJiG3oi/504d81605de7050f0b0a3ea40bd8048b/bird_uguisu_11328-768x640.png

Key points:
- Playwright CLI v0.1.9のアノテーション機能でAIエージェントに視覚的フィードバックを提供
- ブラウザ要素を選択してコメントを残すことができ、AIがアノテーションされた要素を特定可能
- インストール: `npm install -g @playwright/cli`
- スキル追加: `playwright-cli install --skills`
- UI確認: `playwright-cli show --annotate` コマンドでダッシュボード表示
- フロー: 要素選択→コメント追加→AIがコメントに基づいてコード改善
- 注意: すべての視覚的フィードバックが自動化できるわけではなく、人間による操作も重要
