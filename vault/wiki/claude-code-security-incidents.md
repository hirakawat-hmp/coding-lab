---
type: insight
status: []
tags:
  - security/web
  - tool/claude-code
sources:
  - "https://qiita.com/masa_ClaudeCodeLab/items/8c22966fbd3c125c53dc"
created: 2026-04-18
updated: 2026-04-18
---

# Claude Code で実際に起きたセキュリティ事故 7選

Claude Code（および AI コーディングエージェント全般）の運用で実際に発生したセキュリティ事故の
記録と防止策。「事故は AI の誤作動ではなく、設定の先送りから起きる」。

## 事故一覧と防止策

| # | 事故 | 原因 | 防止策 |
|---|------|------|--------|
| 1 | `.env` を GitHub に誤コミット | `.gitignore` 未設定 | `.gitignore` + pre-commit フック |
| 2 | 本番 DB 削除（3日分データ損失） | 本番接続で `DROP TABLE` | 本番操作にインタラクティブ確認 |
| 3 | プロジェクト全体削除 | `rm -rf` のパス設定ミス | deny list + 5秒警告遅延 |
| 4 | API 認証情報がログに残存 | プロンプトにクレデンシャル埋め込み | 環境変数のみ使用 |
| 5 | 1時間で 3,000 API コール（$200課金） | リトライ上限なし | 指数バックオフ + 上限設定 |
| 6 | 同僚コミットを `--force` で上書き | force push 無制限 | force push 禁止、`--force-with-lease` |
| 7 | サービスアカウント過剰権限 | Owner 権限 SA を利用 | 最小権限原則、IAM 細分化 |

## 事故 #1 詳細：環境ファイル漏洩

```bash
# .gitignore に追加（必須）
.env
.env.local
*.env

# pre-commit フックで API キーをスキャン
#!/bin/bash
if git diff --cached --name-only | xargs grep -l 'AIza\|sk-\|ANTHROPIC_API'; then
  echo "⛔ API キーが含まれています。コミットを中止しました。"
  exit 1
fi
```

## 事故 #5 詳細：API リトライ無限ループ

```python
# NG: リトライ上限なし
while True:
    response = api.call()

# OK: 指数バックオフ + 上限
for attempt in range(max_retries=5):
    try:
        response = api.call()
        break
    except RateLimitError:
        time.sleep(2 ** attempt)
```

## 教訓

> セキュリティ事故は AI の誤作動ではなく、設定の先送りから起きる。
> **30分の設定で大きな事故を防げる。**

## 関連ページ

- [[wiki/claude-code-harness-patterns]] — Claude Code ハーネスパターン（deny list 設計）
- [[wiki/google-apikey-gemini-billing]] — API キー漏洩による課金インシデント
- [[wiki/mcp-security-vulnerability-2026]] — MCP のシステム的脆弱性
- [[wiki/wordpress-plugin-supply-chain-attack]] — サプライチェーン攻撃との比較
