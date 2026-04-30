---
type: concept
status: []
tags:
  - ai/agent
  - ai/rag
  - data/analytics
sources:
  - "https://qiita.com/taka_yayoi/items/c0da11faeb76b3233162"
created: 2026-04-30
updated: 2026-04-30
---

# セッションを跨ぐ記憶を持つ AI エージェント設計（Lakebase × LangGraph × Qwen3）

![Lakebase AIエージェントメモリ](https://qiita-user-contents.imgix.net/https%3A%2F%2Fqiita-image-store.s3.ap-northeast-1.amazonaws.com%2F0%2F1168882%2F6e720ff3-680f-44f5-8128-7d0d29a95892.png)

## 概要

Databricks Lakebase・LangGraph・Qwen3 を組み合わせて、セッションを跨いでユーザー情報を記憶できる AI エージェントを構築するアーキテクチャ（Qiita、2026年4月29日）。

## アーキテクチャ

```
[User] → [LangGraph Agent (create_react_agent)]
         ├─ ChatDatabricks（Foundation Model API）
         ├─ ツール: get_current_datetime / save_memory / recall_memories
         ├─ PostgresSaver（Checkpointer）── 短期記憶
         └─ PostgresStore（Store）──────── 長期記憶
                                   ↓
                    [Lakebase Autoscaling]
              - checkpoints（thread_id スコープ）
              - store / store_vectors（user スコープ）
              - pgvector + Qwen3-Embedding
```

## 2層記憶構造

### 短期記憶（Checkpointer）

`PostgresSaver` でセッション内の会話状態を維持。`thread_id` スコープで管理。

### 長期記憶（Store）

`PostgresStore` + pgvector によるセマンティック検索。`Qwen3-Embedding-0.6B`（1024次元）で埋め込みを生成し、ユーザーをまたいだ知識を保持。

## 記憶ツール

| ツール | 機能 |
|--------|------|
| `save_memory(content)` | ユーザー情報を Store に永続化 |
| `recall_memories(query)` | セマンティック検索で過去の記憶を取得 |

## 活用場面

- 毎回コンテキストを再入力しないカスタマーサポートエージェント
- ユーザー設定・好みを学習して継続するパーソナルアシスタント
- プロジェクト知識を蓄積する開発補助エージェント

## 関連ページ

- [[wiki/writeback-rag]] — WriteBack-RAG（過去クエリ結果を蒸留してナレッジベース自動改善）
- [[wiki/corpus2skill-hierarchical-rag]] — Corpus2Skill（階層型 RAG の設計）
- [[wiki/snapstate]] — SnapState（AI エージェントワークフローの永続状態管理）
