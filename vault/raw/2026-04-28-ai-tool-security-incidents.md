# そのAIツール、すでに情報を抜かれています。実在インシデント8選

- Source: https://prtimes.jp/main/html/rd/p/000000068.000118521.html
- Published: 2026-04-28
- Author: 株式会社MONO BRAIN

## Summary

実際に発生したAI関連セキュリティ事故8選:

1. M365 Copilot: メール経由の間接プロンプトインジェクション→データ自動送信
2. Lovable: API権限設計ミス→コード・チャット履歴露出
3. ChatGPT連携: 外部API悪用→Google Drive/GitHub情報自動抽出
4. Replit AI Agent: 本番DB削除（1,000件以上）
5-8. GitHub Copilot、Vercel等: インジェクション・トークン漏洩・情報窃取

**共通リスク:** 過剰な権限で無防備な運用、外部入力への過信、OAuth/APIガバナンス欠如

**推奨対策:** 最小権限の原則、外部連携統制、入出力サニタイズ、人間承認フロー

OGP: https://prcdn.freetls.fastly.net/release_image/118521/68/118521-68-03ce3ea21fdf0537d9231555e3325d93-1280x720.png
