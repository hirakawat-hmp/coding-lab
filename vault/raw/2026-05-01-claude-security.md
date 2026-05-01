# Claude Security — 公開ベータ発表

source: https://www.itmedia.co.jp/aiplus/articles/2605/01/news051.html
source: https://siliconangle.com/2026/04/30/anthropic-announces-claude-security-public-beta-find-fix-software-vulnerabilities/
source: https://www.anthropic.com/news/claude-code-security
fetched: 2026-05-01

## 概要

Anthropicが2026年5月1日に発表した新ツール。AI生成コード内の脆弱性検出と修正を自動化する。2026年2月に限定プレビュー開始、同日に公開ベータ移行。

## 技術詳細

- Claude Opus 4.7をベースに動作
- データフローとコード解析を実施
- SAST（静的解析）より高度：人間のセキュリティリサーチャーのように推論
- コンポーネント間の相互作用を理解し、データフローをトレース
- 多段階検証プロセスで誤検知を除去
- 重大度（Severity）評価で優先度付け

## 対応プラン

- Claude Enterprise Team版およびMax版で段階的提供
- 限定プレビューから数百社が導入済み
- 既存ツールが見逃してきた年単位の脆弱性も発見

## 関連プロジェクト

Project Glasswing: 関連セキュリティ対策プロジェクト（詳細未公開）

## 500+脆弱性発見実績

公開ベータ前の段階で500件超の脆弱性を発見・修正済み。
