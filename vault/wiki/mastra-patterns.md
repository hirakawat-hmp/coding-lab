---
type: concept
status: []
tags:
  - framework/mastra
  - ai/agent
  - dev/typescript
  - project/aaas-ai-planner
sources:
  - "/Users/hdymacuser/Desktop/prompt-management-system/.serena/memories/mastra_patterns.md"
created: 2026-04-06
updated: 2026-04-06
---

# Mastra フレームワークパターン

Mastra は TypeScript ベースの AI エージェントフレームワーク。Agent / Tool / Workflow / Memory の4つの主要概念で構成される。

## Agent パターン

`@mastra/core/agent` から `Agent` クラスをインポートし、宣言的に定義する。

```typescript
import { Agent } from '@mastra/core/agent';

export const myAgent = new Agent({
  name: 'Agent Name',
  instructions: `エージェントの振る舞いと出力フォーマットの指示`,
  model: 'google/gemini-2.5-pro',
  tools: { toolName1, toolName2 },
  memory: new Memory({ storage: new LibSQLStore({ url: 'file:../mastra.db' }) }),
});
```

### instructions のベストプラクティス

- エージェントの役割と能力を具体的に記述
- 入力の期待値と出力フォーマットを明記
- エッジケースのハンドリング指針を含める
- 利用可能ツールと使用条件を列挙

## Tool パターン

ツールはエージェントが呼び出せる単機能の関数。name / description / parameters (Zod スキーマ) / execute で構成される。

- 単一責任に保つ
- description はエージェントがいつ使うか判断できるよう明確に
- Zod スキーマでパラメータバリデーション
- 構造化データを返し、エージェントが解釈しやすくする

## Workflow パターン

複数ステップのオーケストレーション。Agent 呼び出しと Tool 実行をチェーンできる。

## Mastra インスタンス設定

`src/mastra/index.ts` で一元管理する。

```typescript
export const mastra = new Mastra({
  workflows: { workflow1 },
  agents: { agent1 },
  storage: new LibSQLStore({ url: ':memory:' }),
  logger: new PinoLogger({ name: 'Mastra', level: 'info' }),
  observability: { default: { enabled: true } },
});
```

## Memory / Storage

| オプション | URL | 用途 |
|-----------|-----|------|
| In-Memory | `:memory:` | 開発・テスト。再起動で消失 |
| File-Based | `file:../mastra.db` | 永続化。パスは `.mastra/output` 相対 |

Agent Memory は会話コンテキスト維持、Storage は Observability データやスコア永続化に使い分ける。

## Next.js 統合パターン

### API Route パターン（推奨）

```typescript
// src/app/api/agent/route.ts
export async function POST(request: Request) {
  const { message } = await request.json();
  const result = await mastra.agents.myAgent.generate(message);
  return Response.json(result);
}
```

### Server Action パターン

```typescript
'use server'
export async function callAgent(message: string) {
  return await mastra.agents.myAgent.generate(message);
}
```

## 共通パターン

- Agent/Tool 呼び出しは必ず try-catch でラップ
- TypeScript の型安全性を活用（入出力に interface 定義）
- Pino による構造化ログで Agent の振る舞いをデバッグ
- Observability でツール呼び出し・判断をトレース

## 関連ページ

- [[wiki/mcp-mastra-integration]] -- MCP Server と Mastra Agent の統合パターン
- [[wiki/tdd-parallel-workflow]] -- Mastra を使った TDD 並列開発ワークフロー
