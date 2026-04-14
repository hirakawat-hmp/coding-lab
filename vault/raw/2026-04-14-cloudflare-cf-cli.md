# Cloudflare統合CLI「cf」— Raw Source

Source: https://blog.cloudflare.com/cf-cli-local-explorer/
Fetched: 2026-04-14
Feed: Hacker News (Top)

## 概要

Cloudflareは新しい統合CLI「cf」の技術プレビュー版をリリース。「nearly 3,000 HTTP API operations」に対応する、プラットフォーム全体向けのコマンドラインツール。

## 主要機能

**CLI機能:**
- Cloudflareの全製品向けコマンドを提供
- インフラストラクチャ・アズ・コードで統合設定が可能
- エージェント（AI）と人間の双方に対応した設計

**Local Explorer:**
ローカル開発環境で、KV、R2、D1、Durable Objects、Workflowsなどのリソースを検査・管理できる新機能。「what you can do remotely, you can now do locally」という実装方針。

## アーキテクチャ

従来のOpenAPIスキーマの制限を超えるため、TypeScriptベースの新しいスキーマシステムを開発した。このアプローチにより：

- CLI、Workers Bindings、設定ファイルを自動生成
- 複数インターフェースの一貫性を確保
- 急速な製品開発に対応

## エージェント対応の設計

コマンドの一貫性を重視し、`--json`や`--force`など標準化されたフラグを全体で統一。ローカル/リモートリソースの区別を明確にし、エージェントの混乱を防いでいる。

試用は `npx cf` で可能。
