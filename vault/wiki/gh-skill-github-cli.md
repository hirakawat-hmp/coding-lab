---
type: entity
status: []
tags:
  - tool/gh-cli
  - tool/claude-code
  - ai/agent
sources:
  - "https://zenn.dev/ubie_dev/articles/gh-skill-install-agent-skills"
created: 2026-04-18
updated: 2026-04-18
---

# gh skill — GitHub 公式 AI エージェントスキル管理ツール

2026年4月16日に GitHub がリリースした公式 CLI サブコマンド。
AI エージェントスキル（SKILL.md）のインストール・更新・公開を管理する。

## 5つのサブコマンド

| コマンド | 説明 |
|---------|------|
| `gh skill search` | GitHub 上の公開スキルを検索 |
| `gh skill preview` | インストール前に SKILL.md の内容を確認 |
| `gh skill install` | エージェント固有ディレクトリにスキルをインストール |
| `gh skill update` | インストール済みスキルを最新版に更新 |
| `gh skill publish` | agentskills.io 規格に準拠したスキル公開 |

## インストール先

```
~/.claude/skills/    # Claude Code 向け
~/.copilot/skills/   # GitHub Copilot 向け
```

エージェント固有ディレクトリへインストールすることで、共有場所を汚染しない。

## セキュリティ機能

### 不変リリースとバージョン固定

```bash
# バージョン固定インストール
gh skill install owner/repo-name --pin v1.2.0
```

「スキルは AI への命令書そのもの」——不正改ざんはエージェントの動作を完全に変える可能性があるため、
タグ保護とバージョンロックが重要。

### 来歴メタデータ

インストールされた SKILL.md の frontmatter に自動埋め込み：
```yaml
source_repo: "https://github.com/owner/repo"
git_ref: "v1.2.0"
tree_sha: "abc123..."
```

### サプライチェーン保護

- リポジトリ側：タグ保護ルール、シークレットスキャン、コード脆弱性分析
- npx skills と比較して supply chain 攻撃リスクが大幅に低い

## npx skills との違い

| 項目 | `npx skills` | `gh skill` |
|------|-------------|------------|
| 公式サポート | ❌ | ✅ |
| バージョン管理 | 限定的 | ✅ 固定・整合性検証 |
| 来歴追跡 | ❌ | ✅ Tree SHA |
| 配置場所 | 共有 | エージェント固有 |

## 関連ページ

- [[wiki/skill-md-pattern]] — SKILL.md パターンの概要
- [[wiki/claude-code-harness-patterns]] — Claude Code ハーネスとスキルの関係
- [[wiki/security-agent-harness]] — サプライチェーンリスクのある環境でのエージェント設計
