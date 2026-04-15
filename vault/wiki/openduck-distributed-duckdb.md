---
type: entity
status: []
tags:
  - data/analytics
sources:
  - "https://github.com/citguru/openduck"
created: 2026-04-15
updated: 2026-04-15
---

# OpenDuck — 分散 DuckDB

MotherDuck が実現した分散クエリの概念をオープンソースで再実装したプロジェクト。単一クエリをローカル・リモートの DuckDB インスタンスに分散実行する「ハイブリッド実行」を提供する。

## 概要

- **リポジトリ**: https://github.com/citguru/openduck
- **ベースとなる概念**: MotherDuck のアーキテクチャ
- **ライセンス**: オープンソース

## アーキテクチャ

### ハイブリッド実行

1 つのクエリが**ローカルマシン**と**リモートサーバー**にまたがって実行される:

```sql
-- ユーザーは普通の SQL を書くだけ
SELECT * FROM local_table JOIN remote_table ON ...

-- OpenDuck が内部でプランを分割:
-- LOCAL: local_table のスキャン
-- REMOTE: remote_table のスキャン
-- BRIDGE: 結果のマージ
```

### 差分ストレージ（Differential Storage）

- **追記専用レイヤー**: PostgreSQL メタデータ
- **不変シールドレイヤー**: オブジェクトストレージ（S3 互換）に保存
- **スナップショット整合性**: 任意の時点の状態を再現可能

### DuckDB ネイティブ統合

- `StorageExtension` と `Catalog` インターフェースを実装
- リモートテーブルがローカルテーブルと同じ第一級オブジェクト
- JOIN・最適化に透明に参加

## オープンプロトコル

ベンダーロックインを避けるため、意図的にシンプルなプロトコル:

```protobuf
// execution.proto の2つの RPC のみ
service ExecutionService {
  rpc Execute(QueryRequest) returns (stream QueryResult);
  rpc GetSchema(SchemaRequest) returns (SchemaResponse);
}
// 結果は Apache Arrow IPC 形式
```

任意の gRPC サービスで互換バックエンドを実装可能。

## 使い方

```sql
-- リモート DB を attach
ATTACH 'openduck:mydb';

-- 透明なクエリ実行
SELECT * FROM mydb.remote_table;
```

## MotherDuck との違い

| 項目 | MotherDuck | OpenDuck |
|------|-----------|---------|
| ライセンス | プロプライエタリ | オープンソース |
| 拡張性 | 限定 | 任意のバックエンドと互換 |
| セルフホスト | 不可 | 可能 |

## DuckLake との統合

OpenDuck は DuckLake（Iceberg/Delta 互換のレイクハウスカタログ）と組み合わせることでより強力なデータレイクソリューションを構築できる。

HN: 157 pts, 32 comments（2026-04-14）

## 関連ページ

- [[wiki/belief-propagation]] — クエリ最適化の確率的基盤
