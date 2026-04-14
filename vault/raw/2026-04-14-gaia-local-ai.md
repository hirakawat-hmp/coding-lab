# GAIA Local AI Framework — Raw Source

Source: https://amd-gaia.ai/docs
Fetched: 2026-04-14
Feed: Hacker News (Top)

## 概要

GAIAは、ローカルハードウェア上で完全に動作するAIエージェント構築のためのオープンソースフレームワーク。AMD製。

## 特徴

- **オンデバイス処理**：全ての処理がローカルで完結
- **クラウド不要**：APIキーや外部サービスが不要
- **言語対応**：PythonとC++の両方で完全なSDKを提供
- **AMD最適化**：Ryzen AIのNPUとGPUアクセラレーション対応

## 主要機能

**Python環境：**
- Agent UI（ドキュメント質問応答対応）
- 音声対話（Whisper ASRおよびKokoro TTS）
- コード生成と画像生成機能
- Model Context Protocol（MCP）統合

**C++環境：**
- システムヘルスエージェント
- Wi-Fiトラブルシューティング
- カスタムエージェント構築

## 提供形態

シンプルなAPIで利用でき、数行コードで処理可能な設計。
