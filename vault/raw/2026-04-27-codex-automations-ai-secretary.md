# Codex Automations × 公式プラグイン 90 個で「AI 秘書」を組む

source: https://qiita.com/nogataka/items/139148b11e416e23722b
fetched: 2026-04-27

## 概要

OpenAI の新機能「Codex Automations」と公式プラグイン（90以上）を組み合わせて、定型業務を自動化する方法。

## Codex Automations の 2 モード

- Thread Automation: 既存スレッドを継続実行（週次レポート追記など）
- Standalone Automation: 新規タスクでゼロから起動（朝のトリアージなど）

## 基本コマンド

```bash
codex automation create \
  --name "morning-issue-triage" \
  --schedule "0 9 * * 1-5" \
  --mode standalone \
  --plugins github,slack \
  --timezone "Asia/Tokyo"
```

## 実装例 3 つ

1. 朝9時：GitHub Issue トリアージ（優先度ラベル付与、作業量5分の1）
2. 13時：Sentry エラー調査（増加傾向抽出・PRドラフト自動生成）
3. 17時：Slack 要約 → Notion 保存（未対応質問・明日のTODO抽出）

## コスト

著者月 $50 程度で運用（5本のAutomation）

## 落とし穴

1. OAuth トークンは数週間〜数ヶ月で期限切れ → 失敗時アラート必須
2. タイムゾーン指定忘れで UTC で動作 → Asia/Tokyo を明示
3. 「いい感じに整理」のような曖昧プロンプトは暴走
