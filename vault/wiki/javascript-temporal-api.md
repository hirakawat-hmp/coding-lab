---
type: entity
status: []
tags:
  - dev/javascript
sources:
  - "https://gigazine.net/news/20260429-fix-time-in-javascript/"
created: 2026-04-30
updated: 2026-04-30
---

# JavaScript Temporal API — 9年かけて Date を置き換える新日時 API

![JavaScript Temporal API](https://i.gzn.jp/img/2026/04/29/fix-time-in-javascript/00_m.jpg)

## 概要

JavaScript の `Date` オブジェクトを置き換える新しい日時 API。1995年に10日間で実装された `Date` の根本的な問題を解決するため、TC39 に2017年に提案され、約9年の開発期間を経て標準化が進んでいる。

## Date オブジェクトの3つの問題

### 1. 可変性（Mutability）

`Date` オブジェクトは関数引数として渡すと内部が変更されてしまう。予期しない副作用の原因。

### 2. 解析曖昧性（Parsing Ambiguity）

日付文字列の解釈がブラウザ・実行環境間で異なる。同じコードが環境によって異なる結果を返す。

### 3. タイムゾーン・カレンダーの制限

グレゴリオ暦以外（和暦・イスラム暦等）への対応が貧弱。国際化に根本的な制約がある。

## Temporal の特徴

| 特徴 | 説明 |
|------|------|
| イミュータブル | オブジェクトが変更されない設計 |
| 複数型 | `PlainDate`・`PlainTime`・`ZonedDateTime` 等、ユースケース別の型 |
| タイムゾーン | IANA タイムゾーンデータベースを完全サポート |
| カレンダー | 複数カレンダーシステムのファーストクラスサポート |

## 開発タイムライン

- **2017年**: TC39 へ提案
- 主要貢献: Microsoft、Bloomberg、Igalia、Google
- Test262（ECMAScript テストスイート）に **4,500件** のテストケース（他の組み込み機能を大幅に超える）
- **2026年現在**: Stage 3（標準化間近）

## 関連ページ

- [[wiki/typescript-7-beta]] — TypeScript 7.0 Beta（Go 製コンパイラ・JS/TS エコシステム）
- [[wiki/bun-headless-browser]] — Bun v1.3.12（JavaScript ランタイムの最新動向）
