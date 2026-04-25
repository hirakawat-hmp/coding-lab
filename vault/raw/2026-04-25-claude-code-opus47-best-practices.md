# Opus 4.7 でやめるべき Claude Code の使い方 6選

source: https://qiita.com/ot12/items/06420caf41a34a910c53
fetched: 2026-04-25

## 要点

- Anthropic が 2026年4月16日に Claude Opus 4.7 をリリース
- 同日 Claude Code 作者 Boris Cherney が X（Twitter）で6つの新ベストプラクティスを発表
- 「4.6 までの使い方は 4.7 では廃止」という統一メッセージ

## 6つの「やめるべき」こと

1. **ペアプロ的な細かい指示**
   → 初回プロンプトで「目的/制約/完了条件」を包括的に指定し、途中介入を減らす

2. **Effort Level を max に常用**
   → 推奨デフォルトは xhigh。max は「考えすぎ」で逆効果になる場合がある

3. **`--dangerously-skip-permissions` の常用**
   → Auto Mode や Fewer-permission-prompts で安全に代替

4. **長時間セッションの横付き見守り**
   → Focus Mode（結果のみ表示）や Recaps（自動サマリー）を活用

5. **Subagent を毎回呼び出す**
   → 必要なのは「複数ファイル並列作業」「独立タスク」のみ。自動判断に任せる

6. **検証機構なしで任せる**
   → テスト・スクリーンショット・期待出力を用意し Claude 自身が検証できる構成に

## 実務チェックリスト

- Claude Code v2.1.111 以上に更新
- Effort を xhigh に設定
- 初回プロンプトを構造化（Goal / Constraints / Acceptance criteria）
- Stop Hook でテスト検証を組み込む
- `/fewer-permission-prompts` で許可リストを整理
