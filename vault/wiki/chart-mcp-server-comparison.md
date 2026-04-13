---
type: comparison
status: []
tags:
  - ui/visualization
  - ai/agent
sources:
  - "chart-mcp-comparison.md"
created: 2026-04-06
updated: 2026-04-06
---

# Chart MCP サーバー比較

既存の chart-agent（ADK + Vega-Lite + GCS, Cloud Run port 8770, 7チャート種類）を MCP サーバーに置き換える検討。2026-03-15 時点の調査結果。

## 候補一覧

| MCP サーバー | Stars | チャート数 | ライブラリ | 特徴 |
|---|---|---|---|---|
| @antv/mcp-server-chart | 3,813 | 28+ | AntV | 最多機能、活発開発 |
| mcp-echarts (hustcc) | 214 | 15+ | ECharts | SVG/PNG、MinIO 連携 |
| mcp-vegalite-server | 96 | 全 VL | Vega-Lite | 現行と同じ VL、Python |
| @ax-crew/chartjs-mcp | 15 | 8 | Chart.js v4 | シンプル、JSON 出力 |

## MCP 移行の Pros

- インフラ簡素化（Cloud Run + GCS 不要）
- チャート種類の増加
- 出力形式の多様化
- Mastra MCP 統合が容易

## MCP 移行の Cons

- GCS 画像永続化の喪失
- Observability の低下
- レンダリング品質差異
- ローカルサーバー管理の負担

## 推奨

| シナリオ | 推奨 |
|----------|------|
| 最小変更 | mcp-vegalite-server（現行 Vega-Lite と同一ライブラリ） |
| 最大機能 | @antv/mcp-server-chart（28+ チャート、活発開発） |
| 画像永続化必須 | 現行維持、または MCP + GCS ラッパー追加 |

## 関連ページ

- [[wiki/google-adk-orchestrator]] -- chart-agent を含むマルチエージェント構成の設計
