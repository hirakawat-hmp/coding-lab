# Microsoftの新CLIテキストエディター「Edit」v2.0.0が公開

Source: https://forest.watch.impress.co.jp/docs/news/2106292.html
Fetched: 2026-05-05

## 概要

MicrosoftがCLIテキストエディター「Edit」のメジャーバージョンアップv2.0.0をリリース。
主な追加機能は構文ハイライト機能。

## 主要機能追加

1. **構文ハイライト機能** - 新開発のLSH（Lightweight Syntax Highlighter）コンパイラー使用。HTML、JavaScript、Markdown、JSONなど十数種の言語に対応。100MB/秒以上の速度で動作。
2. **正規表現改善** - $1、$2などのメタ文字が使用可能に
3. **ファイルダイアログ強化** - 数値順ソートの改善
4. **キーボード操作追加** - [Alt]+[↑][↓]で行移動、[Ctrl]+[L]で行選択

## 技術仕様

- Rust言語で開発
- MITライセンス（オープンソース）
- Linux対応の汎用性
