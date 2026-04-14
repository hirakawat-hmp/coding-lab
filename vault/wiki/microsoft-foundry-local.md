---
type: entity
status: []
tags:
  - ai/llm
  - ai/agent
sources:
  - "https://www.publickey1.jp/blog/26/aifoundry_localmaclinux.html"
created: 2026-04-14
updated: 2026-04-14
---

# Microsoft Foundry Local

## 概要

Microsoft が 2026年4月12日に正式リリースした、**アプリケーションにバンドルしてインストーラで配布できるローカル AI ランタイム**。
クラウド不要でアプリ内に AI 推論環境を同梱できる点が特徴。

## 技術仕様

**ランタイム**: ONNX Runtime + Windows ML  
**API**: OpenAI 互換 RESTful API  
**対応モデル**: GPT OSS, Qwen Family, Deepseek, Whisper, Mistral, Phi ほか  
**対応OS**: Windows / macOS（Apple Silicon GPU 活用）/ Linux  
**対応言語**: JavaScript, C#, Python, Rust

**ハードウェア最適化**: GPU / NPU / CPU を自動検出して最適化処理を実行

## 配布モデル

開発者がアプリに AI 環境をバンドルしてインストーラを提供する。
ユーザー側は追加セットアップ不要でクラウド依存なしに AI 機能を利用できる。

ローカル実行なのでプライバシー保護・オフライン対応・レイテンシ削減が実現できる。

## 今後のロードマップ

- モデルカタログの充実
- NPU / GPU 対応範囲の拡大
- リアルタイム音声文字起こし機能
- 複数アプリ間でのモデル共有機能

## 位置付け

クラウド AI（Azure AI Foundry）の縮小版をエッジ・デスクトップにデプロイするための仕組み。
AMD GAIA と同様に「ローカル AI エージェント」の流れを加速する製品。

## 関連ページ

- [[wiki/gaia-local-ai-agent]] — AMD のローカル AI エージェントフレームワーク（同一カテゴリ）
- [[wiki/bitnet-cpp]] — Microsoft の 1.58-bit 量子化推論エンジン（Microsoft製ローカルAI関連）
