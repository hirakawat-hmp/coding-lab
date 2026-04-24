---
type: entity
status: []
tags:
  - infra/gcp
  - ai/llm
  - infra/hardware
sources:
  - "https://developers.googleblog.com/torchtpu-running-pytorch-natively-on-tpus-at-google-scale/"
created: 2026-04-24
updated: 2026-04-24
---

# TorchTPU

Google が発表した、TPU（Tensor Processing Unit）上で PyTorch をネイティブに実行するための統合ソリューション。既存の PyTorch ワークロードを最小限のコード変更で TPU にポーティング可能。

## 3つのイーガー実行モード

| モード | 説明 | 用途 |
|--------|------|------|
| **デバッグイーガー** | 操作を1つずつ同期実行 | デバッグ用 |
| **ストリクトイーガー** | 非同期実行で PyTorch 標準体験を再現 | 標準利用 |
| **フューズドイーガー** | 操作を大きな計算チャンクに融合 | 高性能 |

フューズドイーガーモードでは **50〜100%以上の性能向上**を実現。

## コンパイル戦略

- バックエンドコンパイラ: **XLA**
- 中間表現: **StableHLO**
- インターフェース: `torch.compile` 完全サポート

## 分散訓練サポート

- **DDP**（DistributedDataParallel）
- **FSDPv2**（Fully Sharded Data Parallel v2）
- **PyTorch DTensor**
- **MPMD**（Multiple Program Multiple Data）— 異なるランク間で異なるコードを実行可能

従来の PyTorch/XLA の制限（純粋な SPMD コードのみ）を克服し、実際の学習コードに近い柔軟性を提供。

## 2026 年ロードマップ

- GitHub リポジトリの公開
- Helion DSL（ドメイン特化言語）統合
- 動的形状への直接サポート
- マルチキュー機能
- **vLLM** および **TorchTitan** との深い統合

## 関連ページ

- [[wiki/google-tpu-8]] — Google 第8世代TPU（8t・8i）
- [[wiki/google-cloud-next-2026]] — Google Cloud Next 2026 全体まとめ
- [[wiki/google-agentic-data-cloud]] — Google Agentic Data Cloud
