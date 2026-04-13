---
type: entity
status: []
tags:
  - ai/llm
sources:
  - "https://github.com/microsoft/BitNet"
  - "https://arxiv.org/abs/2410.16144"
  - "https://arxiv.org/abs/2502.11880"
created: 2026-04-10
updated: 2026-04-10
---

# bitnet.cpp

Microsoft が開発・公開した **1.58ビット量子化 LLM 専用の C++ 推論エンジン**。llama.cpp をベースに Lookup Table（LUT）カーネルを実装することで、GPU を一切使わず CPU 単体で 100B パラメータ規模の大規模モデルを実用速度（5〜7 トークン/秒）で動かすことを可能にした。

## 1.58 ビット量子化（三値量子化）とは

通常の LLM は重みを 16bit や 32bit 浮動小数点で保持する。BitNet b1.58 は重みを **{-1, 0, +1} の三値のみ**に限定する。三値なので log₂(3) ≈ 1.58 ビット/重みとなる。

| 手法 | ビット数 | 乗算 |
|------|---------|------|
| FP16 | 16 bit | あり |
| INT8 | 8 bit | あり |
| BitNet b1.58 | 1.58 bit | **なし（加算のみ）** |

重み量子化には **absmean 量子化**（絶対値の平均でスケーリング）、活性化量子化には **absmax 量子化**（8-bit INT）を使用する。乗算を加算に置き換えられるため、エネルギー効率が劇的に向上する。

## LUT カーネルのしくみ

T-MAC の手法を応用した Lookup Table（LUT）ベースの GEMV（行列ベクトル積）カーネルを採用する。

1. 三値の組み合わせは 3² = 9 通りのみなのであらかじめ計算してテーブルに格納する
2. GEMV 演算は LUT から値を引くだけで実行できる（乗算不要）
3. ハードウェア最適化として 3 種のスキームを用意:
   - **I2_S**: 全プラットフォーム対応の標準 2-bit 量子化
   - **TL1**: ARM NEON 向け LUT 最適化
   - **TL2**: x86 AVX2 向け LUT 最適化

## パフォーマンス指標

### 推論速度（tokens/sec）

| モデル規模 | ハードウェア | 速度 |
|-----------|------------|------|
| 3B | Apple M2 (CPU) | ~6 tokens/sec |
| 3B | Raspberry Pi 5 | ~11 tokens/sec |
| 100B | x86 汎用 CPU | 5〜7 tokens/sec |

### CPU スピードアップ（llama.cpp 比）

| アーキテクチャ | 高速化率 |
|------------|--------|
| x86 CPU | 2.37×〜6.17× |
| ARM CPU | 1.37×〜5.07× |

### エネルギー削減率

| アーキテクチャ | 削減率 |
|------------|------|
| x86 CPU | 71.9%〜82.2% |
| ARM CPU | 55.4%〜70.0% |

## llama.cpp との比較

| 項目 | bitnet.cpp | llama.cpp |
|------|-----------|-----------|
| 対象 | 1.58-bit 三値モデル専用 | 幅広い量子化レベルに対応 |
| CPU 速度 | 最大 6× 高速 | 汎用 |
| エネルギー効率 | x86 で最大 82% 削減 | 比較的高消費 |
| GPU 不要 | ○（CPU のみ） | △（GPU でさらに高速化） |
| コミュニティ | 小さめ | 大きい |

## 対応モデル

- **BitNet b1.58 2B-4T**: 2B パラメータ、4 兆トークンで事前学習した最初のオープンソース native 1-bit LLM

## ユースケース

- GPU/クラウド不要のローカル LLM 実行（プライバシー重視のアプリケーション）
- エッジデバイスや IoT での AI 推論
- 学習・研究目的の低コスト大規模モデル実験
- バッテリー駆動デバイス（省エネ要件が高い環境）

## リンク

- [GitHub: microsoft/BitNet](https://github.com/microsoft/BitNet)
- [arXiv: Fast and Lossless BitNet b1.58 Inference on CPUs](https://arxiv.org/abs/2410.16144)
- [arXiv: Efficient Edge Inference for Ternary LLMs](https://arxiv.org/abs/2502.11880)

## 関連ページ

- [[wiki/triattention]] — LLM 推論効率化の別アプローチ（KV キャッシュ圧縮）
