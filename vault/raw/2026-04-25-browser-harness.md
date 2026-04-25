# Browser Harness — LLM がブラウザタスクを自由に完了するフレームワーク

source: https://github.com/browser-use/browser-harness
fetched: 2026-04-25
stars: 6.4k, forks: 569

## 要点

- Chrome DevTools Protocol (CDP) を直接使う LLM ブラウザ自動化フレームワーク
- 約 592 行の Python で構成（run.py + helpers.py + admin.py + daemon.py）
- セルフヒーリング：足りない機能を実行中に helpers.py に自動追記
- ドメインスキル：LinkedIn・Amazon・GitHub など特定サイト用スキルを community で蓄積
- クラウド枠：同時3ブラウザまで無料（Proxy + CAPTCHA 解決付き）
- MIT ライセンス

## 特徴

中間フレームワーク不要で CDP 直結なため低レイテンシ。
LLM が自分でヘルパー関数を書き足す「自己修復」設計が特徴的。
Show HN に登場し HN フロントページに掲載（2026年4月24日）。
