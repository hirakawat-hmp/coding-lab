---
type: entity
status: []
tags:
  - dev/rust
  - industry/tech
created: 2026-05-05
updated: 2026-05-05
sources:
  - "https://forest.watch.impress.co.jp/docs/news/2106292.html"
---

# Microsoft Edit CLI v2.0.0 — 構文ハイライト追加

![Microsoft Edit CLI](https://asset.watch.impress.co.jp/img/wf/docs/2106/292/image1_l.png)

MicrosoftのRust製CLIテキストエディター「Edit」がv2.0.0にメジャーアップデート。待望の構文ハイライト機能が追加され、十数種の言語に対応。

## 主要追加機能

1. **構文ハイライト**: 新開発のLSH（Lightweight Syntax Highlighter）コンパイラー使用。HTML、JavaScript、Markdown、JSONなど十数種の言語。100MB/秒以上の処理速度。
2. **正規表現メタ文字**: $1、$2などの後方参照が使用可能に
3. **ファイルダイアログ改善**: 数値順ソートの改善
4. **キーボードショートカット追加**: [Alt]+[↑][↓]で行移動、[Ctrl]+[L]で行全体選択

## 技術仕様

- **言語**: Rust
- **ライセンス**: MITライセンス（オープンソース）
- **プラットフォーム**: Windows + Linux対応

## 関連ページ

- [[wiki/warp-terminal-oss]] — Warpターミナルのオープンソース化
- [[wiki/jujutsu-jj]] — 現代的VCS（jj CLI）
