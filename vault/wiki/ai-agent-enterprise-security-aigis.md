---
type: how-to
status: [draft]
tags:
  - ai/agent
  - security/web
  - tool/claude-code
sources:
  - "https://qiita.com/sharu389no/items/ede7d1c0be4a14024857"
created: 2026-05-04
updated: 2026-05-04
---

# AIエージェント企業導入のセキュリティ対策：Aigis

Claude CodeやCursorなどのAIエージェントを企業環境に導入する際のセキュリティ懸念と、OSSツール「Aigis」を使った技術的対策。

## 企業セキュリティ部門からの3つの懸念

### Q1: AIの行動が見えない

**対策**：全操作を記録し、改ざん不可の形式で保存。異常検知も自動実施。

### Q2: 危険な操作の実行を防止できるか

**対策**：4段階のプロンプトインジェクション防御関門 ＋ ルール定義による操作制限。「外部出身」タグによる隔離も可能。

### Q3: 監査・説明責任への対応

**対策**：44種類の国際規制テンプレートに対応した自動レポート生成。

## Aigis の導入

```bash
pip install pyaigis
```

- **ライセンス**: Apache 2.0（無料・商用可）
- **LLM API課金**: なし（OSSエンジン使用）

## 2026年特有の追加機能

| 機能 | 内容 |
|------|------|
| MCPツール検査 | MCPサーバーのなりすまし防止 |
| 自己訓練ループ | インシデントから防御ルールを自動学習 |
| 個人情報マスキング | PIIの自動検出・マスク処理 |

## 導入の判断基準

- **必須シーン**: 本番データへのアクセス権を持つエージェント、規制業種（金融・医療）
- **任意シーン**: 開発環境専用のエージェント、社内情報へのアクセスがないもの

## 関連ページ

- [[wiki/cursor-cve-2026-26268]] — Cursor CVE-2026-26268（AIエージェントのgit操作悪用）
- [[wiki/claude-code-security-incidents]] — Claude Codeセキュリティ事故7選
- [[wiki/copilot-studio-mcp-security]] — Copilot Studio MCP セキュリティ対策
- [[wiki/mcp-security-vulnerability-2026]] — MCPのシステム的脆弱性
