---
type: entity
status: []
tags:
  - design/system
  - ai/agent
  - dev/typescript
sources:
  - "https://github.com/google-labs-code/design.md"
created: 2026-04-22
updated: 2026-04-22
---

# Google Labs design.md

Google Labs が 2026 年 4 月 21 日に公開した、**コーディングエージェントがデザインシステムを理解・実装するための OSS フォーマット仕様**（v0.1.0、alpha）。

## コンセプト

YAML フロントマター（マシンリーダブルなデザイントークン）と Markdown 本文（デザインの背景・意図）を組み合わせたハイブリッド形式。エージェントが「正確な値」と「その理由」の両方を取得できる。

```yaml
---
colors:
  primary: "#1A73E8"
  background: "#FFFFFF"
typography:
  body: { family: "Google Sans", size: "16px" }
---

## Colors

Primary blue is used for CTAs only — not decorative elements...
```

## CLI ツール

| コマンド | 機能 |
|---|---|
| `lint` | 参照切れ・コントラスト比・孤立トークンのチェック（7 ルール） |
| `diff` | バージョン間のトークン差分 |
| `export` | Tailwind / DTCG（W3C 標準）形式への変換 |
| `spec` | 仕様テキストの出力 |

## 現状

- GitHub: 627 stars / 42 forks（公開直後）
- TypeScript 94.2%、alpha ステータス
- W3C Design Token Format（DTCG）と互換

## 類似・関連概念との対比

既存の [[wiki/design-md]] コンセプトはデザインシステムを LLM に渡す手法を一般論として説明するが、google-labs-code/design.md はその**具体的な実装仕様＋CLIツール**を提供するもの。

## 関連ページ

- [[wiki/design-md]] — AI エージェント向けデザインシステム記述フォーマット（概念）
- [[wiki/awesome-design-md]] — 有名サービスの DESIGN.md コレクション
- [[wiki/google-stitch]] — Google の UI 生成ツール（DESIGN.md の提唱元）
- [[wiki/claude-design]] — Anthropic の AI デザイン協働ツール
