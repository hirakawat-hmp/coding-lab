---
type: entity
status: []
tags:
  - ai/agent
  - dev/typescript
sources:
  - "https://flueframework.com/"
created: 2026-05-03
updated: 2026-05-03
---

# Flue：TypeScript製AIエージェントフレームワーク

Hacker News フロントページに登場（2026年5月2日）。サードパーティ SDK に依存しない TypeScript 製オープンソース AI エージェントハーネスフレームワーク。

## コアコンセプト

**「モデル + ハーネス」設計**

エージェントは計画立案・コンテキスト収集・ファイル書き込み・サブエージェント生成・役割採用・問題解決を行える。

[[wiki/agent-harness-outside-sandbox]] で論じた「ハーネスはサンドボックスの外に置く」原則を具体的に実装したフレームワーク。

## 主な機能

| 機能 | 詳細 |
|------|------|
| **サンドボックス** | 内蔵仮想サンドボックスまたはリモートコンテナ（Daytona、Cloudflare Workers） |
| **型安全なスキル** | Valibot による型バリデーション付き再利用可能スキル |
| **クレデンシャル分離** | サンドボックスはトークン・API キーに直接アクセスできない |
| **マルチデプロイ** | HTTP サーバー、CLI、サーバーレス組み込みに対応 |

## ユースケース

- Issue トリアージ自動化
- データ分析エージェント
- コーディングエージェント
- カスタマーサポートワークフロー

## ポジショニング

既存ツール（Dune、Grepitile、CodeRabbit）のような SaaS に頼らず、**スタック全体をチームが所有**することを重視。プロダクト固有のカスタマイズが必要な企業向け。

## 比較

| フレームワーク | 言語 | ハーネス分離 | クレデンシャル分離 |
|--------------|------|------------|----------------|
| Flue | TypeScript | ✓ | ✓ |
| Mastra | TypeScript | △ | △ |
| OpenAI Agents SDK | Python/TS | ✓ | ✓ |

**関連ページ:** [[wiki/agent-harness-outside-sandbox]] — ハーネスをサンドボックス外に置く設計論  
**関連ページ:** [[wiki/openai-agents-sdk-v2]] — OpenAI Agents SDK  
**関連ページ:** [[wiki/framework/mastra]] — Mastra TypeScript AI エージェントフレームワーク
