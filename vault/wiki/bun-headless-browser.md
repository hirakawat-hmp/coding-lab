---
type: entity
status: []
tags:
  - dev/javascript
  - ai/agent
sources:
  - "https://www.publickey1.jp/blog/26/bunheadless_brwoser_automation.html"
created: 2026-04-14
updated: 2026-04-14
---

# Bun Headless Browser Automation

## 概要

Bun v1.3.12（2026年4月リリース）で追加されたヘッドレスブラウザ操作機能。
コマンドラインおよびプログラマティックに Chromium を制御できる。

## 基本コマンド（CLI）

```bash
bunwv start                      # ブラウザ起動
bunwv navigate https://example.com  # ページ遷移
bunwv screenshot                 # スクリーンショット取得
bunwv click-text "リンクテキスト" # テキストリンクをクリック
```

## プラットフォーム対応

| OS | 実装 | 特記 |
|---|---|---|
| macOS | OS レベル操作 | ネイティブ操作と区別不可能 |
| Windows / Linux | Chrome/Chromium 自動検知 | DevTools プロトコル経由 |

## AI エージェントとの連携

Claude Code などの AI エージェントからブラウザ操作をシームレスに実行できる。
MCP ツール経由でなく、直接 Bun API / CLI コマンドを呼び出す形で Web テスト・スクレイピング・自動化が可能。

Playwright MCP などの外部ツールに依存せず、Bun 単体で完結する点が特徴。

## 位置付け

既存の Playwright / Puppeteer との差別化点:
- Bun ランタイムと完全統合（Node.js 不要）
- CLI ファーストの設計でスクリプト不要の簡易操作
- AI エージェントが自然言語で指示しやすいシンプルなコマンド体系

## 関連ページ

- [[wiki/gaia-local-ai-agent]] — ローカル AI エージェントでのブラウザ操作ユースケース
- [[wiki/snapstate]] — AI エージェントワークフローの永続化（ブラウザ操作の途中再開に応用可能）
