---
type: concept
status: [draft]
tags:
  - ai/llm
sources:
  - "https://zenn.dev/playree/articles/2376eee1d9d24d"
created: 2026-04-15
updated: 2026-04-15
---

# ローカル LLM デュアル GPU 構成（32GB VRAM コスパ重視）

RTX 5090 の高コストを避け、RTX 5060 Ti を 2 枚挿しすることで 32GB VRAM を低コストで実現するローカル LLM 環境の構築手法。2026年4月の実験報告。

## 構成コンセプト

LLM 推論において**VRAM 容量**は**GPU 演算性能**より重要な場合が多い。同じコストなら高性能 1 枚より、大容量 2 枚のほうが大きなモデルを実行できる。

## 推奨ハードウェア構成

| コンポーネント | 選択 | 理由 |
|-------------|------|------|
| GPU | RTX 5060 Ti 16GB × 2 | 合計 32GB、~20万円（RTX 5090 は ~60万円）|
| 電源 | 1000W | 2 GPU + システム合計で余裕を持つ |
| CPU | Intel 14th gen 以降推奨 | CPU 直結 PCIe x8/x8 対応のため |
| OS | Ubuntu 25.10+ | 新しい GPU ドライバーサポートに必要 |

## マザーボード選定の罠

### 問題: PCIe x16/x4 構成

多くのマザーボードは 2 枚挿し時に x16/x4 の帯域配分になる。x4 になった GPU が**ボトルネック**となる。

### 解決: CPU 直結 x8/x8 対応マザー

| マザーボード | チップセット |
|------------|------------|
| MSI MPG Z890 CARBON WIFI | Z890 |
| ASUS ProArt Z890-CREATOR WIFI | Z890 |

### 物理的な落とし穴

2 枚目 GPU がマザーボードの PCIe 補助電源コネクタを塞ぐ場合がある。**直角アダプターケーブル**で解決。

## パフォーマンス

Gemma4 26B (Ollama): 各 GPU ~12GB VRAM 使用、実用的な推論速度を実現。

## RTX 5060 Ti の特徴

- PCIe 5.0 x8 ネイティブ対応（デュアル構成に最適）
- 消費電力: 180W/枚（合計 360W、RTX 5090 の 575W より低い）
- GDDR7 メモリ

## 注意事項

- NVLink 非対応（VRAM は物理的に分割されたまま）
- モデルのテンソル並列化が必要（Ollama は自動対応）
- Ubuntu 25.10 以上が新ドライバーに必要

## 関連ページ

- [[wiki/gemma4-on-device]] — スマートフォン向けオンデバイス LLM
- [[wiki/bitnet-cpp]] — CPU 単体での LLM 実行
