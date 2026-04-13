# coding-lab

コーディング AI 活用の実験場。Claude Code の設定・プラグイン・ナレッジベースを統一管理する。

## 構成

```
coding-lab/
├── vault/                     # 個人ナレッジベース（Obsidian vault）
│   ├── wiki/                  # LLM 生成・保守のページ
│   ├── newsletters/           # 日次ダイジェスト
│   ├── raw/                   # 元ソース（immutable）
│   ├── assets/                # 画像等
│   ├── tags.md                # Tag Library（正典）
│   ├── index.md               # 全ページカタログ
│   └── log.md                 # 操作ログ
├── plugins/
│   ├── vault/                 # vault 操作プラグイン
│   │   ├── agents/            # vault-researcher
│   │   ├── skills/            # vault-ingest, vault-lint, vault-list, vault-tags
│   │   ├── scripts/           # vault-cli.py, check-pending.sh, setup-qmd.sh
│   │   └── config/            # feeds.yml
│   ├── dev-tools/             # 開発支援プラグイン
│   │   ├── agents/            # code-reviewer, security-reviewer 等
│   │   └── hooks/             # rtk-rewrite
│   └── external/              # 外部スキル（manifest.yml で管理、中身は gitignore）
├── config/                    # Claude Code グローバル設定
│   ├── rules/                 # コーディングルール
│   ├── output-styles/         # 応答スタイル定義
│   ├── settings.json
│   ├── mcp-servers.json
│   └── CLAUDE.md
├── scripts/
│   └── external.sh            # 外部スキル管理（add/remove/update/list）
├── .github/workflows/         # GitHub Actions
│   ├── daily-digest.yml       # RSS 日次巡回
│   ├── research.yml           # Issue 駆動リサーチ
│   ├── lint.yml               # 週次 vault lint
│   ├── claude.yml             # Claude PR Assistant
│   └── claude-code-review.yml # Claude Code Review
└── install.sh                 # ~/.claude/ へのシンボリックリンク配置
```

## セットアップ

```bash
./install.sh
```

`~/.claude/` 配下にシンボリックリンクを作成し、MCP サーバーとマーケットプレイスを登録する。

## 外部スキル管理

```bash
./scripts/external.sh add owner/repo          # GitHub から追加
./scripts/external.sh remove name             # 削除
./scripts/external.sh update                  # 全件更新
./scripts/external.sh list                    # 一覧
```

install.sh 実行後に外部スキルを復元するには:

```bash
./scripts/external.sh update && ./scripts/external.sh link
```
