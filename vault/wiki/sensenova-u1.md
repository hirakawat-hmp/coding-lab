---
type: entity
status: []
tags:
  - ai/image-gen
  - ai/llm
sources:
  - "https://gigazine.net/news/20260430-sensenova-u1-image-generation-ai/"
created: 2026-05-01
updated: 2026-05-01
---

# SenseNova U1 — VAE不要の軽量オープン画像生成AIモデル

![SenseNova U1](https://i.gzn.jp/img/2026/04/30/sensenova-u1-image-generation-ai/00_m.png)

中国SenseTime社（商湯科技）が2026年4月30日に公開したオープンソース画像生成AIモデル。VAE（変分オートエンコーダ）やテキストエンコーダーを必要としない革新的なエンドツーエンド設計で、小さなパラメーター数で高品質な画像を生成する。

## スペック

| 項目 | 詳細 |
|------|------|
| パラメーター数 | 80億 |
| ライセンス | Apache License 2.0 |
| 配布 | Hugging Face（無料公開） |
| 処理速度 | RTX 5090: 2048×2048 → 前処理0.415s + 生成23.04s |

## 設計の革新性

従来の画像生成AI（Stable Diffusion, FLUX等）はVAEでピクセル空間→潜在空間の変換が必要だったが、SenseNova U1は**単一モデルが生成処理を完結させる**エンドツーエンド設計を採用。

## 対応機能

- 画像生成（テキスト→画像）
- 画像編集
- インフォグラフィック生成
- 連続性のある画像生成（シリーズ）

## 競合比較

| モデル | パラメーター | VAE不要 | ライセンス |
|--------|-------------|---------|-----------|
| SenseNova U1 | 80億 | ✓ | Apache 2.0 |
| FLUX.2 Klein | 40億 | ✗ | Apache 2.0 |
| Qwen-Image-2512 | より大規模 | ✗ | 非公開 |

## 関連ページ

- [[wiki/flux-2]] — Black Forest Labsの統合画像生成モデルFLUX.2
- [[wiki/ai/image-gen]] — 画像生成AIモデル全般
- [[wiki/deepseek-v4]] — 中国発オープンソースLLMの動向（DeepSeek-V4）
