---
type: entity
status: []
tags:
  - tool/claude-code
  - infra/ci-cd
sources:
  - "https://code.claude.com/docs/en/routines"
created: 2026-04-15
updated: 2026-04-15
---

# Claude Code Routines

Claude Code の「Routines」機能。プロンプト・リポジトリ・コネクタを保存し、スケジュール・API・GitHub イベントで自動実行する仕組み。研究プレビュー段階（2026年4月時点）。

## 概要

- **定義**: 保存された Claude Code 設定（プロンプト + リポジトリ + コネクタ）
- **実行環境**: Anthropic 管理のクラウドインフラ（ラップトップが閉じていても動く）
- **対象プラン**: Pro / Max / Team / Enterprise（Claude Code on the web 有効化が必要）
- **管理場所**: `claude.ai/code/routines` または CLI の `/schedule`

## トリガー種別

| トリガー | 説明 |
|----------|------|
| **Schedule** | 定期実行（毎時/毎日/平日/毎週、カスタム cron）|
| **API** | HTTP POST でオンデマンド起動、`text` でコンテキスト渡し可 |
| **GitHub** | PR・push・issue・workflow run 等のイベントで起動 |

1 つのルーティンに複数トリガーを組み合わせ可能。

## 主なユースケース

| ユースケース | トリガー | 内容 |
|-------------|---------|------|
| バックログ整理 | Schedule | 毎晩 issue を読んでラベル付け・担当者割り当て |
| アラートトリアージ | API | 監視ツールからアラートを受取り、修正 PR を自動作成 |
| PR レビュー | GitHub | PR オープン時にチェックリスト実行・インラインコメント |
| デプロイ検証 | API | デプロイ後のスモークテスト・エラーログスキャン |
| ドキュメントドリフト検出 | Schedule | 週次で変更 API のドキュメントを自動更新 PR |
| ライブラリポーティング | GitHub | PR マージ時に別言語 SDK へ変更を自動ポート |

## API トリガー呼び出し例

```bash
curl -X POST https://api.anthropic.com/v1/claude_code/routines/trig_xxx/fire \
  -H "Authorization: Bearer sk-ant-oat01-xxxxx" \
  -H "anthropic-beta: experimental-cc-routine-2026-04-01" \
  -H "Content-Type: application/json" \
  -d '{"text": "Sentry alert SEN-4521 fired in prod."}'
```

レスポンス: セッション ID と URL が返る（ブラウザでリアルタイム確認可）。

## GitHub トリガー対応イベント

Pull Request、Push、Release、Issues、Discussions、Check Runs、Workflow Runs、Workflow Dispatch、Repository Dispatch など多数。

PR フィルタ: 著者・タイトル・本文・ベースブランチ・ラベル・draft 状態・フォーク元などで絞り込み可。

## リポジトリとブランチ

- デフォルト: Claude は `claude/` プレフィックスブランチのみ push 可
- **Allow unrestricted branch pushes** を有効にすれば任意ブランチへの push も可

## 制限事項

- 1 ルーティンにつき daily run cap あり（`claude.ai/settings/usage` で確認）
- GitHub イベントには per-routine/per-account の時間当たり上限あり
- `/fire` エンドポイントは `experimental-cc-routine-2026-04-01` beta ヘッダ必須

## 関連ページ

- [[wiki/claude-code-github-actions]] — GitHub Actions での Claude Code 利用（インフラ管理型）
- [[wiki/claude-code-hooks]] — ライフサイクルイベントハンドラ（ローカル実行）
- [[wiki/skill-md-pattern]] — Routines と組み合わせる SKILL.md パターン
