---
type: how-to
status: [draft]
tags:
  - tool/claude-code
  - ai/agent
sources:
  - "https://qiita.com/hiropon122/items/80e76424effeeb5431c2"
created: 2026-05-03
updated: 2026-05-03
---

# Claude Code：プロジェクト固有のコーディング規約を自動抽出する

Sonic Garden の Masato Hirokami が公開した Claude Code スキル。「チームらしいコード」を Claude に書かせるために、プロジェクト固有の規約を自動抽出・ルール化する。

## 設計思想

**「Claude がまだ知らないことだけを抽出する」**

一般的なベストプラクティスはすでに Claude が学習済み。抽出対象はチーム固有の慣習のみとし、コンテキスト汚染を防ぐ。

## 3つの動作モード

### `/extract-rules`（初期バッチ抽出）

コードベース全体を解析し、以下を抽出：
- 命名規約
- ディレクトリ構造パターン
- コンポーネント設計の慣習
- テストの書き方

### `--from-conversation`（対話中キャプチャ）

ペアプログラミング中に Claude が提案 → 人間が修正 → その差分をルール化。日常的に `--from-conversation` を実行するのが推奨ワークフロー。

### `--from-pr`（PR レビューからの学習）

複数 PR のコードレビューコメントを横断分析し、繰り返し指摘されるパターンを自動でルール化。

## 出力構造

```
rules/
  principles.md    # 他プロジェクトにも移植可能な原則
  project.md       # このプロジェクト固有のパターン
  examples/        # ルールの具体例（トークン節約のため分離）
```

**例と本体を分離する**理由：LLM への入力トークン削減。必要な時だけ例を参照する設計。

## 今後追加予定のコマンド

- `merge-rules` — ルールの統合・重複排除
- `apply-rules` — CLAUDE.md への自動反映
- `rules-review` — 定期的なルール見直し

## リポジトリ

[hiroro-work/claude-plugins](https://github.com/hiroro-work/claude-plugins)

**関連ページ:** [[wiki/claude-code-three-layer-design]] — CLAUDE.md/Skills/Agentsの3層設計  
**関連ページ:** [[wiki/skill-md-pattern]] — SKILL.md パターン  
**関連ページ:** [[wiki/claude-code-token-reduction-5tips]] — トークン削減テクニック
