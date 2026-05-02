---
type: concept
status: []
tags:
  - tool/claude-code
  - ai/agent
  - ai/prompt-engineering
sources:
  - "https://qiita.com/ennagara128/items/c25e72eb240611454457"
created: 2026-05-02
updated: 2026-05-02
---

# Claude Code 3層設計パターン（CLAUDE.md / Skills / Agents）

Claude Code の設定ファイル肥大化問題を解決する「3層分離設計パターン」。責務を明確に分離することで、メンテナビリティと拡張性を高める。

## なぜ3層に分けるか

単一の CLAUDE.md にすべてを詰め込むと：
- 800行を超える「読まれない設定ファイル」になる
- ルール間の優先順位が曖昧になる
- 並列実行できるタスクが直列化される

## 3層モデル

### 層1：基盤層（CLAUDE.md）

**役割:** プロジェクト全体で常に適用すべき不変のルール

- コーディング規約、命名規則、禁止事項
- セキュリティポリシー、コミット規約
- **目安：200行以下**（超えたら Skill に委譲）

### 層2：手順層（Skills）

**役割:** 特定キーワードで呼び出される、タスク固有の手順書

- デプロイ、バグ調査、コードレビュー等
- 各 Skill は**単一目的**
- **目安：200〜300行**

```
/deploy     → skills/deploy.md
/debug      → skills/debug.md
/review     → skills/review.md
```

### 層3：タスク層（Agents）

**役割:** 並列実行可能な独立したタスク単位

- ステートレス設計により複数タスクの同時実行
- コードレビュー専用、ドキュメント生成専用など
- Claude Code のサブエージェント並列実行と相性が良い

## 導入効果（実績）

| 指標 | 改善前 | 改善後 |
|------|--------|--------|
| CLAUDE.md の行数 | 800行 | 180行（80%削減） |
| Skills の重複率 | 30% | 5%（83%削減） |
| 並列実行の可否 | 直列のみ | 並列実行可 |

## 設計の考え方

「何が常に適用されるべきか（基盤層）」「何がリクエスト時に必要か（手順層）」「何が独立して実行できるか（タスク層）」の3軸で分解する。

## 関連ページ

- [[wiki/skill-md-pattern]] — SKILL.md による折りたたみ式マニュアルパターン
- [[wiki/mcp-token-optimization]] — MCP トークン消費削減（MCPも同様の分離思想）
- [[wiki/ai-parallel-worktree]] — git worktree による Claude 並列開発
- [[wiki/claude-code-job-queue]] — ジョブキューとマネージャーエージェント設計
- [[wiki/claude-code-hooks]] — Claude Code ライフサイクルハンドラシステム
