---
type: entity
status: []
tags:
  - ai/image-gen
sources:
  - "https://bfl.ai/models/flux-2"
  - "https://huggingface.co/blog/flux-2"
  - "https://github.com/black-forest-labs/flux2"
created: 2026-04-10
updated: 2026-04-10
---

# FLUX.2

Black Forest Labs が 2025 年 11 月 25 日にリリースした**次世代画像生成モデルファミリー**。FLUX.1 の後継で、テキスト→画像・画像編集・マルチ参照合成を統一アーキテクチャに統合した。コンパクトな **Klein 4B** バリアントは Apache 2.0 ライセンスで RTX 4070 クラスのコンシューマ GPU でも動作する。

## モデルバリアント

| モデル | パラメータ | ライセンス | VRAM | 特徴 |
|-------|---------|---------|------|-----|
| FLUX.2 [dev] | 32B | 商用 | フル GPU 必要 | プロダクション/商業用 |
| FLUX.2 [pro/flex] | 32B | 独自 | フル GPU 必要 | 高機能バリアント |
| FLUX.2 Klein 9B | 9B | 非商用 | 19.6 GB | 研究用 |
| **FLUX.2 Klein 4B** | **4B** | **Apache 2.0** | **13 GB（量子化で 8.4 GB）** | **コンシューマ GPU 向け** |

**FLUX.2 Small Decoder** は Klein バリアントの VAE デコーダを最適化した構成で、RTX 3090 や RTX 4070 での高速推論を可能にする。

## アーキテクチャ

FLUX.1 の MM-DiT をベースに以下の変更を施した:

### FLUX.1 との差分

| 要素 | FLUX.1 | FLUX.2 |
|-----|-------|-------|
| Transformer ブロック構成 | Double 19 + Single 38 | Double 8 + **Single 48** |
| 時間・ガイダンス変調 | ブロックごとに個別パラメータ | ブロック間で**共有**（効率化） |
| MLP 活性化 | GELU | **SwiGLU**（効率向上） |
| テキストエンコーダ | CLIP + T5 デュアルエンコーダ | **Mistral 3 Small**（単一） |
| 生成方式 | Flow Matching | 同上（RoPE + 4D 位置埋め込み） |

### 3 つの統合機能

1. **テキスト→画像生成**: プロンプトからの高品質画像生成
2. **画像編集**: 既存画像のインペインティング・アウトペインティング
3. **マルチ参照合成**: 最大 10 枚の参照画像を組み合わせた生成

## パフォーマンス

- **最大解像度**: 4MP（メガピクセル）
- **推論速度**: Klein バリアントは 1 秒未満での生成を達成
- 量子化版は最大 **2.7× 高速化** + メモリ大幅削減
- 世界知識・構図において FLUX.1 から大幅改善

## 利用方法

```python
# HuggingFace Diffusers での利用
from diffusers import FluxPipeline

pipe = FluxPipeline.from_pretrained("black-forest-labs/FLUX.2-klein-4B")
image = pipe("A photo of a cat wearing a hat").images[0]
```

## リンク

- [Black Forest Labs 公式](https://bfl.ai/models/flux-2)
- [HuggingFace: FLUX.2-small-decoder](https://huggingface.co/black-forest-labs/FLUX.2-small-decoder)
- [HuggingFace: Diffusers FLUX.2 ガイド](https://huggingface.co/blog/flux-2)
- [GitHub: black-forest-labs/flux2](https://github.com/black-forest-labs/flux2)

## 関連ページ

- [[wiki/seedance-2]] — 同時期の動画生成モデル
- [[wiki/happyhorse-1]] — 同時期の動画生成モデル
