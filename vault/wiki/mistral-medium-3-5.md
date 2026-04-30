---
type: entity
status: []
tags:
  - ai/llm
  - ai/agent
sources:
  - "https://mistral.ai/news/vibe-remote-agents-mistral-medium-3-5"
created: 2026-04-30
updated: 2026-04-30
---

# Mistral Medium 3.5

## 概要

Mistral AI が2026年4月29日に公開した 128B Dense モデル。オープンウェイト（modified MIT ライセンス）で Hugging Face で公開。HN で 413 ポイントを獲得。

## モデル仕様

| 項目 | 値 |
|------|-----|
| パラメータ数 | 128B（Dense） |
| コンテキストウィンドウ | 256k トークン |
| 推論モード | 可変推論量（タスク複雑さに応じて調整） |
| ビジョン | カスタムエンコーダ（可変解像度・アスペクト比対応） |

## ベンチマーク

| ベンチマーク | スコア |
|------------|--------|
| SWE-Bench Verified | **77.6%**（Devstral 2・Qwen3.5 397B を超える） |
| τ³-Telecom | **91.4** |

SWE-Bench Verified 77.6% は、パラメータ数が遥かに大きいモデルを超える結果として注目される。

## 利用方法

- **Hugging Face**: オープンウェイト公開
- **API**: $1.5/M input・$7.5/M output トークン
- **NVIDIA endpoints / NVIDIA NIM** 経由でも利用可能
- **Le Chat**（Mistral のチャットUI）

## Vibe Remote Agents

同時発表のリモートエージェント機能:
- 非同期コーディングセッションをクラウド隔離サンドボックスで実行
- CLI または Le Chat から起動
- GitHub、Linear、Jira、Sentry、Slack、Teams と統合
- ローカル CLI セッションをクラウドに転送（履歴・承認状態を維持）

## 関連ページ

- [[wiki/qwen3-6-27b]] — Qwen3.6-27B（競合オープンソースコーディングモデル）
- [[wiki/kimi-k2-6]] — Kimi K2.6（競合オープンソースコーディングモデル）
- [[wiki/deepseek-v4]] — DeepSeek-V4（Claude Opus 4.6 対抗モデル）
