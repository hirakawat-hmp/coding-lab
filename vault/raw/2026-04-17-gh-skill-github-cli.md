# gh skill — GitHub 公式の AI エージェントスキル管理ツール

**Source:** https://zenn.dev/ubie_dev/articles/gh-skill-install-agent-skills
**Fetched:** 2026-04-18
**Published:** 2026-04-17

## 概要

GitHub が 2026-04-16 に `gh skill` を公式 CLI サブコマンドとしてリリース。
AI エージェントスキルを管理するための公式ツール。著者は `npx skills` からの乗り換えを報告。

## 5つのコマンド

- **search:** GitHub 上の公開スキルを検索
- **preview:** インストール前に `SKILL.md` 内容を確認
- **install:** スキルをエージェント固有のディレクトリにローカル配置（例: `~/.claude/skills/`）
- **update:** インストール済みスキルを最新版に更新
- **publish:** agentskills.io 規格に準拠したスキル公開・バリデーション

## セキュリティ機能

- **不変リリースとバージョン固定（`--pin` フラグ）:** スキルは AI への命令書そのもの。タグ保護とバージョンロックで不正改ざんを防止
- **来歴メタデータ:** `SKILL.md` frontmatter にリポジトリ URL・git ref・Tree SHA ハッシュを埋め込み
- **サプライチェーン保護:** タグ保護ルール、シークレットスキャン、コード脆弱性分析

## npx skills との違い

- 公式 CLI で supply chain 攻撃リスクが低い
- バージョン管理・整合性検証が内蔵
- エージェント固有ディレクトリへのインストール（共有場所を汚染しない）
