# Raw: HERMES.md in commit messages causes requests to route to extra usage billing

Source: https://github.com/anthropics/claude-code/issues/53262
Fetched: 2026-04-30
HN Points: 944 | Comments: 387

## Summary

Claude Code v2.1.119 のバグ。git コミットメッセージに大文字の `HERMES.md` という文字列が含まれていると、Max プランの利用枠ではなく「extra usage（追加課金）」にルーティングされる。

## Key Details

- トリガー: コミットメッセージ中の `HERMES.md`（大文字・case-sensitive）
- 根本原因: Claude Code がシステムプロンプトに最近のコミットを含め、サーバー側のルーティングロジックがこの文字列を誤解釈
- 財務的影響: $200.98+ が extra usage として消費（プラン枠は86%以上残存）
- 対象バージョン: Claude Code v2.1.119
- ラベル: bug, area:cost, has repro, platform:macos

## Conditions

| コミットメッセージ | 結果 |
|---|---|
| "HERMES.md" | ❌ extra usage |
| "test HERMES.md test" | ❌ extra usage |
| "hermes.md"（小文字） | ✅ プラン枠 |
| "HERMES"（拡張子なし） | ✅ プラン枠 |
| "HERMES.txt" | ✅ プラン枠 |
| "AGENTS.md" / "README.md" | ✅ プラン枠 |
