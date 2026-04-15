# Raw: OpenDuck — Distributed DuckDB Instance

Source: https://github.com/citguru/openduck
Fetched: 2026-04-15

HN discussion: https://news.ycombinator.com/item?id=47769796 (157 pts, 32 comments)

## What OpenDuck Is

Open-source implementation of concepts from MotherDuck. Enables distributed querying across DuckDB instances with "differential storage, hybrid (dual) execution, and transparent remote databases."

## Key Architecture

**Differential Storage**: Append-only layers with PostgreSQL metadata; immutable sealed layers in object storage with snapshot-based consistency.

**Hybrid Execution**: Single queries execute across local AND remote machines. Gateway splits execution plans into LOCAL/REMOTE, with bridge operators managing data transfer.

**DuckDB-Native Integration**: Implements DuckDB's StorageExtension and Catalog interfaces. Remote tables are first-class catalog entries.

## Protocol

Minimal open protocol: two gRPC RPCs in `execution.proto` for query execution and Arrow IPC result streaming. Any gRPC service returning Arrow data can serve as a compatible backend.

## Usage

```sql
ATTACH 'openduck:mydb'
-- Then query remote tables as first-class objects
```

Works with DuckLake for lakehouse catalog management.

GitHub: https://github.com/citguru/openduck
