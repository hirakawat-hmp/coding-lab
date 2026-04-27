---
type: concept
status: []
tags:
  - tool/claude-code
  - ai/agent
sources:
  - "https://qiita.com/nogataka/items/95efda0c7c9ea2405139"
created: 2026-04-27
updated: 2026-04-27
---

# Claude Code PreCompact Hook

Claude Code の auto-compact（自動会話圧縮）処理に介入できるライフサイクルフック。2026年に追加された機能で、長時間セッションにおける文脈喪失問題を解決する。

## 背景：auto-compact の問題

コンテキストウィンドウが逼迫すると Claude Code は自動で過去の会話を要約・圧縮する。この過程で「未解決の論点」や「途中で棚上げした課題」が「解決済み」として扱われ、議論の結論がすり替わる問題が発生する。

## PreCompact Hook の動作

`settings.json` にスクリプトを登録し、圧縮前に割り込む。

| exit code | 動作 |
|-----------|------|
| `exit 0` | 標準の自動圧縮を実行 |
| `exit 2` | 圧縮を中止 |
| `decision:replace` | カスタム要約に置き換え |

### 実装例

未解決マーカー（`TODO:`, `未決:` 等）を含む行を検出し、それらが含まれる場合に圧縮を差し止める bash スクリプト:

```bash
#!/bin/bash
# precompact-guard.sh
if grep -q "TODO:\|未決:\|TBD:" "$CLAUDE_CONTEXT_FILE"; then
  echo "未解決項目が存在します。圧縮を中止します。" >&2
  exit 2
fi
exit 0
```

## 関連機能との組み合わせ

- **Session Notes**: 10K トークンごとに要点を自動保存。PreCompact Hook と組み合わせて、圧縮前に重要事項を Session Notes に書き出すパターンが有効
- **Channels**（研究プレビュー）: Discord・Slack 等の外部チャネルから Claude Code セッションに割り込み指示を送る機能。Channels 経由で長時間 agentic タスクを遠隔監視・制御できる
- **Auto Memory**: セッションをまたいだ知識蓄積。圧縮後の情報を Auto Memory に保存することで知識が永続化される

## セキュリティ上の注意

Channels 機能経由で外部から指示を受け入れる場合:
- `permissions.deny` を徹底してツール権限を最小化
- プロンプトインジェクション対策（Discord メッセージに悪意ある指示が含まれる可能性）
- 発火条件の明確化（特定フォーマットのメッセージのみ受け入れるなど）

## 関連ページ

- [[wiki/claude-code-hooks]] — Claude Code の全ライフサイクルフックの概要
- [[wiki/claude-code-hooks-events]] — 各フックイベントの入出力仕様
- [[wiki/claude-code-hooks-patterns]] — フックの実用実装パターン
- [[wiki/codex-automations]] — Codex 側の定期自動化との比較
