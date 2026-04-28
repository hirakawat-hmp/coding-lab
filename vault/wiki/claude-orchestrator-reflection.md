---
type: insight
status: []
tags:
  - tool/claude-code
  - ai/agent
sources:
  - "https://zenn.dev/yamk/articles/dark-part-time-job-orchestrator"
created: 2026-04-28
updated: 2026-04-28
---

# Claude Codeで作ったAIオーケストレータを使わなくなった理由

自作のマルチエージェントオーケストレーションシステム（dark-part-time-job）を構築したが、モデル能力の向上とツール側の機能拡張により、半年後には使わなくなったという実践的な振り返り。

## システムの概要

**解決したかった問題**：「コンテキストの混線」
→ 長いタスクで全体方針・試行錯誤・エラーログが1セッションに混在

**アーキテクチャ：**
```
監督者（Claude Opus） — 全体方針・進捗管理
  └── 若頭 — YAMLでタスク分割
       └── ワーカーA, B, C（Codex） — 並列実装
```

`.yamibaito/` ディレクトリで既存リポジトリに後付け可能な設計。tmux別ペインで役割分離、git worktreeで作業を独立化。

## 衰退した4つの原因

### 1. 仕組みの複雑化
「自動化するための自動化」が必要になった。YAMLキュー管理、レポート回収システムなど副次的な作業が増加。

### 2. プロンプトの肥大化
コンテキスト節約のために役割分離したのに、役割を賢くするプロンプトがコンテキストを圧迫する**逆説的な悪循環**。

### 3. モデル能力の進化
Claude Code のコーディング能力向上により、Claude 単体で実装と監督の両立が可能に。

### 4. ツール側の機能拡張
Claude Code の **Subagent と Skills 機能**、OpenAI Codex プラグインの提供により自作オーケストレータの存在意義が消失。

## 現在の運用（より単純なアプローチ）

| 用途 | ツール |
|------|--------|
| 軽い実装・調べ物 | Codex ネイティブアプリ（Automations） |
| 本格的な開発 | Claude Code + Subagent + Skills |
| レビュー・QA補助 | Codex プラグイン |

## 核心的な学び

**「AIを複数並べれば自動的に高速化するわけではない」**

本当の課題は並列実行そのものではなく：
- 判断分離の**境界設定**
- 状態管理設計
- レビュー機構
- 人間の介入ポイント

**「人間が把握できるサイズの自動化を積み重ねる方が実用的」**

## 関連

- [[wiki/claude-code-precompact-hook]] — Claude Code のコンテキスト管理
- [[wiki/ai-agent-db-destruction-pocketos]] — 自律的なエージェント判断のリスク事例
- [[wiki/agentic-uat]] — 適切な自動化の設計例
- [[wiki/zed-parallel-agents]] — エディタレベルでの並列エージェント設計
