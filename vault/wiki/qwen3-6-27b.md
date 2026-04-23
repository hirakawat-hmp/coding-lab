---
type: entity
status: []
tags:
  - ai/llm
  - ai/agent
sources:
  - "https://simonwillison.net/2026/Apr/22/qwen36-27b/"
  - "https://huggingface.co/Qwen/Qwen3.6-27B"
  - "https://efficienist.com/qwen3-6-27b-is-a-27b-dense-model-that-outperforms-a-397b-on-coding-benchmarks/"
created: 2026-04-23
updated: 2026-04-23
---

# Qwen3.6-27B

AlibabaのQwenチームが2026年4月22日にリリースした**27Bの密なコーディング特化モデル**。前世代の397B MoEモデルを全主要コーディングベンチマークで上回るという驚異的な効率を実現。

## ベンチマーク性能

| ベンチマーク | Qwen3.6-27B | Qwen3.5-397B-A17B |
|---|---|---|
| SWE-bench Verified | **77.2** | 76.2 |
| SWE-bench Pro | **53.5** | 50.9 |
| Terminal-Bench 2.0 | **59.3** | 52.5 |

## 仕様

| 項目 | 値 |
|------|-----|
| パラメータ数 | 27B（密） |
| モデルサイズ | 55.6GB |
| コンテキスト長（デフォルト） | 262,144トークン |
| コンテキスト長（最大） | 1,010,000トークン |
| ライセンス | — |
| 公開場所 | Hugging Face、ModelScope |

## 意義

前世代の397B MoEモデル（807GB）が**27B密モデル（55.6GB）に凌駕された**ことは、モデル効率化の急速な進歩を示す。エージェンティックなコーディングタスクにおいて、大きなモデルが必ずしも有利ではないことを実証した。

## 関連ページ
- [[wiki/kimi-k2-6]] — Kimi K2.6 オープンソースコーディングモデル（同期間の競合）
- [[wiki/typescript-7-beta]] — TypeScript 7.0 Beta（コーディングモデルが扱う言語進化）
- [[wiki/bitnet-cpp]] — Microsoft 1.58bit量子化モデル（効率化の別アプローチ）
