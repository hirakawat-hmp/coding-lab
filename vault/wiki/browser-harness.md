---
type: entity
status: []
tags:
  - ai/agent
  - tool/claude-code
  - dev/python
sources:
  - "https://github.com/browser-use/browser-harness"
created: 2026-04-25
updated: 2026-04-25
---

# Browser Harness

LLM がブラウザタスクを自由に完了するための自己修復型自動化フレームワーク。Chrome DevTools Protocol (CDP) を直接使用し、中間フレームワーク不要の軽量設計。

## 概要

| 項目 | 詳細 |
|------|------|
| リポジトリ | https://github.com/browser-use/browser-harness |
| ライセンス | MIT |
| Stars | 6.4k（2026年4月時点） |
| 言語 | Python（約 592 行） |

## アーキテクチャ

```
run.py        (~36 行)  — エントリポイント
helpers.py    (~195 行) — LLM が呼び出せるツール群
admin.py + daemon.py (~361 行) — CDP WebSocket 管理
```

## セルフヒーリング設計

最大の特徴は、LLM が実行中に **足りない機能を自分で `helpers.py` に書き足す** こと。事前にすべてのユースケースを実装する必要がなく、エージェントが自律的に能力を拡張する。

## ドメインスキル

LinkedIn、Amazon、GitHub など特定サイト向けの専用スキルを community が蓄積。スキルはエージェントが生成したものを推奨（手書きより実用的なものになりやすい）。

## クラウドオプション

無料枠：同時 3 ブラウザまで（Proxy + CAPTCHA 解決付き）。

## Show HN 反響

2026年4月24日の Hacker News フロントページに掲載。「592 行で LLM ブラウザ自動化」というシンプルさが注目を集めた。

## 関連ページ

- [[wiki/bun-headless-browser]] — Bun の組み込みヘッドレスブラウザ
- [[wiki/claude-code-routines]] — Claude Code の自動実行機能
