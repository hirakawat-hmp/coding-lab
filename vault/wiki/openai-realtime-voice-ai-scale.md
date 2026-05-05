---
type: entity
status: []
tags:
  - ai/llm
  - ai/audio-gen
  - industry/tech
created: 2026-05-05
updated: 2026-05-05
sources:
  - "https://openai.com/index/delivering-low-latency-voice-ai-at-scale/"
---

# OpenAI Realtime Voice AI — 大規模低遅延配信

OpenAIがRealtime APIと ChatGPT音声機能を支えるインフラ技術を解説したブログ記事（2026年5月4日）。数百万人の同時ユーザーに200ms以下の遅延で音声AIを提供するための技術的詳細を公開。

## 主要技術ポイント

- **ストリーミングパイプライン**: STT（音声→テキスト）→ LLM → TTS（テキスト→音声）の全行程をストリーミング処理
- **カスタムモデルサービングインフラ**: リアルタイム音声向けに最適化された専用インフラ
- **グローバルエッジ展開**: 地理的近接性によるレイテンシ削減
- **効率的バッチ処理**: 音声セグメントの効率的なバッチングで大規模スケーリングを実現

## 意義

Realtime APIは開発者が人間的な応答速度を持つ音声AIアプリケーションを構築できるようにする基盤。このブログは大規模音声AIインフラの設計原則を示す重要な技術資料。

## 関連ページ

- [[wiki/elevenlabs-scribe-v2]] — ElevenLabs リアルタイムSTT（150ms・90言語）
- [[wiki/deepl-voice-to-voice]] — DeepL Voice-to-Voiceリアルタイム音声翻訳
- [[wiki/irodori-tts]] — ローカル日本語TTS「Irodori-TTS」
