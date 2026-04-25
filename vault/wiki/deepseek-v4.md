---
type: entity
status: []
tags:
  - ai/llm
  - ai/eval
sources:
  - "https://www.itmedia.co.jp/aiplus/articles/2604/24/news100.html"
  - "https://gigazine.net/news/20260424-deepseek-v4/"
created: 2026-04-25
updated: 2026-04-25
---

# DeepSeek-V4

![DeepSeek-V4](https://image.itmedia.co.jp/aiplus/articles/2604/24/ts1648348_202604241_1_w490.jpg)

DeepSeek が 2026年4月24日にプレビュー公開したオープンソース AI モデル。「エンタープライズクラスのクローズドモデルに対抗する性能」を謳い、100万トークンのコンテキストウィンドウを持つ。

## アーキテクチャ

MoE（Mixture of Experts）アーキテクチャを採用。モデル内の複数の小規模パラメータの一部だけを状況に応じて起動する。

## モデルラインナップ

| モデル | 特徴 |
|--------|------|
| **DeepSeek-V4-Pro** | 高精度・論理的コーディングに強み |
| **DeepSeek-V4-Flash** | 高速推論・軽量 |

## ベンチマーク性能

複数のベンチマークで以下に対抗するスコアを記録：
- OpenAI GPT-5.4
- Google Gemini 3.1 Pro
- Anthropic Claude Opus 4.6

## API 価格

| モデル | 入力（キャッシュミス） | 出力 |
|--------|----------------------|------|
| V4-Pro | $1.74 / M tok | $3.48 / M tok |
| V4-Flash | $0.14 / M tok | $0.28 / M tok |

キャッシュヒット時は V4-Pro 入力 $0.145、V4-Flash 入力 $0.028。

## 提供形態

- DeepSeek のチャット AI サービス・API
- Hugging Face でモデル重みを公開（完全オープンソース）

## 関連ページ

- [[wiki/gpt-5-5]] — 競合 OpenAI の GPT-5.5
- [[wiki/qwen3-6-27b]] — 別のオープンソースコーディング LLM
- [[wiki/kimi-k2-6]] — Kimi K2.6 オープンソースコーディングモデル
