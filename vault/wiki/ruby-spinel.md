---
type: entity
status: []
tags:
  - dev/ruby
  - industry/tech
sources:
  - "https://zenn.dev/geeknees/articles/edc3cb36ea251c"
created: 2026-04-27
updated: 2026-04-27
---

# Ruby Spinel

RubyKaigi 2026 で Matz（まつもとゆきひろ）が発表した Ruby の AOT（Ahead-of-Time）コンパイラ。Prism で AST を生成し、C コードを経由してネイティブバイナリを出力する。

## 処理フロー

```
Ruby ソースコード
  → Prism/libprism（パース）
  → AST テキスト
  → spinel_codegen（型推論 + C コード生成、Ruby で実装）
  → C コンパイラ
  → ネイティブバイナリ
```

## 特徴

- **自己ホスト**: Spinel 自体も Spinel でコンパイル可能
- **計算集約的処理でのスピードアップ**: CRuby と比較して大幅な高速化
- **小規模ツール向け**: CLI ツール配布・CI ヘルパー・AI エージェント向けツールに適している

## 制限事項（未対応機能）

Ruby の動的機能は現時点で未対応:

| 機能 | 理由 |
|------|------|
| `eval` | 実行時コード生成が静的型推論と相性が悪い |
| `send` | メソッド名が実行時に決まるため |
| 動的メタプログラミング | 全般的に型推論困難 |
| `Thread` | マルチスレッドの AOT 対応は複雑 |

## TypeScript 7.0 との類似性

TypeScript コンパイラを Go で再実装した TypeScript 7.0 と同じ「既存言語を高速言語で再実装」トレンドの一例。ただし Spinel は全 Ruby コードを対象にするのではなく「型推論しやすい部分だけを対象」とするアプローチが異なる。

## 開発背景

Matz が AI（生成 AI）を活用して数週間で実装を進めた。「強い設計者が生成 AI を道具として使うと低レイヤーソフトウェアの探索速度が上がる」ことを実証した事例として注目されている。

## 関連ページ

- [[wiki/typescript-7-beta]] — TypeScript コンパイラの Go 言語移植（同様のトレンド）
- [[wiki/rust-for-cpython]] — Python の Rust 統合計画
