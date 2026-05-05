---
type: entity
status: []
tags:
  - ai/audio-gen
  - dev/python
created: 2026-05-05
updated: 2026-05-05
sources:
  - "https://gigazine.net/news/20260504-irodori-tts-text-to-speech-ai/"
---

# Irodori-TTS — 日本語特化ローカル音声合成AI

![Irodori-TTS](https://i.gzn.jp/img/2026/05/04/irodori-tts-text-to-speech-ai/00_m.png)

Aratako氏が開発した日本語専門のローカル音声合成（TTS）モデル。「セリフ」「声」「感情」を自由に指定でき、ローカル完全動作のためAPI課金なしで無制限に生成可能。

## 主な機能

- **テキスト→音声変換**: 基本的な日本語音声生成
- **声色指定**: リファレンス音声を使った任意の声色
- **感情制御**: 絵文字で50種類以上の感情表現（泣き、怒り、囁きなど）
- **VoiceDesign版**: 説明文による音声特性の指定

## セットアップ

```bash
git clone <repo>
uv sync
# ブラウザで localhost:7860 にアクセス
```

必要環境: Python、uv、Git

## パフォーマンス

| 環境 | 5秒分の音声生成速度 |
|------|------------------|
| GPU（RTX 5070 Ti等） | 約3秒 |
| CPU | 約90秒 |

## 関連ページ

- [[wiki/elevenlabs-scribe-v2]] — ElevenLabsのリアルタイムSTT
- [[wiki/ace-step]] — ACE Studio音楽生成基盤モデル
- [[wiki/openai-realtime-voice-ai-scale]] — OpenAI 低遅延音声AI
