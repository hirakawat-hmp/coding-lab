---
type: entity
status: []
tags:
  - ai/llm
sources:
  - "https://k-tai.watch.impress.co.jp/docs/column/minna/2101682.html"
created: 2026-04-15
updated: 2026-04-15
---

# Gemma4 オンデバイス（スマートフォン上の LLM）

![Gemma4 on smartphone](https://asset.watch.impress.co.jp/img/ktw/docs/2101/682/51_l.jpg)

Google の Gemma4 モデルをスマートフォン上でオフライン実行する取り組み。「Google AI Edge Gallery」アプリ経由で約 2.5GB のモデルをインストールし、クラウド不要で AI を活用できる。

## Gemma4 とは

- **種別**: Google のオープンソース軽量 LLM（Apache 2.0）
- **モバイル最適化版**: `Gemma4-E2B-it`（Embedding 2B Instruction-tuned）
- **モデルサイズ**: 約 2.5GB（Wi-Fi ダウンロード）

## セットアップ

1. Google Play / App Store から「Google AI Edge Gallery」をインストール
2. Wi-Fi 接続で Gemma4 モデル（約 2.5GB）をダウンロード
3. 以降はオフラインで使用可能

## 主な機能

| 機能 | 説明 |
|------|------|
| AI Chat | テキストチャット |
| Ask Image | 画像解析・質問応答 |
| オフライン実行 | インターネット接続不要 |

## パフォーマンス評価

「軽量モデルにもかかわらず、クラウド AI と比べて大きく劣らない応答が得られる」（大和哲、2026年4月）

## 制限事項

- **知識カットオフ**: 2025年初頭頃
- **日本語**: 時々不自然な表現
- **チャット履歴**: セッション間での保持なし

## 意義

スマートフォン上でのオンデバイス LLM 実行はプライバシーとオフライン利用の両面で重要:

1. **プライバシー**: クラウドにデータを送信しない
2. **オフライン**: 通信不要でいつでも利用可能
3. **低レイテンシ**: ネットワーク遅延なし
4. **コスト**: API 利用料不要

## 比較: ローカル LLM の選択肢

| 方式 | デバイス | 例 |
|------|---------|-----|
| スマートフォン | iOS / Android | Gemma4 (Gemma4-E2B-it) |
| デスクトップ（GPU） | PC | [[wiki/local-llm-dual-gpu]] |
| CPU 単体 | PC | [[wiki/bitnet-cpp]] |

## 関連ページ

- [[wiki/local-llm-dual-gpu]] — デスクトップ向け 32GB VRAM 構成
- [[wiki/bitnet-cpp]] — CPU 単体での 100B モデル推論
