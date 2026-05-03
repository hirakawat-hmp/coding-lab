---
type: concept
status: []
tags:
  - ai/agent
  - infra/vm
sources:
  - "https://www.mendral.com/blog/agent-harness-belongs-outside-sandbox"
created: 2026-05-03
updated: 2026-05-03
---

# エージェントハーネスはサンドボックスの外に置くべき

Mendral の Andrea Luzzardi による AI エージェントアーキテクチャ論。

## 2つのアーキテクチャモデル

### モデル1：ループをサンドボックス内に配置（従来型）

```
[Harness Loop] ← 同一コンテナ → [Sandbox / Code]
```

- 実装がシンプル
- スケールしない：クレデンシャルがサンドボックス内に存在し続ける
- 障害時にセッション全体が終了

### モデル2：ループをバックエンドに配置（推奨）

```
[Backend Harness Loop] → API → [Sandbox] 
                      → API → [Tools]
```

## バックエンドハーネスの利点

| 利点 | 詳細 |
|------|------|
| **クレデンシャル保護** | 秘密鍵がサンドボックスに渡らない |
| **リソース効率** | サンドボックスはアイドル時にサスペンド |
| **耐障害性** | サンドボックス交換可能・障害でセッション終了しない |
| **マルチユーザー** | 分散ファイルシステム問題 → 共有 DB 問題に変換 |

## Mendral の実装

**耐久性ある実行：** Inngest でデプロイをまたぐチェックポイント  
**サンドボックスライフサイクル：** Blaxel（25ms 再開時間）  
**ファイルシステム仮想化：** パスを透過的にサンドボックスまたは Postgres に振り分け

## 未解決の課題

1. 標準的な Claude Code パターンと乖離する
2. Bash コマンドが仮想化レイヤーをバイパスできる
3. 並行メモリ更新の整合性モデルが未解決

## Flue との関係

[[wiki/flue-agent-framework]] も同じ「ハーネスをサンドボックス外に」設計を採用している。Mendral の問題意識とほぼ同一の解決策を TypeScript フレームワークとして提供。

## 関連概念との比較

- [[wiki/openai-agents-sdk-v2]] — OpenAI も同様のサンドボックス/ハーネス分離を実装
- [[wiki/snapstate]] — エージェントワークフローの永続状態管理（チェックポイント機能）
- [[wiki/smolvm]] — サブ秒コールドスタートの軽量 VM（サンドボックス候補）
- [[wiki/ai-engineering-harness-era]] — ハーネスエンジニアリング時代の概念整理
