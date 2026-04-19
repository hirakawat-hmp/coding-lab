# PrologでLLMの論理推論を強化するMCPサーバーを作ってみた

**Source:** https://qiita.com/rikarazome/items/d78fcb4a810035493c23
**Fetched:** 2026-04-19
**Published:** 2026-04-18
**Author:** @rikarazome

## 概要

SWI-Prolog と Claude を統合する MCP サーバー「prolog-reasoner」。LLM が苦手とする制約充足・組合せ問題の論理推論を強化する。

## 解決する問題

LLM 単体では苦手な問題:
- 覆面算（SEND + MORE = MONEY）
- ゲーム理論（Nim 石取りゲーム）
- タスク割り当て問題

## アーキテクチャ

「LLM が Prolog コードを生成 → SWI-Prolog が実行 → 結果を返す」

ユーザーは Prolog を知らなくても自動で論理的な問題を解ける。

## ベンチマーク結果（30問の論理問題）

| 手法 | 正答率 |
|------|--------|
| LLM のみ | 73.3% |
| LLM + prolog-reasoner | 90.0% |

- 制約充足問題: 43% → 86%
- 多ステップ推論: 43% → 100%

## 主要機能

- `execute_prolog` ツール: CLP(FD) 対応 Prolog 実行
- ルールベース管理（保存・読み込み・再利用）
- ステートレス設計（再現性確保）

GitHub: https://github.com/rikarazome/prolog-reasoner
