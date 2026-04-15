---
type: entity
status: []
tags:
  - ai/llm
  - security/web
sources:
  - "https://openai.com/index/scaling-trusted-access-for-cyber-defense/"
  - "https://9to5mac.com/2026/04/14/openai-unveils-gpt-5-4-cyber-an-ai-model-for-defensive-cybersecurity/"
created: 2026-04-15
updated: 2026-04-15
---

# GPT-5.4-Cyber

OpenAI が 2026年4月14日に発表した防御的サイバーセキュリティ向け特化モデル。Anthropic の Claude Mythos 発表から 1 週間後に公開され、AI サイバーセキュリティ競争の激化を示す。

## 概要

GPT-5.4 を防御的サイバーセキュリティ用途に微調整したモデル。バイナリリバースエンジニアリング能力を含む、正当なセキュリティ作業に対する拒否率を引き下げた。

## 特徴

- **拒否率の低減**: 正当なセキュリティ作業での「不必要な摩擦」を解消
- **バイナリリバースエンジニアリング**: 静的/動的解析を AI で支援
- **脆弱性研究**: 詳細な脆弱性分析と調査が可能
- **デュアルユースクエリ**: 従来モデルが拒否していた合法的セキュリティクエリへの対応

## Trusted Access for Cyber プログラム

2026年初頭に開始した OpenAI のサイバーセキュリティ施策の拡張版。

### アクセス制御

モデルがより許可的なため、段階的・限定的な展開:
- **ベット済みセキュリティベンダー**: 最上位アクセス（GPT-5.4-Cyber）
- **認定研究者・組織**: 段階的に拡大
- **一般公開**: 当面は制限あり

### 目的

脆弱性研究者・CISO・セキュリティオペレーターが「医療や法律の専門家と同様に」AI から制限なく支援を受けられる環境の整備。

## Anthropic Mythos との比較

| 項目 | GPT-5.4-Cyber | Claude Mythos |
|------|--------------|---------------|
| 発表日 | 2026-04-14 | 2026-04-07 |
| 主な能力 | バイナリ解析・脆弱性研究 | エクスプロイトチェーン発見・自律攻撃 |
| アクセス方針 | 段階的・限定公開 | Project Glasswing コンソーシアム限定 |

## 重要性

- AI によるサイバーセキュリティ競争が本格化
- OpenAI と Anthropic が相次いでサイバー特化モデルを発表
- 「防御」目的とはいえ、能力の汎用性が倫理的な懸念点

## 関連ページ

- [[wiki/claude-mythos]] — Anthropic の対抗モデル（1週間先行）
- [[wiki/n-day-bench]] — LLM による N-Day 脆弱性発見ベンチマーク
