# The text mode lie: why modern TUIs are a nightmare for accessibility (2026-05-04)

Source: https://xogium.me/the-text-mode-lie-why-modern-tuis-are-a-nightmare-for-accessibility
Hacker News: https://news.ycombinator.com/item?id=48002938
Published: 2026-05-03

Key points:
- 誤解: テキストベースのアプリケーションは自動的にアクセシブルだという考え
- CLIとTUIの決定的な違い:
  - CLI（ストリーム）: 標準入出力で線形に動作 → スクリーンリーダーと相性が良い
  - TUI（グリッド）: 2次元グリッドとして機能 → アクセシビリティの問題が深刻
- React Inkのようなモダンフレームワークの問題:
  - フレームワークが反応型キャンバスとして動作し、更新のたびに再描画がトリガー
  - スピナーやタイマーの頻繁な更新がスクリーンリーダーを妨害
- 成功しているTUI例（nano、vim、menuconfig、Irssi）の特性:
  - カーソル非表示オプション
  - 単一列フォーカス
  - VT100スクロール領域などのハードウェア機能の活用
