---
type: concept
status: []
tags:
  - ai/llm
  - industry/tech
sources:
  - "https://atmarkit.itmedia.co.jp/ait/articles/2604/27/news012.html"
created: 2026-04-27
updated: 2026-04-27
---

# Tokenmaxxing

![Tokenmaxxing](https://image.itmedia.co.jp/ait/articles/2604/27/di-tokenmaxxing-concept.png)

AI モデルとの対話において消費するトークン数を最大化する行動パターン・考え方。RPG の「min-maxing（ミニマックシング）」から派生した造語。シリコンバレーで 2026 年頃から広まりつつある。

## 定義

「AI が処理する基本単位であるトークンを可能な限り多く消費することで、AI サービスの利用効率を上げよう」という発想。AI をより多く・深く使うことがエンジニアの仕事になるという考え方を指す。

## 推進側の主張

| 人物・組織 | 発言・施策 |
|---------|----------|
| NVIDIA ジェンセン・ファン CEO | 「全エンジニアに年間トークン消費目標が必要になる」「エンジニアの生産性が 10 倍向上する可能性」 |
| Meta（Claudenomics プログラム） | RPG プレイヤー的な AI 利用者にトークン消費インセンティブを付与 |

## 批判側の主張

| 人物・組織 | 代替指標・意見 |
|---------|-------------|
| HubSpot CEO | 「Tokenmaxxing ではなく Outcome maxxing（成果最大化）が重要」 |
| Salesforce | 「Agentic Work Units（AWU）」という代替指標を提案。実質的なタスク完了を重視 |

## 懸念点

1. **トークン消費量 ≠ 生産性向上**: 単純に多く使えばよいわけではなく、出力品質との相関が不明確
2. **コスト管理の難化**: トークン消費を奨励するカルチャーが FinOps（クラウドコスト最適化）と矛盾する
3. **役割の曖昧化**: 「AI を使わないエンジニアは仕事をしていない」という圧力が生まれる

## コンテキスト

[[wiki/claude-code-tokenocalypse]] で報告されたような「トークン爆発問題」と表裏一体の概念。Tokenmaxxing を推進する側は爆増するトークンを歓迎するが、FinOps の観点からは管理対象となる。

## 関連ページ

- [[wiki/claude-code-tokenocalypse]] — Claude Code v2.1.88 でのトークン 3〜50 倍爆発問題
- [[wiki/ai-adoption-executive-gap]] — AI 導入における経営層 70% vs 現場 38% の認識ギャップ
- [[wiki/claude-code-enterprise-adoption-2026]] — エンタープライズにおける Claude Code の実際の導入効果
