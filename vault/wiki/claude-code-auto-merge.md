---
type: how-to
status: [verified]
tags:
  - tool/claude-code-action
  - infra/ci-cd
  - dev/git
sources:
  - "https://groundy.com/articles/how-to-run-claude-code-as-a-github-actions-agent-for-automated-pr-fixes/"
  - "https://github.com/AnandChowdhary/continuous-claude"
  - "https://docs.github.com/en/pull-requests/collaborating-with-pull-requests/incorporating-changes-from-a-pull-request/automatically-merging-a-pull-request"
  - "https://oneuptime.com/blog/post/2025-12-20-github-actions-auto-merge/view"
created: 2026-04-10
updated: 2026-04-10
---

# Claude Code GitHub Actions: auto-merge 設計パターン

Claude Code GitHub Actions における PR の自動マージ（auto-merge）実装パターン。デフォルトでは Claude はブランチを作成して PR を開くのみで、マージは人間が行う。自動マージには明示的な設定が必要。

## デフォルト動作

`anthropics/claude-code-action@v1` のデフォルト動作:

- Claude は `claude/` プレフィックスのブランチを作成し PR を開く
- **マージは行わない**（保護ブランチへの直接プッシュ禁止）
- 人間がレビュー・承認した後にマージする

自動マージを実現するには、追加設定と GitHub リポジトリ側の設定が必要。

## 前提条件

### GitHub リポジトリ設定

1. **Auto-merge の有効化**: リポジトリの `Settings > General > Pull Requests` で `Allow auto-merge` を有効化
2. **ブランチ保護ルール**: `main` ブランチに保護ルールを設定し、必須ステータスチェックを追加
3. **必要な権限**: ワークフローに `pull-requests: write` 権限が必要

### 必要な GitHub Actions 権限

```yaml
permissions:
  contents: write
  pull-requests: write
  issues: write
```

## パターン1: GitHub ネイティブ auto-merge

GitHub の組み込み auto-merge 機能を使用するパターン。PR を開いた後、`gh pr merge --auto` を呼び出し、全必須チェックが通過したタイミングで自動的にマージされる。

```yaml
name: Claude Auto-Fix and Merge
on:
  workflow_run:
    workflows: ["CI"]
    types: [completed]

jobs:
  auto-fix:
    if: |
      github.event.workflow_run.conclusion == 'failure' &&
      !startsWith(github.event.workflow_run.head_branch, 'claude-auto-fix-ci-')
    runs-on: ubuntu-latest
    permissions:
      contents: write
      pull-requests: write
    steps:
      - uses: actions/checkout@v4
        with:
          ref: ${{ github.event.workflow_run.head_branch }}

      - name: Claude で CI 失敗を修正
        uses: anthropics/claude-code-action@v1
        with:
          anthropic_api_key: ${{ secrets.ANTHROPIC_API_KEY }}
          prompt: "CI が失敗しました。エラーログを確認して修正してください。"
          claude_args: |
            --allowedTools "Bash(git add:*),Bash(git commit:*),Bash(git push:*),Read,Edit,Write"
            --max-turns 10

      - name: auto-merge を有効化
        run: gh pr merge --auto --squash "$PR_URL"
        env:
          GITHUB_TOKEN: ${{ secrets.GITHUB_TOKEN }}
          PR_URL: ${{ github.event.workflow_run.pull_requests[0].url }}
```

**ポイント**: `gh pr merge --auto` は全必須チェックが通過した時点でマージを実行する。現時点では即座にマージはしない。

## パターン2: CI 通過後の直接マージ

CI が通過したことを確認してから `gh pr merge` で即座にマージするパターン。

```yaml
name: Auto-Fix CI and Merge
on:
  workflow_run:
    workflows: ["CI"]
    types: [completed]

jobs:
  auto-fix:
    if: |
      github.event.workflow_run.conclusion == 'failure' &&
      !startsWith(github.event.workflow_run.head_branch, 'claude-auto-fix-ci-')
    runs-on: ubuntu-latest
    permissions:
      contents: write
      pull-requests: write
    steps:
      - uses: actions/checkout@v4

      - name: Claude で CI 失敗を修正・PR 作成
        id: claude
        uses: anthropics/claude-code-action@v1
        with:
          anthropic_api_key: ${{ secrets.ANTHROPIC_API_KEY }}
          prompt: |
            CI が失敗しました。ブランチ名: ${{ github.event.workflow_run.head_branch }}
            エラーを修正し、"claude-auto-fix-ci-" プレフィックスで新しいブランチにプッシュしてください。
          claude_args: |
            --allowedTools "Bash,Read,Edit,Write"
            --max-turns 15

      - name: CI チェック完了まで待機後にマージ
        run: |
          PR_NUMBER=$(gh pr list --head "$BRANCH" --json number --jq '.[0].number')
          gh pr checks "$PR_NUMBER" --watch --interval 30
          gh pr merge "$PR_NUMBER" --squash --delete-branch
        env:
          GITHUB_TOKEN: ${{ secrets.GITHUB_TOKEN }}
          BRANCH: ${{ github.event.workflow_run.head_branch }}
```

## パターン3: Continuous Claude（自律ループ）

[continuous-claude](https://github.com/AnandChowdhary/continuous-claude) パターン。Claude Code が反復的にブランチ作成 → コード変更 → PR 作成 → CI 待機 → マージを繰り返す完全自律型。

```
ループ処理:
1. 新規ブランチ作成
2. Claude Code でコード変更を生成
3. gh pr create で PR を開く
4. gh pr checks でCI 完了を待機
5. CI 成功 → gh pr merge で自動マージ
   CI 失敗 → PR をクローズ、次のイテレーションでリトライ
6. main をプルして繰り返す
```

共有ファイル（`SHARED_TASK_NOTES.md`）でコンテキストを維持し、複数イテレーションにまたがる長期タスクをサポート。

**ループ終了条件**:
- 最大イテレーション数（`--max-runs`）
- コスト上限（`--max-cost`）
- 実行時間上限（`--max-duration`）
- 完了シグナル文字列の連続検出

## パターン4: ラベルベースの選択的 auto-merge

特定ラベルが付いた PR のみを自動マージするパターン。リスクに応じた選択的自動化が可能。

```yaml
name: Label-Based Auto-Merge
on:
  pull_request:
    types: [labeled]

jobs:
  auto-merge:
    if: github.event.label.name == 'auto-merge'
    runs-on: ubuntu-latest
    permissions:
      pull-requests: write
    steps:
      - name: auto-merge を有効化
        run: gh pr merge --auto --squash "$PR_URL"
        env:
          GITHUB_TOKEN: ${{ secrets.GITHUB_TOKEN }}
          PR_URL: ${{ github.event.pull_request.html_url }}
```

Claude が PR を作成した後、人間がラベルを付与することで「承認」代わりに使用できる。

## パターン5: GitHub API 経由の直接マージ（PR なし）

PR を作成せず、Claude が push したブランチを **GitHub API 経由で直接 main にマージ** するパターン。レビューが不要な用途（ドキュメント生成、ナレッジベース更新、日次ダイジェスト等）に適している。

```yaml
- name: Auto-merge Claude's branch
  if: success()
  env:
    GH_TOKEN: ${{ secrets.GITHUB_TOKEN }}
  run: |
    CURRENT_BRANCH=$(git branch --show-current)
    if [ "$CURRENT_BRANCH" != "main" ]; then
      gh api repos/${{ github.repository }}/merges \
        -f base=main \
        -f head="$CURRENT_BRANCH" \
        -f commit_message="auto-merge: $(date +%Y-%m-%d)"
      gh api repos/${{ github.repository }}/git/refs/heads/"$CURRENT_BRANCH" -X DELETE || true
    fi
```

### このパターンの特徴

| 項目 | 説明 |
|---|---|
| PR 作成 | しない。ブランチから main に直接マージ |
| 認証 | `GH_TOKEN` + `gh api` を使用（`git push` の password 認証問題を回避） |
| CI 連携 | なし。Claude の実行成功をそのままマージ条件とする |
| 用途 | レビュー不要な自動更新（ドキュメント、ナレッジ、定期ダイジェスト） |

### なぜ `git push` ではなく `gh api` か

GitHub Actions の `GITHUB_TOKEN` は HTTPS password authentication に対応していないため、`git push origin main` で:

```
remote: Invalid username or token. Password authentication is not supported for Git operations.
fatal: Authentication failed
```

というエラーになる。`gh api` は `GH_TOKEN` を Bearer token として API リクエストに使うため、この制約を回避できる。GitHub の [Merge a branch](https://docs.github.com/en/rest/branches/branches#merge-a-branch) API エンドポイント (`POST /repos/{owner}/{repo}/merges`) を叩くことで、サーバーサイドで直接マージが実行される。

### 適用ケース

- ナレッジベース / wiki の自動更新（本リポジトリの用途）
- 日次レポート / ダイジェストの生成
- RSS フィードからの自動コンテンツ取り込み
- フォーマッタ / リンターの自動修正（ブランチ保護ルールがない場合）

### 注意点

- ブランチ保護ルールが有効な場合は API マージも阻止される
- レビューが必要な変更には使うべきではない
- PR の履歴が残らないため、変更の論理単位を追跡しにくい → コミットメッセージに十分な情報を含める

## 無限ループ防止

Claude の自動修正が再び CI を起動し、その失敗が再度 Claude をトリガーするという無限ループを防ぐ必要がある。

### ブランチ名プレフィックスによるガード

```yaml
# 最も重要なガード
if: |
  github.event.workflow_run.conclusion == 'failure' &&
  !startsWith(github.event.workflow_run.head_branch, 'claude-auto-fix-ci-')
```

Claude の修正ブランチに `claude-auto-fix-ci-` プレフィックスをつけることで、それらのブランチのCI失敗は再トリガーしない。

### コミット作者によるガード

```yaml
if: |
  github.event.pull_request.user.type != 'Bot' &&
  !contains(github.event.head_commit.message, '[claude-auto-fix]')
```

### コンカレンシー制御

同一 PR で複数の Claude ジョブが並列実行されるのを防ぐ:

```yaml
concurrency:
  group: claude-fix-${{ github.event.workflow_run.head_branch }}
  cancel-in-progress: true
```

## セキュリティ考慮事項

### auto-merge すべき PR タイプ

| PR タイプ | 推奨 | 理由 |
|---|---|---|
| 依存関係パッチ更新 | ✅ 適切 | リスク低い |
| CI テスト修正 | ✅ 条件付き | CI が通過すれば安全 |
| コードフォーマット修正 | ✅ 適切 | 機能変更なし |
| 認証・セキュリティ系の変更 | ❌ 要人間レビュー | リスク高い |
| DB マイグレーション | ❌ 要人間レビュー | 不可逆的変更 |
| API 設計変更 | ❌ 要人間レビュー | 影響範囲広い |

### 最小権限の原則

auto-merge ワークフローには必要最小限の権限のみ付与する:

```yaml
permissions:
  contents: write      # ブランチ操作に必要
  pull-requests: write # PR 操作に必要
  # issues: write は不要（auto-merge では）
  # actions: read は不要（CI 確認が不要な場合）
```

### ブランチ保護ルールとの併用

auto-merge を安全に使用するために、必ず以下と組み合わせる:

1. **必須ステータスチェック**: CI が通過しない限りマージ不可
2. **承認要件の緩和**: bot による auto-merge の場合は承認免除設定も可
3. **コードオーナー**: 重要ファイルの変更は人間のレビューを要求

## gh CLI コマンドリファレンス

```bash
# auto-merge を有効化（全必須チェック通過後に自動マージ）
gh pr merge --auto --squash "$PR_URL"
gh pr merge --auto --merge "$PR_URL"
gh pr merge --auto --rebase "$PR_URL"

# CI チェックを待機してから即座にマージ
gh pr checks "$PR_NUMBER" --watch --interval 30
gh pr merge "$PR_NUMBER" --squash --delete-branch

# PR を承認してからマージ（承認が必須の場合）
gh pr review --approve "$PR_URL"
gh pr merge --auto --squash "$PR_URL"
```

## 関連ページ

- [[wiki/claude-code-github-actions]] — GitHub Actions 全体の概要
- [[wiki/claude-code-action-modes]] — Tag Mode と Agent Mode の比較
- [[wiki/claude-code-action-tools]] — allowedTools と WebSearch/WebFetch の設定
- [[wiki/knowledge-vault-lessons]] — 実運用で得た知見（API 経由マージのハマりどころ）
