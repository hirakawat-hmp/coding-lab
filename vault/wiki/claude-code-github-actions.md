---
type: concept
status: []
tags:
  - tool/claude-code-action
  - infra/ci-cd
  - ai/agent
sources:
  - "https://code.claude.com/docs/en/github-actions"
  - "https://deepwiki.com/anthropics/claude-code-action/1-overview"
  - "https://github.com/anthropics/claude-code-action"
created: 2026-04-10
updated: 2026-04-10
---

# Claude Code GitHub Actions

GitHub ワークフローに Claude AI を統合する公式 Action。PR・Issue への `@claude` メンション、またはスケジュール実行で自動的に動作する。

## 概要

`anthropics/claude-code-action@v1` は Anthropic の Claude Code CLI を GitHub Actions ランナー上で実行するための公式 Action。2025年9月29日に Claude Code 2.0 の一部としてリリースされ、Anthropic の Agent SDK をベースに構築されている。

主な機能:
- PR・Issue への `@claude` メンションに応答してコード変更・実装を行う
- CLAUDE.md のガイドラインに従ってプロジェクト固有のルールを尊重する
- スケジュール実行による自動化タスク（日次レポート、コードレビューなど）

## 実行モード

v1 では **モードの自動検出** が導入され、手動設定が不要になった。旧 beta 版で必要だった `mode: "tag"` や `mode: "agent"` の設定は廃止された。

詳細は [[wiki/claude-code-action-modes]] を参照。

## 基本設定

### 最小構成（Tag Mode）

```yaml
name: Claude Code
on:
  issue_comment:
    types: [created]
  pull_request_review_comment:
    types: [created]
  issues:
    types: [opened, assigned]

jobs:
  claude:
    runs-on: ubuntu-latest
    steps:
      - uses: anthropics/claude-code-action@v1
        with:
          anthropic_api_key: ${{ secrets.ANTHROPIC_API_KEY }}
```

### 自動化構成（Agent Mode）

```yaml
name: Daily Report
on:
  schedule:
    - cron: "0 9 * * *"
jobs:
  report:
    runs-on: ubuntu-latest
    steps:
      - uses: anthropics/claude-code-action@v1
        with:
          anthropic_api_key: ${{ secrets.ANTHROPIC_API_KEY }}
          prompt: "昨日のコミットとオープンな Issue のサマリーを生成して"
          claude_args: "--model claude-opus-4-6"
```

## 主要パラメータ

| パラメータ | 説明 | 必須 |
|---|---|---|
| `prompt` | Claude への指示（省略時は @claude メンションに応答） | No |
| `claude_args` | Claude Code CLI への追加引数 | No |
| `anthropic_api_key` | Claude API キー | Yes* |
| `github_token` | GitHub API アクセストークン | No |
| `trigger_phrase` | カスタムトリガーフレーズ（デフォルト: `@claude`） | No |
| `use_bedrock` | AWS Bedrock を使用する場合 | No |
| `use_vertex` | Google Vertex AI を使用する場合 | No |
| `settings` | JSON 形式の詳細設定 | No |

\*AWS Bedrock や Google Vertex AI 使用時は不要

## セットアップ方法

### クイックセットアップ

Claude Code CLI で `/install-github-app` コマンドを実行するのが最も簡単。

### 手動セットアップ

1. [https://github.com/apps/claude](https://github.com/apps/claude) から Claude GitHub App をインストール
2. `ANTHROPIC_API_KEY` をリポジトリシークレットに追加
3. ワークフローファイルを `.github/workflows/` にコピー

## ベストプラクティス

- **CLAUDE.md**: コーディング規約、レビュー基準、プロジェクト固有ルールを定義する
- **API キー管理**: 必ず GitHub Secrets を使用し、ハードコーディングしない
- **コスト管理**: `--max-turns` で反復回数を制限し、コンカレンシー制御で並列実行を抑制する
- **スコープ制限**: `--allowedTools` で必要最小限のツールのみ許可する

## ツール設定

ツールと権限の詳細設定は [[wiki/claude-code-action-tools]] を参照。

## auto-merge

Claude Code Action は**デフォルトでは PR をマージしない**。ブランチを作成して PR を開くところまでで、マージは人間が行う。

自動マージを実現するには:
1. リポジトリ設定で `Allow auto-merge` を有効化
2. ブランチ保護ルールで必須ステータスチェックを設定
3. ワークフロー内で `gh pr merge --auto --squash "$PR_URL"` を実行

詳細な設計パターン（CI 失敗自動修正 → 自動マージ、Continuous Claude ループ、ラベルベース auto-merge、無限ループ防止など）は [[wiki/claude-code-auto-merge]] を参照。

## 関連ページ

- [[wiki/claude-code-action-modes]] — Tag Mode と Agent Mode の詳細比較
- [[wiki/claude-code-action-tools]] — allowedTools と WebSearch/WebFetch の設定
- [[wiki/claude-code-auto-merge]] — auto-merge 設計パターンと無限ループ防止
- [[wiki/knowledge-vault-lessons]] — 実運用で得た知見とハマりどころ
