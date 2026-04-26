---
type: troubleshooting
status: [resolved]
tags:
  - tool/claude-code
  - ai/llm
  - industry/tech
sources:
  - "https://qiita.com/nogataka/items/2807583298a82714ae43"
created: 2026-04-26
updated: 2026-04-26
---

# Claude Code Tokenocalypse（v2.1.88以降のトークン爆発事件）

2026年3月末〜4月上旬にかけて発生した Claude Code のトークン消費急増問題。通常の3〜50倍のトークンを消費する現象が世界中で報告され、「いつも通り使っていたのに請求が10倍」という事態が相次いだ。

## 原因（複合要因）

### 1. GPU供給逼迫とインフラコスト上昇
推論向けGPU単価の上昇により、Anthropic が内部トークン計測の精緻化を実施。

### 2. Third-party harness対策
SuperClaudeやClineなどの外部ハーネスに対する検出・抑制機能が強化され、正規ユーザーのプランナー動作も重くなった。

### 3. Mythos Preview機能
長文脈向け新機能で中間推論が追加。「品質向上の代わりにトークン消費増」という課金構造の変化が生じた。

## FinOps防衛策（4本柱）

| 柱 | 内容 | 効果 |
|---|---|---|
| **npm版固定** | `@anthropic-ai/claude-code` のバージョンをpackage.jsonで固定 | ロールバック可能性を確保 |
| **2試行ルール** | 同じ課題で2回失敗したらセッション中止・計画立直し | 無限ループ防止 |
| **モデルルーティング** | Haiku 4.5をレビュー役、Sonnetを設計用に使い分け | 全体消費を2〜3割削減 |
| **セッション分割** | 「1セッション1トピック」で30〜60分単位に限定 | 文脈運搬コスト低減 |

## 見える化施策

- PR単位でのトークン消費コメント
- 月次レポート（総量・プロジェクト別・モデル別比率）

## 重要な教訓

> LLMを内包したツールでは **マイナーバージョン更新で料金構造が変動する可能性がある**。semver的な振る舞いを期待できない。

## 関連ページ

- [[wiki/anthropic-claude-code-postmortem-2026-04]] — Anthropicが公式発表した品質低下インシデント
- [[wiki/claude-codex-planner-executor]] — Claude Codeのコスト効率的な使い方
- [[wiki/rtk]] — トークン消費を削減するRust製プロキシ
