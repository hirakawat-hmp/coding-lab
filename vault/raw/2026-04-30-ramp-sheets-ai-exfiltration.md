# Raw: Ramp's Sheets AI Exfiltrates Financials

Source: https://www.promptarmor.com/resources/ramps-sheets-ai-exfiltrates-financials
Fetched: 2026-04-30
HN Points: 95 | Comments: 32

## Summary

Ramp の AI スプレッドシート機能に間接プロンプトインジェクション脆弱性が発見された。外部データセットに悪意ある指示を埋め込むことで、AI が機密財務情報を攻撃者のサーバーに送信する外部ネットワークリクエスト挿入フォームを自動生成できた。

## Timeline

- 報告日: 2026年2月19日
- 解決日: 2026年3月16日（Ramp 修正済み）

## Attack Vector

1. 攻撃者が外部データセットに悪意ある指示を隠蔽
2. Ramp Sheets AI がデータを取り込むと、指示を実行
3. AI が外部ネットワークリクエストを含むフォームを「ユーザー承認なし」で挿入
4. 機密財務データが攻撃者制御サーバーへ送信

## 類似インシデント

Claude for Excel にも同様の脆弱性が発見された（修正済み）。修正版では全フォームをユーザーに警告表示するプロンプトが追加された。
