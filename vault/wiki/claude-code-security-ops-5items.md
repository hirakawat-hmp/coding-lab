---
type: how-to
status: [verified]
tags:
  - tool/claude-code
  - security/web
created: 2026-05-05
updated: 2026-05-05
sources:
  - "https://qiita.com/ennagara128/items/5d0ebc9fb835f55f7c98"
---

# Claude Code セキュリティ運用5項目 — Cursor CVE事件を機に

Cursor CVE-2026-26268（CVSS 9.9）を機に、AIコーディングツール全般のセキュリティ運用を見直すべき5つの実践項目。「便利さと引き換えに広がる攻撃面を管理可能なレベルに保つ」ための設計。

## 5項目

### 1. `.git`設定の棚卸し

```bash
git config --list
```

`fsmonitor`、`sshCommand`などの不審な設定をチェック。git cloneを起点とした攻撃ベクタ（Cursor CVEの手法）への対策。

### 2. AIツールのバージョン管理

チーム全員が同じバージョンを使用しているか定期確認。特定バージョンの既知の脆弱性を組織全体で素早く解消するため。

### 3. `.claude/settings.json`の権限設定

```json
{
  "permissions": {
    "deny": ["rm -rf", "cat ~/.ssh/*", "env | grep -i secret"]
  }
}
```

破壊的コマンドや認証情報読み取りを明示的に制限。

### 4. `.claudeignore`による機密ファイル除外

```
.env
*.pem
*.key
secrets/
```

Claude Codeが誤って機密ファイルを読み込むリスクを最小化。

### 5. Hookによるコマンド検証

gitleaksなどのツールをHookに組み込み、危険なコマンド実行を物理的にブロック。

## 関連ページ

- [[wiki/cursor-cve-2026-26268]] — Cursor CVE-2026-26268（CVSS 9.9・git cloneでRCE）
- [[wiki/claude-code-hooks]] — Claude Code ライフサイクルハンドラ
- [[wiki/envguard]] — envguard AIツールへの秘密鍵漏洩チェック
- [[wiki/claude-code-security-incidents]] — Claude Code セキュリティ事故7選
