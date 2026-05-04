---
type: entity
status: []
tags:
  - tool/claude-code
  - ai/llm
  - infra/aws
sources:
  - "https://github.com/aattaran/deepclaude"
  - "https://news.ycombinator.com/item?id=48002136"
created: 2026-05-04
updated: 2026-05-04
---

# DeepClaude

Claude CodeのUIと機能を維持しながら、バックエンドLLMをDeepSeek V4 Proなどの安価なモデルに切り替えるOSSツール。作者：aattaran（2026年5月公開）。

## 概要

Claude CodeのエージェントループをIntercept（傍受）し、Anthropic APIへのリクエストを別のAPIエンドポイントに中継する仕組み。CursorがClaude CodeのUIを置き換えるのとは異なり、**Claude Code自体のCLIをそのまま使いながら**コスト削減を実現する。

## コスト比較

| プラン | 月額 | 削減率 |
|--------|------|--------|
| Anthropic Max | $200 | — |
| DeepClaude + DeepSeek V4 Pro | ~$20 | 90% |

出力トークン単価：$0.87/M（DeepSeek使用時。Anthropic比で17倍安い）

## 対応モデル

- **DeepSeek V4 Pro**（推奨・最安）
- OpenRouter 経由の各種モデル
- Fireworks AI
- Anthropic（フォールバック用）

## 技術仕様

- **言語構成**: PowerShell 46% / Shell 39.1% / JavaScript 14.9%
- **必要環境**: Node.js 18以上（リモートコントロール使用時）
- **対応OS**: Windows・macOS・Linux

## 主な機能

- ファイル読み書き・bash実行・git操作・マルチステップエージェントループ完全対応
- ブラウザからリモートコントロール（任意デバイスでセッション操作）

## 注意点

- DeepSeekはAnthropicのモデルではないため、品質・安全性特性が異なる
- セキュリティ要件が高い環境でのリモートコントロール機能は審査が必要
- Claude Max契約の規約との整合性確認を推奨

## 関連ページ

- [[wiki/agentic-coding-trap]] — Agentic Codingコスト問題の背景
- [[wiki/claude-code-token-reduction-5tips]] — 公式の範囲内でトークン消費を抑える方法
- [[wiki/rtk]] — Rustで作られたClaude Codeトークン消費削減ツール
