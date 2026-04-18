---
type: entity
status: []
tags:
  - ai/agent
  - infra/ci-cd
sources:
  - "https://forest.watch.impress.co.jp/docs/news/2102415.html"
created: 2026-04-18
updated: 2026-04-18
---

# Google Android CLI — AI エージェント向け Android 開発ツール

![Google Android CLI](https://asset.watch.impress.co.jp/img/wf/docs/2102/415/image1_l.png)

2026年4月17日プレビュー公開。AI コーディングエージェントを使った Android アプリ開発を
効率化するコマンドラインツール。

## パフォーマンス指標

| 指標 | 効果 |
|------|------|
| トークン消費量 | **70% 削減** |
| タスク完了速度 | **3× 高速化** |

## 主要コマンド

```bash
android sdk install    # SDK コンポーネントの選択的ダウンロード
android create         # テンプレートベースのプロジェクト生成
android emulator       # エミュレータ管理
android run            # デバイスへのデプロイ（Windows 版は現在無効）
android update         # バージョン更新
```

## 支援インフラ

### Android Skills
LLM が現在のベストプラクティス（ターゲット API レベル・Compose UI 等）に従うための
フレームワーク。ガイドラインからの逸脱を防止。

### Android Knowledge Base
グラウンディング情報を提供し、古い API を使った誤った AI レスポンスを防止。

## エコシステム互換性

- Gemini in Android Studio
- Claude Code
- GitHub Copilot
- その他サードパーティエージェント

## Android Studio との連携

Android CLI で生成したプロジェクトを Android Studio にシームレスに移行可能。

## 関連ページ

- [[wiki/claude-code-desktop-parallel]] — Claude Code と外部 CLI の並列利用
- [[wiki/gh-skill-github-cli]] — GitHub の類似エージェント支援 CLI（gh skill）
- [[wiki/cursor-3]] — マルチエージェント対応コードエディタ（Cursor 3.0）
