---
type: entity
status: []
tags:
  - tool/claude-code
  - ai/agent
  - ai/prompt-engineering
created: 2026-05-05
updated: 2026-05-05
sources:
  - "https://addyosmani.com/blog/agent-skills/"
  - "https://github.com/addyosmani/agent-skills"
---

# Agent Skills — Addy Osmani によるAIコーディングエージェントスキル集

Google Chrome エンジニアAddy Osmaniが公開したオープンソースプロジェクト。シニアエンジニアが実践するワークフロー・品質ゲート・ベストプラクティスを「スキル」として符号化し、AIエージェントに一貫した品質での実行を可能にする。

## コンテンツ構成

- **20のコアスキル**: Define→Plan→Build→Verify→Review→Ship 全ライフサイクルをカバー
- **7のスラッシュコマンド**: 素早いアクション呼び出し
- **3つの専門ペルソナ**: コードレビュアー（Senior Staff Engineer視点）、テストエンジニア（QA専門家）、セキュリティ監査人
- **4つのリファレンスチェックリスト**: 品質確認用

## 主要特徴

### Anti-rationalization（言い訳防止）

各スキルには「後でテストを追加する」「今回は時間がない」などAIが実際に使う言い訳と、それへのカウンター主張を記載。エージェントが品質ゲートをスキップするのを防ぐ。

### マルチプラットフォーム対応

- Claude Code
- Cursor
- Gemini CLI
- Windsurf
- GitHub Copilot
- Kiro

## 設計思想

スキルは単なるプロンプトではなく、**品質ゲート付きの構造化されたワークフロー**。AIエージェントが「できた」と言ってもゲートをクリアするまで完了と認められない。

## 関連ページ

- [[wiki/skill-md-pattern]] — SKILL.md折りたたみ式マニュアルパターン
- [[wiki/claude-code-three-layer-design]] — Claude Code 3層設計パターン
- [[wiki/agents-skill-design-md-roles]] — AGENTS.md/SKILL.md/DESIGN.mdの役割分担
- [[wiki/karpathy-agentic-engineering]] — エージェントエンジニアリング
