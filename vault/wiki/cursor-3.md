---
type: entity
status: []
tags:
  - tool/cursor
  - ai/agent
  - tool/claude-code
sources:
  - "https://forest.watch.impress.co.jp/docs/news/2102636.html"
created: 2026-04-18
updated: 2026-04-18
---

# Cursor 3.0 — マルチエージェント並行実行を前提とした AI コードエディタ

![Cursor 3.0](https://asset.watch.impress.co.jp/img/wf/docs/2102/636/image1_l.png)

2026年4月17日リリース。VS Code ベースの AI ネイティブコードエディタ Cursor の
メジャーバージョン。複数 AI エージェントの並行実行を設計の中心に置く。

## 最大の革新：Agents Window

既存の VS Code エディタウィンドウとは**独立した**マルチエージェント管理専用インターフェース。

```
Agents Window
  ├── Sidebar（アクティブエージェント一覧）
  │     ├── mobile agent
  │     ├── web agent
  │     ├── desktop agent
  │     ├── Slack agent
  │     └── GitHub agent
  ├── Terminal
  ├── Embedded Browser
  ├── Editor + Diff Viewer
  └── Git Operations（stage/commit/PR）
```

## 主要機能

### マルチエージェント管理
- 複数ソース（モバイル・Web・デスクトップ・Slack・GitHub）のエージェントを横断管理
- リポジトリをまたいだシームレスな切り替え

### ビジュアルデザインモード
- 内蔵ブラウザで変更箇所を指定しエージェントに直接指示

### クラウド/ローカル柔軟性
- オフライン時もクラウド ↔ ローカル間の引き継ぎが継続

### エディタウィンドウ拡張
- エージェントタブを横並び・グリッドレイアウトで表示

## v3.1 追加機能

- エージェントペインのタイルレイアウト
- 音声入力（ディクテーション）の信頼性向上

## Claude Code との比較

| 項目 | Cursor 3.0 | Claude Code |
|------|-----------|-------------|
| エディタ | VS Code ベース統合 | エディタ非依存 CLI |
| マルチエージェント | Agents Window で視覚管理 | 並列セッション |
| 入力モデル | ビジュアル指定 + テキスト | テキスト中心 |

## 関連ページ

- [[wiki/claude-code-desktop-parallel]] — Claude Code Desktop の並列エージェント対応
- [[wiki/claude-code-job-queue]] — Claude Code のマルチセッション設計
