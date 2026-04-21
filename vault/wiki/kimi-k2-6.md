---
type: entity
status: []
tags:
  - ai/llm
  - ai/agent
sources:
  - "https://www.kimi.com/blog/kimi-k2-6"
created: 2026-04-21
updated: 2026-04-21
---

# Kimi K2.6

![Kimi K2.6](https://kimi-file.moonshot.cn/prod-chat-kimi/kfs/4/2/2026-04-20/1d7j305qav1fc641b5670?x-tos-process=image%2Fauto-orient%2C1%2Fstrip%2Fignore-error%2C1)

Moonshot AI（月之暗面）が2026年4月20日に発表したオープンソースのコーディング・エージェント特化モデル。SOTA レベルの長期タスク実行能力と **Agent Swarm** スケーリングを備える。

## 主要スペック

| 項目 | Kimi K2.5 | Kimi K2.6 |
|------|-----------|-----------|
| Agent Swarm サブエージェント数 | 100 | **300** |
| 協調ステップ数 | 1,500 | **4,000** |

## 実証済みのタスク

- **Zig での LLM 推論最適化**: Qwen3.5-0.8B の推論を ~15 → ~193 tokens/sec に改善（12.9倍）
- **金融エンジン再設計**: exchange-core を自律的に全面改修し、中間スループット **185%増**・パフォーマンス **133%増**
- 長期タスク: Rust, Go, Python を横断した安定したコード生成

## アクセス

- Kimi.com（チャット）
- Kimi App
- API
- **Kimi Code**（コーディング向け専用ツール）

## 関連ページ

- [[wiki/openai-agents-sdk-v2]] — OpenAI Agents SDK（競合エージェントフレームワーク）
- [[wiki/cursor-3]] — Cursor 3.0 マルチエージェント対応コードエディタ（コーディングエージェント競合）
- [[wiki/claude-code-desktop-parallel]] — Claude Code の並列エージェント（競合アプローチ）
