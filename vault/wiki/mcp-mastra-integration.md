---
tags:
  - concept
sources:
  - "/Users/hdymacuser/Desktop/main/abk-project/abk-agent/.serena/memories/system_architecture.md"
created: 2026-04-06
updated: 2026-04-06
---

# MCP Server + Mastra AI 統合パターン

外部 API を MCP プロトコルでラップし、Mastra AI エージェントから利用するアーキテクチャパターン。

## 全体アーキテクチャ

```
Claude Desktop <--MCP(stdio)--> MCP Server <--HTTP--> 外部 API
                                     ^
                                     |
Web UI (Next.js) <--> Mastra Agent --+
```

3つの接続パターンを持つ:

1. **標準 MCP 接続**: Claude Desktop -- stdio -- MCP Server -- HTTP -- 外部 API
2. **HTTP MCP 接続**: Claude Desktop -- HTTP Client -- HTTP Server -- 外部 API（複数クライアント対応）
3. **統合環境 (Docker)**: Web UI -- Mastra Agent -- MCP HTTP Server -- 外部 API（本番対応）

## MCP Server 設計

外部 API を MCP プロトコルでラップするサーバー。

**技術構成**: TypeScript + Express.js + MCP SDK (`@modelcontextprotocol/sdk`)

### ツール実装パターン

BaseTool 抽象クラスを継承し、各ツールを実装する:

```typescript
export class YourTool extends BaseTool<InputType, OutputType> {
  name = "tool_name";
  description = "ツールの説明";
  protected schema = z.object({ /* Zod バリデーション */ });

  async handler(args: InputType): Promise<OutputType> {
    // 外部 API 呼び出し
  }
}
```

### デュアル接続対応

同一コードベースで stdio（Claude Desktop 用）と HTTP（Web UI / 複数クライアント用）の両方をサポートする。

## Mastra Agent 設計

MCP ツールを統合した AI エージェント。

**技術構成**: Next.js 15 + React 18 + Mastra Core + Google AI SDK

### 主要機能

- チャット形式の Web UI
- MCP ツール統合（HTTP 経由で MCP Server のツールを呼び出し）
- AI による分析・提案の自動生成

### データフロー

```
1. ユーザー入力（チャット）
2. Mastra Agent が意図理解
3. 適切な MCP ツール選択・実行
4. Google AI で結果分析
5. 最適化提案生成
6. Web UI に結果表示
```

## Docker Compose 統合

```yaml
services:
  mcp-http-server:    # port 3002
  mastra-agent:       # port 3003
  # 外部 API は別途（外部サービス or ローカル）
```

## セキュリティ

- API キーは環境変数管理
- 入力値検証に Zod を使用
- 機密情報のログ出力禁止
- CORS 設定

## スケーラビリティ

- HTTP MCP Server の水平スケーリング
- Load Balancer での分散
- API レスポンスキャッシュ
- Connection Keep-Alive

## 監視

- `/health` エンドポイントによるヘルスチェック
- Docker Health Check
- 構造化ログ（JSON）

## 関連ページ

- [[wiki/mastra-patterns]] -- Mastra フレームワークの Agent/Tool/Workflow パターン
- [[wiki/rag-mcp-sidecar]] -- MCP サーバーをサイドカーとして配置するパターン
- [[wiki/cloud-run-fastapi-deploy]] -- Cloud Run デプロイの汎用パターン
