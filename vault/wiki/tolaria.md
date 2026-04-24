---
type: entity
status: []
tags:
  - km/vault
  - km/obsidian
  - km/markdown
  - dev/typescript
sources:
  - "https://github.com/refactoringhq/tolaria"
created: 2026-04-24
updated: 2026-04-24
---

# Tolaria

macOS 向けのオープンソース Markdown ナレッジベース管理デスクトップアプリ。個人の第二の脳、企業ドキュメント、AI エージェントのメモリ管理などに活用される。2026-04-23 にリリース v2026.4.23 を発表し HN トップページに掲載。

## 主な特徴

| 特徴 | 説明 |
|------|------|
| **ファイル優先** | プレーンな Markdown ファイル。ポータビリティと所有権を確保 |
| **Git 統合** | 全リポジトリが git ベース。完全なバージョン履歴 |
| **オフラインファースト** | サブスクリプション不要、サーバー依存なし |
| **オープンソース** | AGPL-3.0 ライセンス |
| **AI 対応** | Claude Code など複数の AI エージェントに対応 |

## 技術スタック

- **フレームワーク**: Tauri + React
- **言語**: TypeScript (64.9%), JavaScript (21.1%), Rust (11.7%)
- **必要環境**: Node.js 20+, pnpm 8+, Rust stable, macOS

## 統計（2026-04-23 時点）

- Stars: **~1,600**
- Forks: 115
- Releases: 625
- ライセンス: AGPL-3.0

## Obsidian との比較

Tolaria は Obsidian に似た思想（ローカルファイルベース）を持つが、以下の点で差別化している:

- **Git ネイティブ**: バージョン管理が組み込み
- **AI エージェントとの親和性**: Claude Code 等での直接操作を前提とした設計
- **完全 OSS**: Obsidian と異なり有料プランなし

## 文脈

[[wiki/llm-wiki-pattern]] で示されたように、AI エージェントが直接編集できるファイルベースのナレッジシステムが注目を集めている。Tolaria はこのトレンドにマッチするツールとして登場した。

## 関連ページ

- [[wiki/llm-wiki-pattern]] — Karpathy の LLM Wiki パターン（raw/wiki/schema 3層）
- [[wiki/markdown-knowledge-base-tools-comparison]] — Obsidian 代替ツールの比較
- [[wiki/knowledge-vault-lessons]] — Knowledge Vault 構築で得たハマりどころと教訓
