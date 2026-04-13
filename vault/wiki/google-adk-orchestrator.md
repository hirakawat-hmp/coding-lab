---
type: concept
status: []
tags:
  - framework/adk
  - ai/agent
  - dev/python
  - infra/gcp
  - project/aaas-ai-planner
sources:
  - "adk-orchestrator.md"
created: 2026-04-06
updated: 2026-04-06
---

# Google ADK マルチエージェントオーケストレーション

Mastra (TypeScript) の Planner Agent を Google ADK (Python) で再実装する設計。ADK v1.27.1 + A2A SDK で複数の専門エージェントをオーケストレーションする。

## コア技術

### RemoteA2aAgent

ADK ネイティブの A2A クライアント（v1.6.1+）。`sub_agents=[]` に直接登録するだけで proxy-agent コードと A2A クライアントコードが全て不要になる。Cloud Run IAM 認証は `a2a_client_factory` に `httpx.Auth` を渡して対応する。

### Session 管理: PostgreSQL

`DatabaseSessionService` で `postgresql+asyncpg://` 接続。JSONB を自動使用し、テーブルは sessions, events, app_states, user_states。State スコープは `app:key`, `user:key`, `temp:key`, または無指定でセッションスコープ。

### GoogleSearchTool

`GoogleSearchTool(bypass_multi_tools_limit=True)` で他ツールと共存可能。内部で Search 専用 sub-agent を自動生成し AgentTool としてラップする。ただし追加の LLM コールが発生するためコスト増に注意。

### Artifact 管理

名前付き・バージョン管理のバイナリデータ。GCS 本番推奨（`GcsArtifactService`）。PostgreSQL 実装は存在しないため、URL メタデータ Artifact パターン（GCS URL + custom_metadata をテキスト保存）を採用。`custom_metadata` でタグ付け可能だがフィルタリング API はなく全件取得してクライアント側でフィルタする。

## 移行後アーキテクチャ

```
Next.js -> reverse proxy -> orchestrator-agent (ADK, port 8780)
  Tools: GoogleSearchTool, McpToolset(RAG), load_artifacts_tool
  Sub-Agents: RemoteA2aAgent x 4 (tdasim, scvnorm, querida, chart)
  Cloud Run サイドカー構成
```

## 実装フェーズ

1. 最小構成 + ローカル動作確認
2. A2A サブエージェント統合
3. MCP + Session + Artifact
4. Next.js バインド + Cloud Run デプロイ

## 注意事項

- `asyncpg` + PostgreSQL のタイムゾーン付き datetime バグ（issue #4366）
- `RemoteA2aAgent` は Experimental マーク
- `bypass_multi_tools_limit` は追加 LLM コール発生（コスト増）

## 関連ページ

- [[wiki/chart-mcp-server-comparison]] -- chart サブエージェントの MCP 移行検討
- [[wiki/pptx-analysis-pipeline]] -- FastAPI サーバー側の PPTX 解析機能
