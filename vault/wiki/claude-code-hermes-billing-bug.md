---
type: troubleshooting
status: [resolved]
tags:
  - tool/claude-code
  - security/api
sources:
  - "https://github.com/anthropics/claude-code/issues/53262"
created: 2026-04-30
updated: 2026-04-30
---

# Claude Code HERMES.md コミットメッセージによる課金ルーティングバグ

![Claude Code HERMES.md billing bug](https://opengraph.githubassets.com/1/anthropics/claude-code/issues/53262)

## 概要

Claude Code v2.1.119 に重大な課金バグが発見された（GitHub Issue #53262、HN 944 ポイント）。git コミットメッセージに大文字で `HERMES.md` という文字列が含まれていると、Max プランの利用枠ではなく「extra usage（追加課金）」にルーティングされる。

## 再現条件

| コミットメッセージ | 課金先 |
|---|---|
| `"HERMES.md"` | ❌ extra usage（追加課金） |
| `"test HERMES.md test"` | ❌ extra usage（追加課金） |
| `"hermes.md"`（小文字） | ✅ プラン枠 |
| `"HERMES"`（拡張子なし） | ✅ プラン枠 |
| `"HERMES.txt"` | ✅ プラン枠 |
| `"AGENTS.md"` / `"README.md"` | ✅ プラン枠 |

## 根本原因

Claude Code はシステムプロンプトに最近の git コミットを含める。サーバー側のルーティングロジックが `HERMES.md`（case-sensitive）という文字列を誤解釈し、API リクエストを extra usage 課金にルーティングする。

HERMES はおそらく Anthropic 社内の何らかのシステム名であり、ファイル名として渡されると誤検知が起きると推測される。

## 財務的影響

報告者は $200.98+ が extra usage として消費され、プラン枠は 86% 以上残存していた。Max 20x プラン（$200/月）の1ヶ月分相当が意図せず消費された。

## 対処法

コミットメッセージに `HERMES.md` という文字列を使わない。既存のコミットがある場合は `git rebase` でメッセージを修正する。

## 関連ページ

- [[wiki/claude-code-tokenocalypse]] — Claude Code v2.1.88 Tokenocalypse（トークン爆発の別インシデント）
- [[wiki/claude-code-security-incidents]] — Claude Code で実際に起きたセキュリティ事故 7選
- [[wiki/ai-tool-security-incidents-8-2026]] — AI ツールセキュリティ実在インシデント 8 選
