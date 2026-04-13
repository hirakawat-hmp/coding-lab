---
type: entity
status: [needs-review]
tags:
  - ai/video-gen
sources:
  - "https://wavespeed.ai/blog/posts/what-is-happyhorse-1-0-ai-video-model/"
  - "https://blog.laozhang.ai/en/posts/happy-horse-video-ai"
created: 2026-04-10
updated: 2026-04-10
---

# HappyHorse 1.0

2026 年 4 月初旬に**匿名でリーダーボードに出現した動画生成 AI モデル**。Artificial Analysis Video Arena で Seedance 2.0 を約 60 ポイント上回り瞬時に話題となったが、数日後に公開リーダーボードから削除され、オープンソース公開の主張と実態の不一致が指摘されている。**詐欺サイトが多数出現しているため注意が必要**。

> **警告**: happyhorse.app、happy-horse.ai、happyhorse-ai.com 等の有料サービスサイトは公式ではない。公式モデルのステータスは 2026-04 時点で未確認。

## スペック（主張値）

- パラメータ数: **15B** Unified Transformer
- テキスト→動画・画像→動画の統合生成
- 解像度: **1080p**、生成時間 15〜30 秒分の動画
- 生成速度: **約 38 秒**（同条件で Seedance 2.0 より 30〜40% 高速）
- 多言語対応: 北京語・広東語を含む **8 言語**（リップシンク品質が高い）
- 音声-動画結合生成アーキテクチャ（Seedance 2.0 と同様）

## リーダーボード結果

| カテゴリ | スコア（Elo） | 順位 |
|--------|------------|-----|
| テキスト→動画（音声なし） | 1333〜1357 | **歴代 1 位** |
| 画像→動画 | 1391〜1406 | **歴代 1 位（記録更新）** |
| テキスト→動画（音声あり） | Seedance 2.0 に 14pt 差で 2 位 | 2 位 |

## 開発者情報

- 元 Kuaishou VP（快手 副社長）の **Zhang Di** 氏が率いるチーム
- 元アリババ傘下 Taotian Group の Future Life Laboratory（未来生活実験室）出身
- Kling 1.0 / 2.0 の技術アーキテクト

## 公開状況と問題点

| 主張 | 実態（2026-04 時点） |
|-----|------------------|
| オープンソースで GitHub と HuggingFace に公開 | GitHub リポジトリは 404 / HF アカウントは公開モデル 0 件 |
| モデル重みを商用利用可能なライセンスで提供 | ダウンロード不可 |
| 匿名でのリーダーボード登場 | V1・V2 とも数日でリーダーボードから削除 |
| 「まもなくオープンソース公開」と事後追記 | 確認できず |

## 詐欺サイトへの注意

HappyHorse 1.0 の名を騙る有料サービスサイトが 10 以上出現した（happyhorse.app、happy-horse.ai など）。中国 AI コミュニティのメンバーも詐欺サイトについて警告を発している。HappyHorse を使用したい場合は公式アナウンスを待つこと。

## リンク

- [Artificial Analysis での評価（スクリーンショットのみ残存）](https://artificialanalysis.ai/video)
- [解説記事: What is HappyHorse 1.0?](https://wavespeed.ai/blog/posts/what-is-happyhorse-1-0-ai-video-model/)

## 関連ページ

- [[wiki/seedance-2]] — HappyHorse が比較対象として挙げた動画生成モデル
