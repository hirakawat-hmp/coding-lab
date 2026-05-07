# Microsoft Edge がすべての保存パスワードを起動時に平文でRAMに展開

Source: https://xenospectrum.com/edge-plaintext-ram-passwords/
Retrieved: 2026-05-07

## 発見

ノルウェーのセキュリティ研究者 Tom Jøran Sønstebyseter Rønning が発見。Microsoft Edge は起動時にすべての保存パスワードを平文でRAMに展開する。Microsoft はこれを「意図的な設計」と確認。

## 技術的詳細

| 側面 | Edge | Chrome/Brave |
|------|------|-------------|
| パスワード復号タイミング | 起動時に全件ロード | 必要時のみ復号 |
| 平文保存期間 | セッション全体 | 最小限のウィンドウ |

研究者は GitHub に PoC（EdgeSavedPasswordsDumperPoC）を公開し、2026年4月の BigBiteOfTech カンファレンスで実証。

## リスク評価

- 悪用には管理者レベルのシステムアクセスが必要（Web ブラウジング単体では不可）
- 共有環境・ターミナルサーバー・リモートデスクトップ環境で特に危険
- 管理者権限を持つ攻撃者が複数ユーザーアカウントのクレデンシャルを一括窃取可能

## 推奨対策

- 機密性の高いクレデンシャルは専用パスワードマネージャーへ移行
- 重要アカウントには多要素認証を有効化
- 共有デバイスと管理者権限の見直し
