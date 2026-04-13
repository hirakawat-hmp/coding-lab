# coding-lab

コーディング AI 活用の実験場。Claude Code の設定・プラグイン・ナレッジベースを統一管理する。

## 構成

```
coding-lab/
├── vault/                     # 個人ナレッジベース（wiki, raw, Clippings）
├── plugins/
│   ├── vault/                 # vault 操作プラグイン（agents）
│   └── dev-tools/             # 開発支援プラグイン（agents, skills, hooks）
├── config/                    # Claude Code グローバル設定
│   ├── rules/                 # コーディングルール
│   ├── settings.json
│   ├── mcp-servers.json
│   ├── CLAUDE.md
│   └── RTK.md
├── .github/workflows/         # GitHub Actions（vault 探索など）
└── install.sh                 # ~/.claude/ へのシンボリックリンク配置
```

## セットアップ

```bash
./install.sh
```

`~/.claude/` 配下にシンボリックリンクを作成し、MCP サーバーとプラグインを登録する。
