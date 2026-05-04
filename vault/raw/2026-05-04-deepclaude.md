# DeepClaude – Claude Code agent loop with DeepSeek V4 Pro (2026-05-04)

Source: https://github.com/aattaran/deepclaude
Hacker News: https://news.ycombinator.com/item?id=48002136
Published: 2026-05-03

Key points:
- Claude CodeのUIを維持しながらバックエンドをDeepSeek V4 Proに切り替え
- コスト削減：Anthropic $200/月 → deepclaude $20/月（90%削減）
- 出力トークン単価：$0.87/M（Claude Opus 4.6比で17倍安い）
- 対応モデル：DeepSeek V4 Pro、OpenRouter、Fireworks AI、Anthropic
- 完全互換：ファイル読み書き・bash実行・git操作・マルチステップエージェントループ
- リモートコントロール：ブラウザから任意デバイスでセッション操作可能
- 技術構成：PowerShell 46% / Shell 39.1% / JavaScript 14.9%
- 必要環境：Node.js 18以上（リモートコントロール使用時）
