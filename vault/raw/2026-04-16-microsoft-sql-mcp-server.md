# マイクロソフト、PostgreSQL/MySQL/SQL Server への同時接続に対応した「SQL MCP Server」オープンソースで公開

**Source:** https://www.publickey1.jp/blog/26/postgresqlmysqlsql_serversql_mcp_server.html  
**Date:** 2026-04-15  
**Retrieved:** 2026-04-16

## 記事概要

Microsoft が SQL MCP Server をオープンソースで公開。AI エージェントが複数データベースを横断クエリできる統一インターフェースを提供。

## 主要ポイント

- Data API builder for Azure Databases の一部として MCP 実装を追加
- 対応 DB: PostgreSQL, MySQL, Microsoft SQL Server, Azure SQL Database, Azure SQL Data Warehouse, Azure Cosmos DB
- REST API・GraphQL・MCP の3プロトコルを統一インターフェースで提供
- 完全オープンソース、オンプレミス・AWS・Azure など任意の環境にデプロイ可能
- ライセンスコスト不要

## 技術的詳細

Data API builder は以前から REST/GraphQL アクセスを提供していたが、今回 MCP 実装を追加することで AI エージェントからの利用が容易になった。
単一の設定で複数 DB に横断アクセス可能な統合エンドポイントを実現。

## 出典

- Publickey 2026-04-15
- GitHub: microsoft/data-api-builder（MIT License）
