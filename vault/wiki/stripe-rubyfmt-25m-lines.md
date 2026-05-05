---
type: insight
status: []
tags:
  - dev/ruby
  - dev/rust
  - industry/tech
created: 2026-05-05
updated: 2026-05-05
sources:
  - "https://stripe.dev/blog/formatting-an-entire-25-million-line-codebase-overnight-the-rubyfmt-story"
---

# Stripe rubyfmt — 2500万行のコードを一夜でフォーマット

Stripeの開発者生産性チームが、世界最大級のRubyコードベース（2500万行）をRust製フォーマッター「rubyfmt」で一夜にして全自動フォーマットした事例。

## 実施概要

- **コードベースサイズ**: 2500万行のRubyコード（世界最大規模）
- **ツール**: rubyfmt — Rust製のゼロコンフィグ高速フォーマッター
- **実行方法**: 単一の一夜の作業として完了
- **チーム**: Stripe Developer Productivity チーム（Fable Tales、Anna Mason）

## 技術的ポイント

- **ゼロコンフィグ**: 設定なしで即座に動作
- **超高速処理**: Rust実装により大規模コードベースを一晩で処理可能なスループット
- **一括適用**: 段階的なロールアウトではなく、全コードベースを単一オペレーションで処理

## 示唆

大規模コードベースの統一フォーマットは従来「移行コスト」として忌避されがちだったが、高速なツールと計画的な実行で一夜にして完了できることを証明した。Rustによるツール開発が開発者体験を根本的に変えつつある。

## 関連ページ

- [[wiki/typescript-7-beta]] — TypeScript 7.0 Beta（Go製コンパイラで10倍高速化）
- [[wiki/ruby-spinel]] — Matz作RubyのAOTコンパイラSpinel
- [[wiki/jujutsu-jj]] — 現代的VCS（Git+Mercurial統合）
