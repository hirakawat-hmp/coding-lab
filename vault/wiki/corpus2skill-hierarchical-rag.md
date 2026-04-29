---
type: concept
status: []
tags:
  - ai/rag
  - ai/agent
  - ai/llm
sources:
  - "https://zenn.dev/knowledgesense/articles/7dddae04a7d828"
created: 2026-04-29
updated: 2026-04-29
---

# Corpus2Skill：ベクトルを使わない階層型 RAG

![Corpus2Skill RAG](https://static.zenn.studio/user-upload/8de5c9aec913-20260425.png)

Atsushi Kadowaki（2026年4月28日）が提案した「Corpus2Skill」は、ベクトルデータベースを排除し、企業知識を階層ディレクトリ構造に整理する RAG 手法。LLM エージェントが目次を辿るようにナビゲートして情報を取得する。

## 問題意識

従来のベクトルベース RAG は「X に関する過去事例をすべて取得して」のような網羅的クエリに弱い。上位 K 件のみを取得するため、情報の網羅性を保証できない。

## アーキテクチャ

### 準備フェーズ（4ステップ）

1. **クラスタリング** — 埋め込み + k-means でドキュメントをグループ化
2. **サマリー化** — LLM がクラスター内容を要約
3. **階層ピラミッド構築** — 反復クラスタリングで親→子の階層構造を生成
4. **ファイル整理** — `SKILL.md`（スキル説明）と `INDEX.md`（インデックス）として出力

### クエリフェーズ

エージェントがトップ階層から下位階層へ関連ディレクトリを辿り、完全なドキュメントセットを取得。人間が書籍の目次をスキャンして章を選ぶ行為を LLM が模倣。

## 特性

| 項目 | 特性 |
|---|---|
| 階層深さ | O(log N)（スケーラブル） |
| ベクトル DB | 不要 |
| ベンチマーク | WixQA で優れた性能 |
| 網羅性 | 高い（ディレクトリ全走査で保証） |

## 本 vault との関連

本 knowledge vault が採用している「パスとタグを指定して明示的に探索する」設計（`vault/CLAUDE.md` 参照）と思想的に近い。エージェントが `SKILL.md` / `INDEX.md` を辿る構造は、`vault/wiki/` + `vault/index.md` の設計と本質的に同一。

## 他手法との比較

- **従来 RAG**: ベクトル検索で上位 K 件 → 網羅性が低い
- **WriteBack-RAG**（[[wiki/writeback-rag]]）: クエリ結果を蒸留してKBを自動改善 → 精度向上
- **Corpus2Skill**: 階層インデックスで網羅的探索 → 完全性が高い

## 関連ページ

- [[wiki/writeback-rag]] — RAG を自動改善する WriteBack 手法
- [[wiki/llm-wiki-pattern]] — LLM + Wiki パターン（Karpathy）
- [[wiki/rag-mcp-sidecar]] — RAG を MCP サイドカーとして配置する設計
- [[wiki/skill-md-pattern]] — SKILL.md パターン（Claude Code の折りたたみ式マニュアル）
