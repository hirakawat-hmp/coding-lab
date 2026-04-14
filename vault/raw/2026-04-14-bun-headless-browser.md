# Bun v1.3.12 Headless Browser Automation

source: https://www.publickey1.jp/blog/26/bunheadless_brwoser_automation.html
fetched: 2026-04-14

## 概要

JavaScriptランタイム「Bun」の最新版（v1.3.12）にコマンドラインからヘッドレスブラウザを操作できる新機能が搭載。

## 主な特徴

操作方法:
- コマンドラインからの直接操作
- Bun APIを通じたプログラマティック制御

基本コマンド:
- bunwv start          — ブラウザ起動
- bunwv navigate URL   — ページ遷移
- bunwv screenshot     — スクリーンショット取得
- bunwv click-text "テキスト"  — テキストリンククリック

クロスプラットフォーム対応:
- macOS: OSレベルで操作するため、ヘッドレス/ネイティブを区別できない
- Windows他: Chrome/Chromium を自動検知またはパス指定、DevToolsプロトコル経由

AIエージェントとの連携:
- Claude CodeなどのAIエージェントがブラウザ操作を簡単に実装可能
- Webテストや自動化環境の構築が容易に
