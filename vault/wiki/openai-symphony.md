---
type: entity
status: []
tags:
  - ai/agent
  - ai/llm
  - tool/gh-cli
sources:
  - "https://openai.com/index/open-source-codex-orchestration-symphony"
created: 2026-04-28
updated: 2026-04-28
---

# OpenAI Symphony — オープンソース AI オーケストレーション仕様

2026年4月27日に OpenAI が発表したオープンソースのエージェントオーケストレーション仕様。Issue トラッカーをエージェントシステムに変換し、エンジニアリング生産性を向上させる。

## 概要

**キャッチコピー**：「Symphony converts issue trackers into agent systems, boosting engineering productivity」

GitHub Issues・Linear などの Issue トラッカーをエージェントのタスクキューとして機能させるオーケストレーション仕様。OpenAI Codex との統合を想定している。

## 主な特徴

- **Issue → エージェントタスク変換**：Issue の内容をエージェントが実行可能なタスクに自動変換
- **オープンソース**：仕様・実装が公開されており、様々なツールとの統合が可能
- **OpenAI Codex との連携**：Codex のエージェント機能を中心としたオーケストレーション

## 位置付け

OpenAI が提唱する「次世代エンジニアリング生産性」のための標準仕様として位置付けられる。Codex Automations と組み合わせることで、Issue ベースの自動化パイプラインを構築できる。

## 関連

- [[wiki/openai-codex-enterprise]] — OpenAI Codex エンタープライズ展開
- [[wiki/claude-orchestrator-reflection]] — 自作オーケストレータとの比較視点
- [[wiki/aws-frontier-agents]] — AWS 側の類似アプローチ
