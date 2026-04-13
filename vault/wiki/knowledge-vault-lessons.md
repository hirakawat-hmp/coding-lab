---
type: insight
status: []
tags:
  - km/vault
  - tool/claude-code-action
  - infra/ci-cd
sources:
  - "自身の運用経験（2026-04-10）"
  - "[[wiki/claude-code-github-actions]]"
  - "[[wiki/claude-code-action-modes]]"
  - "[[wiki/claude-code-action-tools]]"
  - "[[wiki/claude-code-auto-merge]]"
created: 2026-04-10
updated: 2026-04-10
---

# Knowledge Vault 構築で得た知見

`knowledge-vault` リポジトリに Claude Code GitHub Actions を組み込む過程で遭遇した問題と解決策の記録。公式ドキュメントだけでは見えない運用上のハマりどころを整理する。

## 問題1: tag mode での WebSearch/WebFetch が有効化されない

### 症状

`claude_args: '--allowedTools Bash WebSearch WebFetch'` と指定しても、実行時のログで `DISALLOWED_TOOLS: WebSearch,WebFetch` と表示され、Web ツールが使えなかった。

### 原因

Tag mode では Claude Code Action が内部で `tagModeTools` という許可リストを組み立て、その中に `Bash` は `Bash(git add:*)` 等の制限パターンしか含まれない。また Claude Code CLI のヘッドレスモードはデフォルトで WebSearch/WebFetch を無効化している。`--allowedTools` は許可リストに追加するだけで、無効化リストを上書きしない。

### 解決策

`settings` 入力で `permissions.allow` に明示的に指定する必要がある:

```yaml
- uses: anthropics/claude-code-action@v1
  with:
    claude_code_oauth_token: ${{ secrets.CLAUDE_CODE_OAUTH_TOKEN }}
    settings: |
      {
        "permissions": {
          "allow": ["Bash", "WebSearch", "WebFetch", "Read", "Write", "Edit"]
        }
      }
    claude_args: '--allowedTools "Bash,WebSearch,WebFetch,Read,Write,Edit"'
```

`settings` は CLI 側に直接許可を伝え、`claude_args` は SDK 側にも冗長に伝える。両方書くのが確実。

詳細: [[wiki/claude-code-action-tools]]

## 問題2: auto-merge の `git push` が認証エラー

### 症状

カスタムの auto-merge ステップで `git push origin main` を実行すると:

```
remote: Invalid username or token. Password authentication is not supported for Git operations.
fatal: Authentication failed
```

### 原因

GitHub Actions の `GITHUB_TOKEN` は HTTPS password authentication に対応していない。`actions/checkout` の `persist-credentials` を信用して `git push` するパターンは、パスワード認証が使えないため失敗する。

### 解決策

`git push` ではなく **GitHub API（`gh api`）** 経由でマージする:

```yaml
- name: Auto-merge Claude's branch
  env:
    GH_TOKEN: ${{ secrets.GITHUB_TOKEN }}
  run: |
    gh api repos/${{ github.repository }}/merges \
      -f base=main \
      -f head="$CURRENT_BRANCH" \
      -f commit_message="auto-merge: ..."
    gh api repos/${{ github.repository }}/git/refs/heads/"$CURRENT_BRANCH" -X DELETE || true
```

`gh api` は `GITHUB_TOKEN` を Bearer token として使うので password 認証の問題を回避できる。PR を作らずブランチから直接 main にマージする「無 PR フロー」が実現できる。

詳細: [[wiki/claude-code-auto-merge]] のパターン5

## 問題3: Claude のトラッキングコメントが無限ループを引き起こす

### 症状

Issue に `@claude` でコメントすると、Claude Code Action が自動的にトラッキングコメント（`**Claude finished in 5m 20s** ...`）を Issue に投稿する。このコメント本文の中に `@claude` という文字列が含まれており、`issue_comment` イベントをトリガーして別のワークフロー実行が走ってしまう。

### 原因

ワークフローの `if` 条件が `contains(github.event.comment.body, '@claude')` だけで、**コメントの投稿者** をチェックしていなかった。

### 解決策

`user.type != 'Bot'` フィルタを追加して、bot のコメントを除外する:

```yaml
if: |
  (github.event_name == 'issues' && contains(github.event.issue.body, '@claude') && github.event.issue.user.type != 'Bot') ||
  (github.event_name == 'issue_comment' && contains(github.event.comment.body, '@claude') && github.event.comment.user.type != 'Bot')
```

これで `claude[bot]` が投稿したコメントは無視される。`concurrency` 設定と併用すると、仮に bot のコメントでトリガーされても重複実行は防がれる。

## 問題4: `prompt` 指定で tag mode の恩恵を失う

### 症状

Issue コメントで `@claude 調査して` と依頼しても、Claude が Issue の本文や過去コメントを参照できず、「何を調査すればいいか分からない」状態になった。

### 原因

ワークフローで `prompt` 入力を指定していたため、Claude Code Action は **agent mode** に切り替わっていた。Agent mode では Issue の body やコメントが自動で Claude に渡されない。Tag mode（`prompt` なし）であれば自動的に全コンテキストが注入される。

### 解決策

Issue/コメント駆動のリサーチ用途では `prompt` を **書かない**。CLAUDE.md にリサーチ手順を書いておけば、Claude はそれを参照しつつ Issue の内容を処理する。

```yaml
# NG: prompt を書くと agent mode になり Issue コンテキストが消える
- uses: anthropics/claude-code-action@v1
  with:
    prompt: "Issue の内容を調査してください"  # ← 書かない

# OK: tag mode で Issue の全コンテキストが自動で渡る
- uses: anthropics/claude-code-action@v1
  with:
    claude_code_oauth_token: ${{ secrets.CLAUDE_CODE_OAUTH_TOKEN }}
    settings: | ...
```

詳細: [[wiki/claude-code-action-modes]]

## 問題5: `id-token: write` がないと OAuth 認証が失敗

### 症状

`claude_code_oauth_token` を使う構成にしたら、初回実行で以下のエラー:

```
Could not fetch an OIDC token. Did you remember to add `id-token: write` to your workflow permissions?
```

### 原因

OAuth トークンは GitHub の OIDC プロバイダ経由で検証される。ワークフローに `id-token: write` 権限がないと、OIDC トークンが取得できず認証が失敗する。

### 解決策

全ワークフローの `permissions` に `id-token: write` を追加:

```yaml
permissions:
  contents: write
  issues: write
  pull-requests: write
  id-token: write  # OAuth 認証に必須
```

`anthropic_api_key` を使う場合は不要だが、`claude_code_oauth_token`（Claude subscription 連携）を使う場合は必須。

## 得られた教訓

1. **公式ドキュメントを鵜呑みにしない**: `--allowedTools` の説明だけ読むと動きそうに見えるが、tag mode の制約や CLI のデフォルト設定が干渉する
2. **`settings` と `claude_args` の両方に書く**: どちらか片方では効かないケースがある
3. **bot フィルタは必須**: Claude 自身のコメントが無限ループを起こす前提で設計する
4. **GitHub API を活用する**: `git push` より `gh api` の方が認証周りでトラブルが少ない
5. **Tag mode と agent mode の違いを意識する**: `prompt` の有無で挙動が完全に変わる

## 関連ページ

- [[wiki/claude-code-github-actions]] — GitHub Actions 全体の概要
- [[wiki/claude-code-action-modes]] — Tag Mode と Agent Mode の比較
- [[wiki/claude-code-action-tools]] — allowedTools と WebSearch/WebFetch の設定
- [[wiki/claude-code-auto-merge]] — auto-merge 設計パターン
