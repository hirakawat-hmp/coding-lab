---
type: entity
status: []
tags:
  - dev/git
sources:
  - "https://gigazine.net/news/20260418-manyana/"
created: 2026-04-19
updated: 2026-04-19
---

# Manyana — CRDT ベース次世代 VCS アーキテクチャ

![Manyana VCS](https://i.gzn.jp/img/2026/04/18/manyana/00_m.png)

BitTorrent 作者の Bram Cohen が設計した実験的バージョン管理システム（VCS）アーキテクチャ。CRDT（Conflict-free Replicated Data Types）を採用し、Git のマージ・リベース問題を根本的に解決しようとする PoC（2026年4月発表）。

## 設計の動機

Git のマージ・リベースが抱える本質的な問題:
- マージ順序によって結果が変わる（非可換性）
- リベースによる破壊的な履歴改変
- コンフリクトが「失敗」として扱われる

## 主要技術

### CRDT の活用

Conflict-free Replicated Data Types を使うことで:
- **保証されたマージ**: 結果がマージ順序に依存しない
- **最終的整合性**: 全リポジトリで同一データが保証される

### DAG 構造の拡張

コミット DAG に「最重要祖先コミット」メタデータを付加:
- リベース時の履歴破壊を排除
- 行順序を決定論的に処理 → シーケンス依存コンフリクト防止

### コンフリクトの再定義

コンフリクト = 失敗イベント → **情報提供イベント**

「何がどこで変わったか」を構造化情報として可視化する。

## 現状

- 約470行の Python デモ実装
- 最小限のファイルレベル操作のみ対応
- PoC レベル — 実用的なツールではない

## 比較対象

| VCS | 特徴 |
|-----|------|
| Git | 現在の標準。マージ競合は手動解決 |
| [[wiki/jujutsu-jj]] | Git ベース、UX 改善に注力 |
| Manyana | CRDT でマージ問題を根本解決（実験段階） |

## 関連ページ

- [[wiki/jujutsu-jj]] — 同じく次世代 VCS を目指す Jujutsu (jj)
