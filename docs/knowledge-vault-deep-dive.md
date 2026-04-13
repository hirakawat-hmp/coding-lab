# Knowledge Vault Deep Dive

> Context: ~/repos/knowledge-vault/ のアーキテクチャ調査。coding-lab/vault/ との差分にも注目。
> 調査日: 2026-04-13

---

## 1. リポジトリ全体構成

```
knowledge-vault/
├── .claude-plugin/plugin.json   # Claude Code Plugin 定義
├── .github/workflows/           # GitHub Actions (3本)
│   ├── daily-digest.yml         # RSS 日次巡回
│   ├── lint.yml                 # 週次 vault lint
│   └── research.yml             # Issue 駆動リサーチ
├── .mcp.json                    # qmd MCP サーバー設定
├── CLAUDE.md                    # vault 運用ルール (244行)
├── agents/
│   └── vault-researcher.md      # qmd 検索 + WebSearch エージェント
├── config/
│   └── feeds.yml                # RSS フィード定義 (6フィード)
├── hooks/
│   └── hooks.json               # 空オブジェクト {} (未使用)
├── raw/                         # 元ソース (immutable, 12ファイル)
├── scripts/
│   ├── check-pending.sh         # Clippings 未処理検出
│   ├── setup-qmd.sh             # qmd collection 登録
│   └── vault-cli.py             # Python CLI (506行, uv script)
├── skills/                      # Claude Code Skills (4つ)
│   ├── vault-ingest/SKILL.md
│   ├── vault-lint/SKILL.md
│   ├── vault-list/SKILL.md
│   └── vault-tags/SKILL.md
└── vault/                       # Obsidian vault パス
    ├── assets/                  # 画像 (空)
    ├── index.md                 # type 別カタログ (54ページ)
    ├── log.md                   # 操作ログ (append-only)
    ├── newsletters/             # 日次ニュースレター
    │   └── 2026-04-10.md
    ├── tags.md                  # Tag Library (正典)
    └── wiki/                    # LLM 生成 wiki (54ファイル)
```

規模: 79ファイル, 約8,500行 (Markdown中心, Python 506行)

---

## 2. CLAUDE.md の指示体系

CLAUDE.md (244行) はこのリポジトリの中核。Claude Code Action が実行時に自動読み込みする設計指示書。

### 主要な規約

| 項目 | ルール |
|------|--------|
| 言語 | wiki コンテンツは日本語、ファイル名は英語 kebab-case |
| Frontmatter | `type` (必須/単一), `status` (必須/配列), `tags` (必須/配列), `sources`, `created`, `updated` |
| Type | 10種: entity, concept, how-to, reference, insight, comparison, decision, troubleshooting, idea, meta |
| Tags | 階層構造 (`ai/llm`, `infra/gcp` 等), `vault/tags.md` に正典定義 |
| raw/ | immutable (一度保存したら変更しない) |
| 検索設計 | ベクトル検索ではなく "agentic search" (type/tag/パスによる明示的探索) |

### Agentic Search の設計思想

RAG (ベクトル検索) を採用せず、エージェントが tags.md → index.md → wiki ページという経路で明示的に探索する設計:

```
CLAUDE.md より:
> vault は埋め込みベースの RAG ではなく、agent がパスとタグを指定して明示的に探索する設計を採用している。
```

手順: tags.md で語彙把握 → type/tag でフィルタ → index.md で候補選定 → Read でページ読み込み → `[[wiki/X]]` リンクで関連ページへ遷移

ただし qmd MCP も `.mcp.json` で設定済みなので、ベクトル検索も補助的に利用可能。

---

## 3. GitHub Actions ワークフロー (3本)

### 3.1 daily-digest.yml — RSS 日次巡回

```yaml
on:
  schedule:
    - cron: '0 0 * * *'  # 00:00 UTC = 09:00 JST
  workflow_dispatch: {}
```

- `anthropics/claude-code-action@v1` を Agent Mode で実行
- `config/feeds.yml` の 6 フィードを巡回
- 直近 24 時間の記事を最大 20 件選別
- 各記事: WebFetch → raw/ 保存 → wiki/ ページ作成 → newsletter 作成
- **auto-merge パターン**: Claude のブランチを GitHub API (`gh api repos/.../merges`) で直接 main にマージ、ブランチ削除

重要な設計判断: `git push` ではなく `gh api` を使うのは、GITHUB_TOKEN が HTTPS password authentication に非対応なため (knowledge-vault-lessons.md 問題2)。

### 3.2 research.yml — Issue 駆動リサーチ

```yaml
on:
  issue_comment:
    types: [created]
  issues:
    types: [opened]
```

- `@claude` メンションで起動 (Tag Mode)
- **`prompt` を指定しない** のが重要。prompt を書くと Agent Mode になり Issue コンテキストが渡されない
- 無限ループ防止: `github.event.comment.user.type != 'Bot'` で Claude 自身のトラッキングコメントを除外
- `concurrency: { group: vault-update, cancel-in-progress: false }` で排他制御

### 3.3 lint.yml — 週次 vault lint

```yaml
on:
  schedule:
    - cron: '0 0 * * 0'  # 毎週日曜 09:00 JST
  workflow_dispatch: {}
```

- Agent Mode (`prompt` あり)
- `scripts/vault-cli.py lint` を先に実行して機械的チェック → Claude が修正
- WebSearch/WebFetch は不要なので許可していない

### 共通パターン

3 ワークフロー全てに共通する設計:

```yaml
# 排他制御
concurrency:
  group: vault-update
  cancel-in-progress: false

# 権限
permissions:
  contents: write
  id-token: write  # OAuth OIDC に必須

# ツール許可 (二重指定が確実)
settings: |
  { "permissions": { "allow": ["Bash", "WebSearch", "WebFetch", "Read", "Write", "Edit"] } }
claude_args: '--allowedTools "Bash,WebSearch,WebFetch,Read,Write,Edit"'

# Auto-merge (git push ではなく GitHub API)
gh api repos/${{ github.repository }}/merges \
  -f base=main -f head="$CURRENT_BRANCH" ...
```

---

## 4. config/feeds.yml — RSS フィード設定

```yaml
feeds:
  tech:
    - name: "Hacker News (Top)"
      url: "https://hnrss.org/frontpage"
    - name: "Publickey"
      url: "https://www.publickey1.jp/atom.xml"
    - name: "Zenn Trending"
      url: "https://zenn.dev/feed"
  ai:
    - name: "Anthropic Blog"
    - name: "OpenAI Blog"
  cloud:
    - name: "Google Cloud Blog"

settings:
  max_articles_per_feed: 5
  max_total_articles: 20
  lookback_hours: 24
```

6 フィード、3 カテゴリ (tech/ai/cloud)。設定値は CLAUDE.md の prompt 内で Claude に渡されるだけで、プログラム的にパースするコードはない (Claude が WebFetch で直接 RSS を取得する設計)。

---

## 5. scripts/ — CLI ツール群

### vault-cli.py (506行, Python/uv)

`uv run` シバンスクリプト。依存: pyyaml, click, rich。

4 サブコマンド:

| コマンド | 機能 |
|----------|------|
| `list` | type/tag/status フィルタで wiki ページ一覧。AND/OR/除外対応 |
| `tags` | tags.md の内容表示 |
| `show` | 指定ページの全文表示 |
| `lint` | 健全性チェック (5項目) |

lint チェック項目:
1. **壊れたリンク**: `[[wiki/X]]` のリンク先が存在しない
2. **孤立ページ**: wiki/newsletters/index.md のいずれからもリンクされていない
3. **未登録ページ**: index.md に記載がない
4. **スキーマ違反**: type 未定義、status が配列でない、tags が配列でない、不明な type
5. **未登録タグ**: tags.md に定義されていないドメインタグ

フィルタ文法の実装が秀逸:

```python
# parse_clauses: "type:concept tag:ai/llm,ai/agent -tag:project/aaip"
# → Clause(field='type', values=['concept'], exclude=False)
#   Clause(field='tag', values=['ai/llm','ai/agent'], exclude=False)
#   Clause(field='tag', values=['project/aaip'], exclude=True)
# フィールド間 AND、同フィールド内 OR、- プレフィックスで除外
```

### check-pending.sh

`vault/Clippings/` 内の `status: pending` ファイルを検出。SKILL.md の `!` 構文で実行時に結果が埋め込まれる。

### setup-qmd.sh

qmd に `knowledge-vault` collection を登録し、埋め込みを生成。ローカル開発時のセットアップ用。

---

## 6. skills/ — Claude Code Skills (4つ)

Claude Code Plugin のスキル定義。`/vault-xxx` としてスラッシュコマンドで呼び出し可能。

| Skill | 用途 | 特徴 |
|-------|------|------|
| `vault-ingest` | ソース取り込み | URL/ファイル/トピック名を引数に取る。引数なしなら Clippings 全件処理。`!` 構文で check-pending.sh の結果を動的埋め込み |
| `vault-lint` | 健全性チェック | `!` 構文で vault-cli.py lint の結果を動的埋め込み。7項目のチェック指示 |
| `vault-list` | ページ検索 | vault-cli.py list を実行。結果を見て Read で詳細取得する2段階設計 |
| `vault-tags` | タグ一覧 | vault-cli.py tags を実行 |

注目すべきパターン: SKILL.md 内の `!` 構文:

```markdown
## 機械的チェック結果

!`uv run ${CLAUDE_PLUGIN_ROOT}/scripts/vault-cli.py lint`
```

これにより skill 呼び出し時にスクリプトが実行され、結果が prompt に動的に埋め込まれる。

---

## 7. agents/ — vault-researcher

```yaml
name: vault-researcher
model: sonnet
tools: [Read, Write, Edit, Grep, Glob, WebFetch, WebSearch, mcp__qmd__query, mcp__qmd__get, mcp__qmd__multi_get]
```

他プロジェクトから呼び出される subagent。qmd MCP で vault を検索し、関連知識がなければ WebSearch で調査して vault に追記する。`${CLAUDE_PLUGIN_ROOT}` 変数で vault パスを解決。

---

## 8. hooks/ — 未使用

`hooks.json` は空オブジェクト `{}`。現時点では Claude Code Hooks は未実装。将来的にはコミット前の lint 自動実行などが想定される。

---

## 9. .claude-plugin と .mcp.json

### .claude-plugin/plugin.json

```json
{
  "name": "knowledge-vault",
  "version": "1.0.0",
  "description": "Personal knowledge base with automated ingest, lint, and autonomous research.",
  "skills": "./skills/",
  "agents": "./agents/"
}
```

このリポジトリ自体が Claude Code Plugin として機能する。他プロジェクトから `vault-researcher` エージェントや `/vault-xxx` スキルを利用可能。

### .mcp.json

```json
{
  "mcpServers": {
    "qmd": { "command": "qmd", "args": ["mcp"] }
  }
}
```

qmd MCP サーバーをローカルプロセスとして起動。vault-researcher エージェントがセマンティック検索に利用。

---

## 10. vault/ 配下の構造

### wiki/ (54ページ)

type 別分布:
- Entity: 22 (ツール・サービス・モデルの辞書ページ)
- Concept: 17 (技術概念、設計パターン)
- How-to: 3 (手順書)
- Reference: 3 (仕様リファレンス)
- Insight: 6 (横断的学び)
- Comparison: 3 (比較)
- Decision/Troubleshooting/Idea: 0 (未使用)

### tags.md — Tag Library

正典 (canonical source)。新規タグは必ずここに先に登録してから使う。

ドメインタグ階層:
- `ai/` (llm, agent, rag, eval, prompt-engineering, video-gen, audio-gen, image-gen, computer-vision)
- `media/` (3d)
- `infra/` (gcp, aws, k8s, ci-cd, docker)
- `dev/` (typescript, python, rust, bash, git, markdown)
- `km/` (vault, obsidian, markdown)
- `tool/` (claude-code, claude-code-action, qmd, pptxgenjs, etc.)
- `framework/` (mastra, adk)
- `stats/` (bayesian, mmm, optimization)
- `design/` (system)
- `ui/` (components, visualization)
- `project/` (knowledge-vault, aaas-ai-planner)

### newsletters/ (1ファイル)

`2026-04-10.md` — Claude Code GitHub Actions 調査 + fujito 記事まとめ。同日に複数のリサーチが実行された場合は追記される設計。

### index.md

type 別カタログ。全ページが `- [[wiki/ページ名]] -- 一行要約` 形式で登録される。lint で未登録ページを検出。

### log.md

append-only の操作ログ。operation type: research, digest, update, init, migrate。

---

## 11. coding-lab/vault/ との差分

### coding-lab/vault/ (旧)

- Obsidian Web Clipper 経由の `Clippings/` が主フロー
- tags は flat (`source`, `entity`, `concept`, `insight`, `comparison`)
- Frontmatter: `tags` + `sources` + `created` + `updated` のみ
- `type` フィールドなし
- `status` フィールドなし (Clippings の pending/ingested のみ)
- GitHub Actions なし (手動 ingest)
- CLI ツールなし
- 37 wiki ページ, 12 raw ファイル

### knowledge-vault/ (新) で追加・改善された点

| 領域 | 旧 (coding-lab/vault/) | 新 (knowledge-vault/) |
|------|------------------------|----------------------|
| **Frontmatter** | tags のみ | type + status[] + tags[] (3層スキーマ) |
| **Tags** | flat 5種 | 階層構造 11カテゴリ 40+ タグ |
| **Status** | なし | Lifecycle / Quality / Freshness の3カテゴリ |
| **自動化** | なし | GitHub Actions 3本 (daily-digest, research, lint) |
| **CLI** | なし | Python CLI (list/tags/lint/show) |
| **Skills** | なし | 4 skills (ingest/lint/list/tags) |
| **Agent** | なし | vault-researcher subagent |
| **Plugin** | なし | .claude-plugin で他プロジェクトから利用可能 |
| **検索設計** | qmd のみ | Agentic Search (type/tag 明示的探索) + qmd 補助 |
| **Newsletter** | なし | 日次ダイジェスト (newsletters/) |
| **Auto-merge** | なし | GitHub API 経由 (PR なし直接マージ) |
| **Lint** | なし | 5項目の自動チェック + 週次実行 |
| **Tag Library** | なし | tags.md が正典、lint で整合性検証 |
| **ページ数** | 37 wiki | 54 wiki (旧36ページ移行 + 新18ページ) |

本質的な違いは **手動 vault → 自動運用 vault** への進化。GitHub Actions + Claude Code Action で RSS 巡回・Issue リサーチ・lint が全自動化され、人間は Issue にコメントするだけでナレッジが蓄積される。

---

## 12. トレードオフと限界

### うまくいっている点

1. **Auto-merge の GitHub API パターン**: `git push` の認証問題を回避しつつ、PR なしで直接マージする軽量な設計
2. **Tag Mode / Agent Mode の使い分け**: research.yml は Tag Mode (Issue コンテキスト自動注入)、daily-digest.yml と lint.yml は Agent Mode (prompt 指定) と適切に分離
3. **Concurrency group `vault-update`**: 3 ワークフロー全てが同一グループで排他制御されており、同時書き込みの競合を防止
4. **SKILL.md の `!` 構文**: スクリプト実行結果を prompt に動的埋め込みする手法が効果的
5. **tags.md を正典とした lint 統合**: タグの表記ゆれや不整合を自動検出

### 限界・未解決の課題

1. **daily-digest が一度も成功した形跡がない**: newsletters/ には 2026-04-10.md しかなく、これは research ワークフローの成果。RSS 巡回の実績がない
2. **hooks.json が空**: Claude Code Hooks は未活用。ローカルでの pre-commit lint 等に使える余地がある
3. **vault/assets/ が空**: 画像等のアセット管理は未着手
4. **Auto-merge に PR がない**: ブランチ → main 直接マージのため、変更のレビュー機会がない。CI チェックも挟まない
5. **RSS フィード数が少ない**: 6 フィードでカバー範囲が限定的
6. **Decision/Troubleshooting/Idea の type が未使用**: スキーマは定義されているが該当ページが 0
7. **feeds.yml がプログラム的にパースされない**: Claude が prompt 内の指示に従って手動で読む設計のため、フィード追加時の検証がない

### アーキテクチャ判断

| 判断 | 理由 | 結果 |
|------|------|------|
| Agentic Search > RAG | type/tag による明示的探索の方が LLM に予測可能 | tags.md + index.md のメンテナンスコストが発生 |
| PR なし直接マージ | 自動化の速度優先、レビュー不要なコンテンツ | 品質ゲートが lint のみ |
| `settings` + `claude_args` 二重指定 | どちらか片方では効かないケースがある | 冗長だが確実 |
| Python uv script | 依存管理不要、単一ファイルで完結 | uv が CI に入っていない (ローカル専用) |
| Claude Code Plugin | 他プロジェクトから vault を参照可能に | Plugin システムの仕様への依存 |

---

## 13. ファイルリファレンス

| パス | 行数 | 役割 |
|------|------|------|
| `CLAUDE.md` | 244 | vault 運用ルール・全ワークフロー指示 |
| `scripts/vault-cli.py` | 506 | CLI (list/tags/lint/show) |
| `.github/workflows/daily-digest.yml` | 72 | RSS 日次巡回 |
| `.github/workflows/research.yml` | 60 | Issue 駆動リサーチ |
| `.github/workflows/lint.yml` | 67 | 週次 vault lint |
| `vault/tags.md` | 243 | Tag Library (正典) |
| `vault/wiki/knowledge-vault-lessons.md` | 181 | 実運用で得たハマりどころ5件 |
| `skills/vault-ingest/SKILL.md` | 82 | Ingest スキル定義 |
| `agents/vault-researcher.md` | 88 | qmd + WebSearch エージェント |
