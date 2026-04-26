---
type: insight
status: []
tags:
  - tool/claude-code
  - ai/agent
  - ai/llm
sources:
  - "https://qiita.com/nogataka/items/2668b9ca9d12f0bef1e5"
created: 2026-04-26
updated: 2026-04-26
---

# Claude Code = planner、Codex CLI = executor

3ヶ月の実運用から見えた Claude Code と Codex CLI の最適役割分担。「どちらか一方を選ぶという前提そのものが古い」という洞察のもと、両ツールを組み合わせるモデルを提唱。

## 各ツールの性格

### Claude Code（計画型 / planner）
- 1M tokens の長文脈対応で大規模リポジトリ全体を把握
- Agent Teams とフックイベント26種類で「思考過程への介入」が可能
- 「広く考える」設計 — 設計・判断・リファクタに向く

### Codex CLI（実行型 / executor）
- Rust実装でカーネルレベルサンドボックス搭載
- トークン消費が Claude の **1/4〜1/2** 程度（Express.js実測）
- 「決まった手順を壊さず回す」効率性 — 単純実装・反復作業に向く

## 実測データ（Express.js 大規模リファクタ、約1,200行差分）

| 指標 | Claude Code | Codex CLI |
|------|------------|-----------|
| トークン消費 | 約6.2M | 約1.5M |
| 実行時間 | 1時間17分 | 1時間41分 |

小規模バグ修正ではCodexが優位（約180K vs 42K）。

## 推奨ワークフロー

```
Claude Code → plan.md 作成（設計・計画）
     ↓
Codex CLI → 実装（plan.mdに従って実行）
     ↓
レビュー: Codex（静的解析）→ Claude（設計観点）
```

## コスト構造（月額$40）

- Claude Code: 約62%
- Codex CLI: 約28%
- CI環境: 約10%

## キーメッセージ

> **「Codex for keystrokes, Claude Code for commits」**

細かな実装作業はCodex、設計判断を伴う変更はClaude Codeに分担させることで、質とコスト効率の両立が可能。

## 関連ページ

- [[wiki/ai-parallel-worktree]] — Claude・Codex・Geminiの並列開発
- [[wiki/claude-code-tokenocalypse]] — Claude Codeのトークン爆発問題
- [[wiki/claude-code-enterprise-adoption-2026]] — Claude Code企業導入動向
