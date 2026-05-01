---
type: entity
status: []
tags:
  - tool/claude-code
  - security/web
  - ai/llm
sources:
  - "https://www.itmedia.co.jp/aiplus/articles/2605/01/news051.html"
  - "https://www.anthropic.com/news/claude-code-security"
  - "https://siliconangle.com/2026/04/30/anthropic-announces-claude-security-public-beta-find-fix-software-vulnerabilities/"
created: 2026-05-01
updated: 2026-05-01
---

# Claude Security

![Claude Security](https://image.itmedia.co.jp/aiplus/articles/2605/01/ts1648348_202604302_1_w490.jpg)

Anthropicが2026年5月1日に公開ベータ発表したAIコードセキュリティツール。AIが生成したコードを含むコードベース全体を対象に、脆弱性の自動検出と修正提案を実施する。2026年2月に限定プレビューとして開始し、数百社が導入済みの状態で公開ベータへ移行。

## 概要

- **基盤モデル**: Claude Opus 4.7
- **対象**: コードベース全体（AI生成・人間生成を問わず）
- **対応プラン**: Claude Enterprise Team版およびMax版（段階的提供）
- **実績**: 公開ベータ前の段階で500件超の脆弱性を発見・修正済み

## 技術的特徴

従来のSAST（静的解析）ツールと異なり、人間のセキュリティリサーチャーのように推論する:

1. **コンポーネント間の相互作用を理解** — 個別ファイルではなくシステム全体として解析
2. **データフローをトレース** — 入力から出力までのデータ経路を追跡
3. **多段階検証** — 誤検知除去のため結果を再分析
4. **重大度評価** — 優先度付きで修正を提案

## 関連プロジェクト

**Project Glasswing**: 関連セキュリティ対策プロジェクト（詳細未公開）。Apple・Microsoft・Googleが参加するセキュリティ研究との連携も示唆。

## 位置づけ

[[wiki/claude-mythos]]（サイバーセキュリティ特化モデル）が脆弱性リサーチ向けだとすれば、Claude Securityは開発者向けの日常的なセキュアコーディング支援ツールとして位置づけられる。

## 関連ページ

- [[wiki/claude-mythos]] — Anthropicのサイバーセキュリティ特化モデル
- [[wiki/claude-code-security-incidents]] — Claude Codeで実際に起きたセキュリティ事故
- [[wiki/mcp-security-vulnerability-2026]] — MCPのシステム的脆弱性
- [[wiki/cve-mcp-server]] — CVE MCPサーバー（Claude × MCP × セキュリティ）
