---
type: entity
status: []
tags:
  - ai/audio-gen
sources:
  - "https://github.com/ace-step/ACE-Step"
  - "https://arxiv.org/abs/2506.00045"
  - "https://arxiv.org/abs/2602.00744"
  - "https://acestep.org/"
created: 2026-04-10
updated: 2026-04-10
---

# ACE-Step

ACE Studio と StepFun が共同開発した**オープンソースの音楽・音声生成基盤モデル**。拡散（Diffusion）ベースと LLM ベースのアプローチを橋渡しし、19 言語対応、1 分の音楽を 2.2 秒で生成できる高速性が特徴。Apache 2.0 ライセンスで公開されている。

## できること

- 歌詞から楽曲を生成（テキスト → 音楽）
- ボーカルクローニング（声質の再現）
- 歌詞編集・リミックス
- 伴奏生成（歌声 → 伴奏）
- 多言語ボーカル生成（英語・中国語・ロシア語・スペイン語・日本語・ドイツ語・フランス語・ポルトガル語・イタリア語・韓国語を含む 19 言語）
- 最大 4 分以上の楽曲生成

## アーキテクチャ

### 主要コンポーネント

| コンポーネント | 役割 |
|------------|------|
| Deep Compression AutoEncoder（DCAE） | 音声の低次元潜在表現を生成（Sana の DCAE を採用） |
| 軽量リニア Transformer | 潜在空間での拡散処理 |
| MERT + m-hubert | 意味的表現の整合性アライメント（REPA）で学習を高速化 |
| LoRA | タスク特化のファインチューニング（フルリトレーニング不要） |

### 生成プロセス

1. 歌詞テキストと条件（スタイル、声質など）を入力
2. REPA（Representation Alignment）で潜在空間を意味的に整合
3. フローマッチング（Flow Matching）で音声潜在ベクトルを生成
4. DCAE デコーダで最終音声に変換

### 変奏生成

トレーニング不要の推論時最適化。trigFlow のノイズ公式を使ったフローマッチングにより、元のスタイルを維持しながら楽曲のバリエーションを生成できる。

## パフォーマンス

### 速度（A100 GPU）

| 指標 | 値 |
|------|---|
| 1 分の音楽生成時間 | 2.2 秒（27 ステップ） |
| リアルタイム係数（RTF） | 27.27×（1 秒で 27.27 秒分の音楽） |
| 4 分の音楽生成時間 | 約 20 秒 |

### モデルサイズと要件

- パラメータ数: 3.5B
- 最低 VRAM: **4GB 未満**（ローカル実行可能）
- v1.5 は軽量 LoRA パーソナライゼーションに対応

### ACE-Step v1.5 評価（Music Arena）

| 指標 | ACE-Step v1.5 | Suno-v5 |
|------|-------------|---------|
| AudioBox CU スコア | 8.09（最高） | - |
| コヒーレンス | 4.72 | - |
| スタイル整合性 | 39.1 | 46.8 |
| 歌詞追従性 | 26.3 | 34.2 |

LLM ベースのモデル（Yue、SongGen）と比較して **15 倍以上高速**。Suno-v4.5 と Suno-v5 の中間の品質評価を達成。

## 他モデルとの比較

| モデル | タイプ | 速度 | 長尺 | オープン |
|-------|------|------|------|--------|
| ACE-Step | 拡散+LLM 融合 | 高速 | ○（4 分+） | ○（Apache 2.0） |
| Yue / SongGen | LLM ベース | 低速（15×遅い） | ○ | △ |
| DiffRhythm | 拡散ベース | 高速 | × | △ |
| Suno v5 | 商用 | - | ○ | × |

## リンク

- [GitHub: ace-step/ACE-Step](https://github.com/ace-step/ACE-Step)
- [GitHub: ace-step/ACE-Step-1.5](https://github.com/ace-step/ACE-Step-1.5)
- [HuggingFace: ACE-Step-v1-3.5B](https://huggingface.co/ACE-Step/ACE-Step-v1-3.5B)
- [公式サイト](https://acestep.org/)
- [arXiv: ACE-Step v1 論文](https://arxiv.org/abs/2506.00045)
- [arXiv: ACE-Step v1.5 論文](https://arxiv.org/abs/2602.00744)
