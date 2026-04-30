# Raw: Lakebase × LangGraph × Qwen3で作る、セッションを跨ぐ記憶を持つAIエージェント

Source: https://qiita.com/taka_yayoi/items/c0da11faeb76b3233162
Thumbnail: https://qiita-user-contents.imgix.net/https%3A%2F%2Fqiita-image-store.s3.ap-northeast-1.amazonaws.com%2F0%2F1168882%2F6e720ff3-680f-44f5-8128-7d0d29a95892.png
Fetched: 2026-04-30

## Architecture

```
[User] → [LangGraph Agent (create_react_agent)]
         ├─ ChatDatabricks (Foundation Model API)
         ├─ Tools: get_current_datetime, save_memory, recall_memories
         ├─ PostgresSaver (Checkpointer) → 短期記憶（スレッドスコープ）
         └─ PostgresStore (Store) → 長期記憶（ユーザースコープ）
                           ↓
              [Lakebase Autoscaling]
         - checkpoints (thread_id スコープ)
         - store/store_vectors (user スコープ)
         - pgvector + Qwen3-Embedding
```

## 記憶ツール

- `save_memory(content)`: ユーザー情報を Store に保存
- `recall_memories(query)`: Qwen3-Embedding-0.6B（1024次元）でセマンティック検索

## Key Design

- 短期記憶（Checkpointer）: PostgresSaver でセッション内の会話状態を維持
- 長期記憶（Store）: PostgresStore + pgvector でセッションを跨いで知識を保持
