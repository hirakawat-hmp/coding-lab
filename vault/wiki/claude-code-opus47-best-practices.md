---
type: insight
status: []
tags:
  - tool/claude-code
  - ai/prompt-engineering
sources:
  - "https://qiita.com/ot12/items/06420caf41a34a910c53"
created: 2026-04-25
updated: 2026-04-25
---

# Claude Opus 4.7 時代にやめるべき 6 つのこと（Claude Code ベストプラクティス更新）

2026年4月16日の Claude Opus 4.7 リリースに伴い、Claude Code 作者 Boris Cherney が X（Twitter）で発表した 6 つの「旧来の使い方を廃止すべき」ポイント。

## 背景

Opus 4.7 はそれ以前のモデルより自律性・計画能力が向上し、細かい人間の介入が**逆効果**になるケースが増えた。これを受けてベストプラクティスが大きく更新された。

## やめるべき 6 つのこと

### 1. ペアプロ的な細かい指示
- **旧**：一行ずつ確認しながら作業
- **新**：初回プロンプトで「目的 / 制約 / 完了条件」を包括的に指定し、途中介入を極力減らす

### 2. Effort Level を max に常用
- **旧**：常に `--effort max` で最高品質を期待
- **新**：デフォルトは `xhigh`。`max` は「考えすぎ」になって逆効果になる場合がある

### 3. `--dangerously-skip-permissions` の常用
- **旧**：権限プロンプトを避けるため常時使用
- **新**：Auto Mode や [[wiki/claude-code-intro-guide]] の `/fewer-permission-prompts` で安全に代替

### 4. 長時間セッションの横付き見守り
- **旧**：Claude が作業している間ずっと監視
- **新**：Focus Mode（結果のみ表示）や Recaps（自動サマリー）で見守りを不要にする

### 5. Subagent を毎回呼び出す
- **旧**：複雑なタスクには常に subagent を明示的に起動
- **新**：「複数ファイル並列作業」「完全独立タスク」以外は Claude の自動判断に任せる

### 6. 検証機構なしで任せる
- **旧**：「よしなにやって」と投げきり
- **新**：テスト・スクリーンショット・期待出力を事前提供し、Claude 自身が検証できる構成にする

## 実務チェックリスト

- [ ] Claude Code v2.1.111 以上に更新
- [ ] Effort を `xhigh` に設定（max は外す）
- [ ] 初回プロンプトを構造化：`Goal / Constraints / Acceptance criteria`
- [ ] Stop Hook でテスト検証を自動実行
- [ ] `/fewer-permission-prompts` で許可リストを整理

## 旧ベストプラクティスとの比較

これらの変更は [[wiki/claude-opus-47-changes]] で記録されたシステムプロンプト変更と連動している。Opus 4.7 はより「自律的に行動してほしい」というモデル特性を持つ。

## 関連ページ

- [[wiki/claude-opus-47-changes]] — Opus 4.6→4.7 のシステムプロンプト変更
- [[wiki/anthropic-claude-code-postmortem-2026-04]] — Claude Code 品質低下の背景
- [[wiki/ai-engineering-harness-era]] — AI エンジニアリングのフェーズ進化
- [[wiki/skill-md-pattern]] — SKILL.md による Claude Code 最適化パターン
