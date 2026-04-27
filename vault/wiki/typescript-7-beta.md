---
type: entity
status: []
tags:
  - dev/typescript
  - industry/tech
sources:
  - "https://devblogs.microsoft.com/typescript/announcing-typescript-7-0-beta/"
  - "https://www.publickey1.jp/blog/26/typescript_70typescriptgo10.html"
created: 2026-04-22
updated: 2026-04-27
---

# TypeScript 7.0 Beta

![TypeScript 7.0 Beta](https://devblogs.microsoft.com/typescript/wp-content/uploads/sites/11/2019/01/typescript-logo.png)

Microsoft が 2026 年 4 月 21 日に公開した TypeScript の次期メジャーバージョン。コンパイラを TypeScript（自己ホスト）から **Go** で全面書き直しし、約 **10 倍の性能向上** を達成した。

## パフォーマンス

| プロジェクト | 6.0 | 7.0 | 改善率 |
|---|---|---|---|
| VS Code（1.5M 行） | 89 s | 8.74 s | **10.2×** |
| Sentry | 133 s | 16 s | **8.3×** |
| 小〜中規模（<100K 行） | — | — | 2–5× |

並列コンパイルのための `--checkers` / `--builders` フラグを新設。

## インストール

```bash
npm install -D @typescript/native-preview@beta
npx tsgo --version
```

VS Code 拡張「TypeScript Native Preview」も公開済み。

## 主な変更点

- **新デフォルト**: `strict: true`、`module: esnext`、`types: []`
- **非推奨**: `target: es5`、`downlevelIteration`、一部の module resolution オプション
- 型チェックロジックは TypeScript 6.0 と構造的に同一（移植であり再設計ではない）

## ロードマップ

- RC: 数週間以内
- Stable: 2026 年 6 月頃

Google・Figma・Slack 等が beta テストに参加済み。

## 関連ページ

- [[wiki/rust-for-cpython]] — Python の Rust 統合計画（同様の「既存言語の高速言語再実装」トレンド）
