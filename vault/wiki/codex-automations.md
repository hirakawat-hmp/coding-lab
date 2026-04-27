---
type: entity
status: []
tags:
  - ai/agent
  - infra/ci-cd
sources:
  - "https://qiita.com/nogataka/items/139148b11e416e23722b"
created: 2026-04-27
updated: 2026-04-27
---

# Codex Automations

OpenAI が提供する Codex のスケジュール実行機能。cron 構文で定時に自律タスクを実行し、GitHub・Slack・Notion 等の公式プラグイン（90以上）と組み合わせて「AI 秘書」的な定型業務自動化を実現する。

## 2 つの実行モード

| モード | 説明 | ユースケース |
|--------|------|------------|
| Thread Automation | 既存スレッドを継続実行 | 週次レポートへの追記 |
| Standalone Automation | 新規タスクでゼロから起動 | 朝のトリアージ |

## 基本コマンド

```bash
codex automation create \
  --name "morning-issue-triage" \
  --schedule "0 9 * * 1-5" \
  --mode standalone \
  --plugins github,slack \
  --timezone "Asia/Tokyo"
```

cron 構文は「分 時 日 月 曜日」の順。タイムゾーン未指定時は UTC で解釈されるため注意。

## 実用ユースケース 3 選

### 1. 朝9時：GitHub Issue トリアージ
未処理 Issue を取得して優先度ラベルを付与。判断が難しい案件は人間にレビュー送付。作業量が約 5 分の 1 に削減。

### 2. 13時：Sentry エラー調査
過去 24 時間のエラーから増加傾向を抽出し、修正案を PR ドラフトで自動生成。必ず人間がレビューしてからマージ。

### 3. 17時：Slack 要約 → Notion 保存
主要チャンネルの投稿を自動要約し、未対応質問・明日の TODO を抽出して Daily Log に保存。

## コスト感

| プラン | Automation 数 | 月額目安 |
|--------|--------------|---------|
| 軽量 | 2本 | $20–30 |
| 標準 | 5本 | $40–60 |
| 本格 | 10本 | $80–150 |

実践者は月 $50 程度で 5 本の Automation を運用（時給換算で採算性あり）。

## よくある落とし穴

1. **OAuth トークン期限切れ**: GitHub・Slack の OAuth トークンは数週間〜数ヶ月で失効 → 失敗時アラートと週次認証チェックが必須
2. **タイムゾーンずれ**: `Asia/Tokyo` を明示しないと UTC で動作し、朝9時指定が実は18時に実行される
3. **曖昧なプロンプト**: 「いい感じに整理」的な指示は暴走する → 「やること」「やらないこと」「迷った時の挙動」を明記

## 他のツールとの比較

| ツール | 強み | 弱み |
|--------|------|------|
| Codex Automations | AI 判断込みの定期タスク | コスト |
| GitHub Actions cron | 無料枠あり・CI/CD と統合 | AI 判断は工夫が必要 |
| Zapier | 7000+ インテグレーション | ノーコード寄り |
| 自作 cron | 完全制御 | 運用コスト高い |

## 関連ページ

- [[wiki/claude-code-routines]] — Claude Code 側の Routines 機能との比較
- [[wiki/claude-code-precompact-hook]] — Claude Code での長時間セッション制御
- [[wiki/claude-code-github-actions]] — GitHub Actions での Claude Code 自動実行
