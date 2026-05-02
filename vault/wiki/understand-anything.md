---
type: entity
status: []
tags:
  - tool/claude-code
  - ai/agent
  - ai/llm
sources:
  - "https://github.com/Lum1104/Understand-Anything"
created: 2026-05-02
updated: 2026-05-02
---

# Understand-Anything

コードベースと知識ベースをインタラクティブなビジュアル知識グラフに変換する OSS プラグイン。マルチエージェントパイプラインでコードを解析し、JSON 形式の知識グラフを生成する。

| 項目 | 内容 |
|------|------|
| GitHub Stars | 10.1k |
| Forks | 849 |
| 言語 | TypeScript |
| ライセンス | OSS |

## 主な機能

| 機能 | 内容 |
|------|------|
| **構造的探索** | ファイル・関数・クラス・依存関係をグラフとして可視化 |
| **ドメインマッピング** | ビジネスロジックをドメイン・フロー・プロセスで表現 |
| **知識ベース解析** | Karpathy パターンの wiki を力指向グラフに変換 |
| **ガイドツアー** | 依存関係順の自動ウォークスルー生成 |
| **セマンティック検索** | ファジー名称マッチングと意味ベース検索 |
| **変更影響分析** | コミット前に影響範囲を把握 |
| **アーキテクチャ可視化** | API/Service/Data/UI/Utility レイヤーの自動分類 |

## 対応プラットフォーム

Claude Code・Codex・Cursor・GitHub Copilot・Copilot CLI・Gemini CLI

## 活用シナリオ

1. **新しいプロジェクトへの参画時** — コードグラフを一度生成してから全体像を把握
2. **ナレッジベースの管理** — wiki ページ間の関係を可視化（このvaultにも適用可能）
3. **レガシーコード理解** — テストが少ない大規模コードベースの構造解析

## 関連ページ

- [[wiki/llm-wiki-pattern]] — Karpathy の LLM Wiki パターン（raw/wiki/schema 3層）
- [[wiki/ai-vuln-deep-structure-map]] — コードをグラフ化して脆弱性を探索
- [[wiki/ast-graph-vulnerability-detection]] — AST+グラフ理論による脆弱性検出
