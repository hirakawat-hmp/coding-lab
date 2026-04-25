---
type: entity
status: []
tags:
  - tool/claude-code
  - ai/eval
sources:
  - "https://github.com/delta-hq/cc-canary"
created: 2026-04-25
updated: 2026-04-25
---

# CC-Canary

Claude Code のセッションログを解析してパフォーマンスリグレッション（品質劣化）を早期検出するドリフト検出ツール。delta-hq が開発した Claude Code 向け Agent Skill。

## インストール・使い方

```bash
npx skills add delta-hq/cc-canary
/cc-canary 60d      # Markdown レポート生成（GitHub Issue 向け）
/cc-canary-html 60d # HTML ダッシュボード生成（ブラウザで自動表示）
```

## 追跡メトリクス

| 指標 | 説明 |
|------|------|
| read:edit 比率 | コード読み取り対編集のバランス |
| 推論ループ数 | ターンあたりの思考サイクル数 |
| Thinking 削減率 | thinking トークンの変化 |
| ターンあたりトークン | 消費量の変化 |
| フラストレーション指標 | 再試行・エラーリカバリーの頻度 |

## 判定クラス

- **HOLDING**：問題なし
- **SUSPECTED REGRESSION**：疑わしい兆候
- **CONFIRMED REGRESSION**：リグレッション確認
- **INCONCLUSIVE**：データ不足

時間窓は 7d〜180d（デフォルト 60 日）で設定可能。

## プライバシー設計

完全ローカル動作・ネットワーク通信なし。`~/.claude/projects/` のセッションログのみを読み取り、ユーザープロンプトは 180 文字でトランケートされる。

## 背景

[[wiki/anthropic-claude-code-postmortem-2026-04]] が示すように、Claude Code は 2026年初頭に複数回の品質低下問題を経験した。CC-Canary はそのようなリグレッションをユーザー自身が客観的に検証できるツールとして設計された。

## 関連ページ

- [[wiki/anthropic-claude-code-postmortem-2026-04]] — Claude Code 品質低下のポストモーテム
- [[wiki/claude-code-usage-dashboard]] — Claude Code 利用状況可視化ダッシュボード
- [[wiki/rtk]] — Claude Code トークン消費削減ツール
