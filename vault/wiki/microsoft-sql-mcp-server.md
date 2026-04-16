---
type: entity
status: []
tags:
  - ai/agent
  - data/analytics
  - infra/aws
sources:
  - "https://www.publickey1.jp/blog/26/postgresqlmysqlsql_serversql_mcp_server.html"
  - "https://github.com/microsoft/data-api-builder"
created: 2026-04-16
updated: 2026-04-16
---

# Microsoft SQL MCP Server

![SQL MCP Server](https://www.publickey1.jp/2026/sqlmcpserver-la01.png)

Microsoft が 2026年4月15日にオープンソースで公開した SQL MCP Server。AI エージェントが複数のデータベースを横断的にクエリできる統一インターフェースを提供する。

## 概要

Data API builder for Azure Databases の一部として MCP（Model Context Protocol）実装を追加。AI エージェントが PostgreSQL・MySQL・SQL Server などを単一接続で操作可能になった。

## 対応データベース

| DB | 種類 |
|---|---|
| PostgreSQL | オープンソース |
| MySQL | オープンソース |
| Microsoft SQL Server | Microsoft 製 |
| Azure SQL Database | Azure マネージド |
| Azure SQL Data Warehouse | Azure データウェアハウス |
| Azure Cosmos DB | NoSQL |

## 提供プロトコル

Data API builder は REST API・GraphQL・MCP の3プロトコルを単一設定で提供する。これにより、既存の REST/GraphQL クライアントと AI エージェント（MCP 経由）の両方から同一 DB に接続できる。

## デプロイ

完全オープンソース（MIT ライセンス）。オンプレミス・AWS・Azure など任意の環境にライセンスコストなしでデプロイ可能。

## 意義

AI エージェントによるマルチ DB アクセスの標準化を促進。MCP エコシステムの拡大に寄与。

## 関連ページ

- [[wiki/cloudflare-wrangler-ai]] — AI エージェント向け統合 CLI の Cloudflare 版
- [[wiki/mcp-mastra-integration]] — MCP で外部 API をラップしてエージェントに統合するパターン
