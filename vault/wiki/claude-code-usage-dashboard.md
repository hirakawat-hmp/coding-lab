---
type: entity
status: []
tags:
  - tool/claude-code
  - ai/agent
sources:
  - "https://qiita.com/tamepicomaru/items/8f9b238ae28e380e6029"
  - "https://github.com/AgenticSec/ClaudeCodeUsageDashboard"
created: 2026-04-21
updated: 2026-04-21
---

# Claude Code Usage Dashboard（OSS）

AgenticSec 社の Takahiro Tamenishi が2026年4月公開したオープンソースダッシュボード。チームの Claude Code 利用状況——特にスキル・MCP サーバー・サブエージェントの採用率——を自動収集・可視化する。

## リポジトリ

https://github.com/AgenticSec/ClaudeCodeUsageDashboard

## 解決する問題

トークンコストは簡単に追跡できる。しかし「どのスキルが使われているか」「MCP サーバーの利用状況」「サブエージェントの活用度」は、個々のセッションログを調べないと見えない。このダッシュボードはその可視性の空白を埋める。

## アーキテクチャ

- **Claude Code Stop フック** と **Plugin システム** を活用
- セッションログ（`~/.claude/projects/{hash}/{session_id}.jsonl`）を自動パース
- 開発ワークフローをゼロ中断で収集

## 計測指標

| 指標 | 説明 |
|------|------|
| スキル使用頻度 | カスタムスキルの呼び出し回数 |
| MCP サーバー呼び出し | 各 MCP ツールの利用数 |
| サブエージェント活動 | サブエージェントパターンの頻度 |
| トークン消費・コスト | ユーザー/リポジトリ別 |
| モデル分布 | Opus/Sonnet/Haiku の比率 |

## 実績

ダッシュボード可視化から **1週間以内にサブエージェント利用が約 1.5倍** に増加（アクセシビリティが利用促進に直結）。

## 関連ページ

- [[wiki/claude-code-hooks]] — Claude Code Hooks（Stop フック機能の基盤）
- [[wiki/claude-code-harness-patterns]] — ハーネスパターン（Stop フック活用の上位概念）
- [[wiki/claude-code-routines]] — Claude Code Routines（自動実行との組み合わせ）
