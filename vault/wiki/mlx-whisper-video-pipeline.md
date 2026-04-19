---
type: concept
status: [draft]
tags:
  - ai/llm
  - ai/audio-gen
  - tool/claude-code
  - dev/javascript
sources:
  - "https://qiita.com/takatein/items/c7cbec541a00c568e345"
created: 2026-04-19
updated: 2026-04-19
---

# 会議録画→ハイライト動画 自動生成パイプライン（mlx-whisper × Remotion × Claude Code）

mlx-whisper（Apple Silicon 最適化文字起こし）+ Claude Code（トピック抽出）+ Remotion（React ベース動画合成）を組み合わせた自動ハイライト動画生成の設計パターン（2026年4月）。

## 概要

1時間の会議録画 → 60秒ハイライト動画の自動生成。人手作業を排除し、再現可能なパイプラインとして実装。

## パイプライン構成

```
会議録画 (.mp4)
    ↓ ffmpeg
音声抽出 (.wav)
    ↓ mlx-whisper
文字起こし（単語レベルタイムスタンプ付き）
    ↓ Claude Code (MCP経由)
トピック抽出・クリップ時間選択
    ↓
字幕ファイル生成
    ↓ Remotion
Reactコンポーネントとして動画を記述
    ↓ Remotion render
60秒ハイライト動画
```

## 各コンポーネント

### mlx-whisper
- Apple Silicon 向け Whisper 実装
- 単語レベルのタイムスタンプを出力 → 正確なクリップ選択が可能

### Claude Code
- MCP 経由でトランスクリプトを受け取りトピックを抽出
- 「最も重要な60秒分のクリップ」を選択する判断を担当
- Gemini Meet サマリーとの連携も可能

### Remotion
- React で動画を宣言的に記述するフレームワーク
- コンポーネントとして動画を設計 → 保守・再利用が容易

## システム要件

| 要件 | 詳細 |
|------|------|
| OS | macOS 14+ (Apple Silicon) |
| RAM | 16GB+ |
| Node.js | 18+ |
| Python | 3.11 |

## 処理時間

| 状況 | 時間 |
|------|------|
| 初回（モデルダウンロード含む） | 10〜15分 |
| 2回目以降（M3 Mac） | 2〜5分 |

## 実装上のポイント

- **日本語ファイル名問題**: シンボリックリンクレイヤーで解決（ffmpeg が日本語パスを誤認識）
- **クリップ精度**: 単語レベルタイムスタンプにより秒単位でカット点を制御

## 関連ページ

- [[wiki/claude-code-routines]] — Claude Code の自動実行パターン
- [[wiki/deepl-voice-to-voice]] — 音声処理 AI ツールの動向
