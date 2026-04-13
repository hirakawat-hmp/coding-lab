---
tags:
  - entity
sources:
  - "[[raw/2026-04-06-claude-code-hooks-impl]]"
created: 2026-04-06
updated: 2026-04-06
---

# RTK（Rust Token Killer）

Claude Code のトークン消費を 60-90% 削減する CLI プロキシツール。Rust 製。

## 概要

開発者向けの CLI コマンド（git, npm, docker 等）の出力をフィルタリング・圧縮し、LLM が消費するトークン数を大幅に削減する。Claude Code の [[wiki/claude-code-hooks]] を使ってコマンドを透過的にリライトすることで、ユーザーの意識なしにトークン節約を実現する。

## 動作原理

1. Claude Code の PreToolUse (Bash) フックが発火
2. `rtk-rewrite.sh` がコマンドを `rtk rewrite` に渡す
3. RTK のレジストリ (`src/discover/registry.rs`) がリライトルールを評価
4. リライト結果と権限判定を返す
5. フックが `updatedInput` でコマンドを書き換え

例: `git status` → `rtk git status`（出力が圧縮される）

## フックの終了コードプロトコル

| 終了コード | 意味 | フックの動作 |
|-----------|------|-------------|
| 0 | リライト成功、deny/ask ルール非該当 | auto-allow + updatedInput |
| 1 | RTK 対象外 | パススルー（何もしない） |
| 2 | deny ルール該当 | パススルー（Claude Code の deny に委譲） |
| 3 | ask ルール該当 | updatedInput のみ（確認ダイアログ表示） |

## メタコマンド

RTK 自体の操作は直接実行する（フック経由ではない）:

```bash
rtk gain              # トークン節約の統計
rtk gain --history    # コマンド使用履歴と節約量
rtk discover          # Claude Code 履歴から未活用の機会を分析
rtk proxy <cmd>       # フィルタなしで raw 実行（デバッグ用）
```

## 要件

- rtk >= 0.23.0（`rtk rewrite` コマンドが追加されたバージョン）
- jq（JSON パースに必要）

## 注意事項

- `rtk` という名前は Rust Type Kit (reachingforthejack/rtk) と衝突する可能性がある
- `rtk gain` が失敗する場合は `which rtk` で正しいバイナリか確認
- リライトロジックの Single Source of Truth は Rust のレジストリ。シェルスクリプトはただの委譲

## 関連ページ

- [[wiki/claude-code-hooks]] — フックシステム概要
- [[wiki/claude-code-hooks-patterns]] — RTK リライトを含む実装パターン
- [[wiki/dev-environment-architecture]] — 開発環境における RTK の位置づけ
