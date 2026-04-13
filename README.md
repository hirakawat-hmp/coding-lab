# coding-lab

コーディング AI 活用の実験場。Claude Code の設定・プラグイン・ナレッジベースを統一管理する。

## 構成

```
coding-lab/
├── vault/                     # 個人ナレッジベース（Obsidian vault）
│   ├── wiki/                  # LLM 生成・保守のページ
│   ├── newsletters/           # 日次ダイジェスト
│   ├── raw/                   # 元ソース（immutable）
│   ���── assets/                # 画像等
│   ├── tags.md                # Tag Library（正典）
│   ├── index.md               # 全ページカタログ
│   └── log.md                 # 操作��グ
├── plugins/
│   ��── vault/                 # vault 操作プラグイン
│   │   ├── agents/            # vault-researcher
│   │   ├── skills/            # vault-ingest, vault-lint, vault-list, vault-tags
│   │   ├── scripts/           # vault-cli.py, check-pending.sh, setup-qmd.sh
│   │   └── config/            # feeds.yml
│   └── dev-tools/             # 開発支援プラグイ���
│       ├── agents/            # code-reviewer, security-reviewer 等
│       ├── skills/            # drawio, pptx, tdd 等
│       └── hooks/             # block-dangerous, rtk-rewrite
├── config/                    # Claude Code グローバル設定
│   ├── rules/                 # コーディングルール
│   ├── settings.json
│   ├── mcp-servers.json
│   ├── CLAUDE.md
│   └── RTK.md
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

`~/.claude/` 配下にシンボリック��ンクを作成し、MCP サーバーとプラグインを登録する。
