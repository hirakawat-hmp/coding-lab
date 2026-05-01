---
type: entity
status: []
tags:
  - tool/claude-code
  - ai/agent
  - dev/bash
sources:
  - "https://pu.dev/"
  - "https://news.ycombinator.com/item?id=47963204"
created: 2026-05-01
updated: 2026-05-01
---

# pu.sh — 400行シェルスクリプトのコーディングエージェントハーネス

![pu.sh](https://pu.dev/og.png)

約400行のシェルスクリプトで実装されたコーディングエージェントハーネス。npm・pip・Dockerなど重い依存関係なしで動作する超軽量実装。Hacker Newsで「Show HN」として紹介。

## 技術詳細

**依存関係 (3つのみ):**
- `curl` — HTTPリクエスト
- `awk` — テキスト処理
- APIキー — LLM連携

**インストール:**
```bash
curl -sL pu.dev/pu.sh -o pu.sh && chmod +x pu.sh
```

## 設計思想

「ポケットに入るほど小さなスロップキャノン」（*a slop cannon small enough to fit your pocket*）——軽量・自己完結・ポータブルを極限まで追求した設計。

## 位置づけ

| 比較 | pu.sh | Claude Code | ccgate |
|------|-------|-------------|--------|
| 依存関係 | curl + awk | npm | Go |
| 規模 | ~400行 | 大規模 | 中規模 |
| 特徴 | 極限ミニマム | フル機能 | Permission自動化 |

大規模なフレームワークに対するアンチテーゼとして、シェルスクリプト1本でエージェントハーネスを実装した実験的アプローチ。[[wiki/ccgate]]や[[wiki/claude-code-precompact-hook]]などのClaude Codeハーネスパターンとは対照的。

## リポジトリ

- GitHub: NahimNasser/pu
- ライセンス: MIT
- サイト: pu.dev

## 関連ページ

- [[wiki/ccgate]] — AI Permission確認を97%自動化するOSS CLIエージェント
- [[wiki/claude-code-harness-patterns]] — Claude Codeハーネスパターン
- [[wiki/ai-engineering-harness-era]] — AI エンジニアリング3フェーズ進化
