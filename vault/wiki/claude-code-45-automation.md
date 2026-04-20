---
type: insight
status: []
tags:
  - tool/claude-code
  - ai/agent
sources:
  - "https://zenn.dev/shunya_sudo/articles/claude-code-45-automation-tasks"
created: 2026-04-20
updated: 2026-04-20
---

# Claude Code による 45 タスク自動化：東大院生の全記録

![Claude Code 45タスク自動化](https://res.cloudinary.com/zenn/image/fetch/s--Xdr9h6_H--/c_limit%2Cf_auto%2Cfl_progressive%2Cq_auto%2Cw_1200/https://storage.googleapis.com/zenn-user-upload/deployed-images/9421fbd1d3e648c277fbab1e.png)

東京大学 M2 院生（バイオエンジニアリング専攻）が 6 ヶ月かけて構築した、45 タスクの自動化システムの全記録（2026年4月）。

## システム規模

| 要素 | 数 |
|------|---|
| Cron ジョブ | 45 |
| カスタム AI エージェント | 36 |
| Python スクリプト | 132 |
| 稼働 | 24/7（macOS） |

## 自動化タスクの主要カテゴリ

### 高インパクト：メール処理（最大の時間節約）
- 4 段階の重要度分類
- 返信ドラフト自動生成
- 節約時間：**20-30 分/日**

### スケジュール管理
- ICS URL（OAuth ではなく）で安定性を優先
- 空き時間スロットをドラフト返信に自動挿入

### 研究支援
- 学術論文の日次新着検出 + 関連度スコアリング → Slack 通知
- 会議録音の自動要約（フォルダ監視 → 音声 → テキスト → Slack）

### レポーティング
- git コミット・完了タスク・Cron 実績の日次/週次サマリー自動生成

### AI ニュース収集
- 1 日 3 回の収集・要約・通知

## 設計原則

1. **判断と実行を分離** — AI はドラフトを出す、意思決定は人間
2. **堅牢性 > 洗練さ** — OAuth より ICS URL（単純で壊れない）
3. **Slack をダッシュボード化** — 全通知を 12 チャンネルに集中
4. **小さく始める** — 最初は 5 分スクリプト、徐々に拡張

## コストと効果

- **月次コスト**：約 15,000 円（Claude Code Max サブスクのみ）
- **節約時間**：30-60 分/日
- **本当の価値**：ルーティンワークからの解放によって研究・深い思考に集中できる

## 教訓

個人の AI 自動化においても、**ハーネスエンジニアリングの思想**が有効。個々の AI エージェントを組み合わせたシステム設計（監視、ロールバック、人間確認レイヤー）が長期稼働の鍵。

## 関連ページ

- [[wiki/claude-code-routines]] — Claude Code の公式スケジュール機能
- [[wiki/claude-code-job-queue]] — マネージャー + ワーカー設計パターン
- [[wiki/ai-engineering-harness-era]] — AI エンジニアリングのハーネス時代
- [[wiki/mlx-whisper-video-pipeline]] — 音声→テキスト自動化の類似パイプライン
