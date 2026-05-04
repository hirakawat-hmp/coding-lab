---
type: concept
status: []
tags:
  - ai/agent
  - tool/claude-code
  - design/system
sources:
  - "https://zenn.dev/genda_jp/articles/f71d3ed7d4d7e8"
created: 2026-05-04
updated: 2026-05-04
---

# AIに渡す指示書の3層分業：AGENTS.md / SKILL.md / DESIGN.md

AIエージェント向けの指示書ファイルが3つの異なる役割に分業されつつある設計論。2026年5月時点で、複数の企業・標準化団体が異なるファイル形式を推進している。

## 3層の役割分担

| 層 | ファイル名 | 担当範囲 | 推進主体 |
|----|-----------|----------|----------|
| 見た目 | `DESIGN.md` | デザインシステム仕様（色・タイポ・コンポーネント） | Google Labs |
| 個別タスク | `SKILL.md` | 再利用可能なタスク単位と手順 | Anthropic |
| 動き方 | `AGENTS.md` / `CLAUDE.md` | エージェント全体の前提・ロール・禁止事項 | OpenAI等 |

## 機械検証可能かどうかの区別

- **仕様化できるもの（DESIGN.md）**: 色のコントラスト比・用語の言い換え → CLIで自動検証
- **自然言語で残すもの（CLAUDE.md）**: 文体のトーン・文化的ニュアンス・倫理的判断

この区別が3層分業の設計思想の核心。

## 仕様駆動開発（SDD）との関係

| 概念 | 目的 | 性質 |
|------|------|------|
| SDD | 「これから作るもの」の仕様を書く | 一過性のプロセス |
| 3層分業 | 「常に守られるべき規範」を永続管理 | 継続的な仕組み |

両者は競合しない。SDDで決まった仕様をDESIGN.mdに記載し、エージェントの振る舞いをCLAUDE.mdで定義するという相互参照が推奨される。

## 実践的な使い分け

```
DESIGN.md   ← プロジェクトのデザインルール（色・フォント・コンポーネント仕様）
SKILL.md    ← 繰り返し行うタスクの手順（デプロイ・テスト実行・コードレビュー）
CLAUDE.md   ← このvault/プロジェクト全体への指示（禁止事項・ロール定義）
```

## 関連ページ

- [[wiki/skill-md-pattern]] — SKILL.mdパターン詳細（折りたたみ式マニュアル）
- [[wiki/google-labs-design-md]] — Google Labsが提唱するDESIGN.md仕様
- [[wiki/claude-code-three-layer-design]] — Claude Code 3層設計パターン（CLAUDE.md/Skills/Agents）
- [[wiki/claude-code-project-conventions]] — プロジェクト固有コーディング規約の自動抽出スキル
