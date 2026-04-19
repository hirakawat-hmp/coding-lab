# mlx-whisper × Remotion × Claude Codeで会議録画から60秒ハイライト動画を自動生成

**Source:** https://qiita.com/takatein/items/c7cbec541a00c568e345
**Fetched:** 2026-04-19
**Published:** 2026-04-19
**Author:** takatein（てぃんたか）/ KDDIアジャイル開発センター

## 概要

1時間の会議録画を60秒のハイライト動画に自動変換するパイプライン。Apple Silicon 最適化の mlx-whisper で文字起こし、Claude Code でトピック抽出、Remotion で動画合成。

## 処理フロー（7フェーズ）

1. 音声抽出（ffmpeg）
2. mlx-whisper による文字起こし（単語レベルタイムスタンプ付き）
3. Claude Code によるトピック抽出・クリップ選択
4. 字幕ファイル生成
5. Remotion によるビデオコンポーネント生成
6. 動画レンダリング
7. 最終出力

## システム要件

- macOS 14 以上（Apple Silicon）
- 16GB+ RAM
- Node.js 18+, Python 3.11
- Gemini Meet サマリーとの連携も可能

## 処理時間

- 初回: 10〜15分（M3 Mac）
- 2回目以降: 2〜5分

## ポイント

- 日本語ファイル名問題はシンボリックリンクレイヤーで解決
- Remotion の React ベースの動画生成フレームワークが鍵
