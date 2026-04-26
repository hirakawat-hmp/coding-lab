---
type: entity
status: []
tags:
  - ai/agent
  - infra/gcp
  - framework/adk
sources:
  - "https://zenn.dev/makocchan/articles/whats_agents_cli"
created: 2026-04-26
updated: 2026-04-26
---

# Google agents-cli

![agents-cli](https://static.zenn.studio/user-upload/deployed-images/1cac8724722bf1b14753a244.png)

Google Cloud Next '26（2026年4月）で発表されたAIエージェント開発CLI。「AIエージェント開発に必要となる実装、評価、デプロイといったプロセスを実行するためのインタフェース」を提供する。

## 概要

Gemini CLI・Claude Code などのコーディングエージェントからの実行にも対応し、7つのスキルセットでエージェント開発の全工程をカバーする。

## 7つのスキルセット

1. **ワークフロー定義** — エージェントの動作フローを定義
2. **スキャフォーディング** — プロジェクト雛形の生成
3. **実装リファレンス** — ベストプラクティスのコード参照
4. **評価** — エージェントのパフォーマンス評価
5. **デプロイ** — Cloud Run/GKE/Agent Runtimeへの展開
6. **公開** — エージェントの公開・共有
7. **可観測性** — 実行ログ・メトリクス管理

## 主要コマンド

```bash
agents scaffold create    # プロジェクト作成
agents lint               # 静的解析
agents run                # エージェント実行
agents eval run           # 評価実行
agents deploy             # デプロイ
```

## 特徴

コマンドが細かく分割されており、既存の開発フローへの部分的な導入が容易。コーディングエージェント（Gemini CLI、Claude Code等）からの実行もサポート。

## 関連ページ

- [[wiki/gemini-enterprise-agent-platform]] — Gemini Enterprise Agent Platformの全体像
- [[wiki/framework/adk]] — Google Agent Development Kit
