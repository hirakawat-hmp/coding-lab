---
type: entity
status: [draft]
tags:
  - infra/cloudflare
  - dev/typescript
sources:
  - "https://blog.cloudflare.com/cf-cli-local-explorer/"
created: 2026-04-14
updated: 2026-04-14
---

# Cloudflare統合CLI「cf」

Cloudflareが開発した統合CLIツール。技術プレビュー段階で、プラットフォーム全体の約3,000 HTTP API操作に対応する。`npx cf`で試用可能。

## 概要

従来Cloudflareはサービスごとに異なるCLIや設定方法を提供していた。新しい`cf`は、全Cloudflare製品を一つのCLIから操作できる統合インターフェース。

## 主要機能

### Local Explorer（新機能）

ローカル開発環境でCloudflareのリソースをリモートと同じAPIで操作できる。

対応リソース：
- KV（キーバリューストア）
- R2（オブジェクトストレージ）
- D1（SQLiteベースのDB）
- Durable Objects
- Workflows

「what you can do remotely, you can now do locally」の原則で設計。

### エージェント対応設計

AIエージェントが混乱しないよう、一貫性のある設計を採用：
- `--json`フラグ：全コマンドで機械可読なJSON出力
- `--force`フラグ：全コマンドで確認プロンプトをスキップ
- ローカル/リモートの区別を明確化

## アーキテクチャ

従来のOpenAPIスキーマの制限を超えるため、**TypeScriptベースの独自スキーマシステム**を開発。このスキーマから以下を自動生成：
- CLIコマンド
- Workers Bindings
- 設定ファイル（`wrangler.toml`等）

複数インターフェースの一貫性を単一のソースから保証している。

## 使用方法

```bash
npx cf                    # インタラクティブモード
npx cf kv list            # KVストア一覧
npx cf r2 ls              # R2バケット一覧（ローカル）
npx cf d1 query mydb      # D1クエリ実行
```

## 関連ページ

- [[wiki/aws-frontier-agents]] — AWS側のエージェント対応CLIアーキテクチャ
- [[wiki/claude-code-action-tools]] — Claude Code ActionのツールとCLI設計
