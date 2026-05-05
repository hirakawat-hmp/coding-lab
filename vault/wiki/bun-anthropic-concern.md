---
type: insight
status: []
tags:
  - dev/javascript
  - industry/tech
  - tool/claude-code
created: 2026-05-05
updated: 2026-05-05
sources:
  - "https://wwj.dev/posts/i-am-worried-about-bun/"
---

# Bun × Anthropic — オーナーシップ懸念

AnthropicによるBun買収（2025年12月）後、Claude Code運用での品質低下パターンを見るとBunも同様の経路を辿るのでは、という懸念を表明した記事。

## 前提：BunのAnthropicによる買収

2025年12月、AnthropicがJavaScriptランタイム「Bun」を買収。技術的には高品質なBunが、Anthropicの組織的課題の影響を受けるリスクが生まれた。

## Claude Codeから学ぶ品質劣化パターン

著者がClaude Codeで観察したAnthropicの問題点：

1. **デフォルト推論努力の低下**（コスト削減目的）
2. **セッション停滞バグ**の長期放置
3. **コーディング品質低下を招くプロンプト変更**（告知なし）
4. **課金の混乱**（未文書化ルールによるペナルティ）
5. **内部テスト（ドッグフーディング）の欠如**疑惑

## Enshittification（品質劣化）の構造

```
優れた製品を取得
    ↓
収益化のため制限を段階的に追加
    ↓
ユーザーは移行コストで動けず
    ↓
品質は徐々に劣化
```

## 著者の対応

個人プロジェクトをpnpmに移行中。ただし「他者は自分で判断すべき」と強調。

## 意義

オープンソース製品が大企業に買収された後の品質維持問題。特にAI時代に急速な成長を遂げたツール群に共通するリスク。

## 関連ページ

- [[wiki/claude-code-pro-tier-removal]] — Claude Code Pro プラン削除（告知なし）
- [[wiki/claude-code-tokenocalypse]] — Claude Code v2.1.88 Tokenocalypse事件
- [[wiki/anthropic-claude-code-postmortem-2026-04]] — Claude Code品質低下公式ポストモーテム
- [[wiki/bun-headless-browser]] — Bun v1.3.12ヘッドレスブラウザ機能
