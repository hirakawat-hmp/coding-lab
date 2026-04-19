---
type: entity
status: []
tags:
  - ai/llm
  - ai/agent
  - tool/mcp
  - dev/python
sources:
  - "https://qiita.com/rikarazome/items/d78fcb4a810035493c23"
  - "https://github.com/rikarazome/prolog-reasoner"
created: 2026-04-19
updated: 2026-04-19
---

# prolog-reasoner — Prolog で LLM 論理推論を強化する MCP サーバー

SWI-Prolog と Claude を MCP (Model Context Protocol) で統合するオープンソースサーバー。LLM が苦手とする制約充足・組合せ最適化問題の論理推論精度を大幅に向上させる（2026年4月公開）。

## 解決する問題

LLM は自然言語理解に優れるが、以下のような**厳密な論理推論**が必要な問題が苦手:

- 覆面算（SEND + MORE = MONEY）
- ゲーム理論（Nim 石取りゲーム）
- タスク割り当て問題
- 制約充足問題全般

## アーキテクチャ

```
LLM (Claude)
    ↓ MCP ツール呼び出し
prolog-reasoner サーバー
    ↓ Prolog コード生成
SWI-Prolog（CLP(FD) 対応）
    ↓ 実行結果
LLM (Claude)
```

ユーザーは Prolog を知らなくても、Claude が自動的に Prolog コードを生成・実行する。

## ベンチマーク（30問の論理問題）

| 条件 | 正答率 | 向上 |
|------|--------|------|
| LLM のみ | 73.3% | — |
| LLM + prolog-reasoner | 90.0% | +16.7pt |

細目:
- 制約充足問題: 43% → 86%（+43pt）
- 多ステップ推論: 43% → 100%（+57pt）

## 主要機能

| 機能 | 詳細 |
|------|------|
| `execute_prolog` ツール | CLP(FD) 対応 Prolog コードを実行 |
| ルールベース管理 | 安定したルールを保存・読み込み・再利用 |
| ステートレス設計 | 実行ごとに独立、再現性を保証 |

## インストール

```bash
pip install prolog-reasoner
```

PyPI: https://pypi.org/project/prolog-reasoner/
GitHub: https://github.com/rikarazome/prolog-reasoner
ライセンス: MIT

## 関連ページ

- [[wiki/mcp-security-vulnerability-2026]] — MCP エコシステムの拡大と脆弱性
- [[wiki/ai-engineering-harness-era]] — LLM ＋ツールのハーネス設計
