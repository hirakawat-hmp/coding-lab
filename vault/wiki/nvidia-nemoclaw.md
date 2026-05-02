---
type: entity
status: []
tags:
  - ai/agent
  - security/web
  - infra/hardware
sources:
  - "https://atmarkit.itmedia.co.jp/ait/articles/2605/01/news057.html"
created: 2026-05-02
updated: 2026-05-02
---

# NVIDIA NemoClaw

![NVIDIA NemoClaw](https://image.itmedia.co.jp/ait/articles/2605/01/ait_260501_abi_research_nemoclaw1.jpg)

NVIDIA が GTC 2026 カンファレンスで発表した、AIエージェント向けセキュリティスタック。オープンソースの「OpenClaw」プラットフォームにエンタープライズグレードのセキュリティ機能を追加したもの。

## 概要

| 項目 | 内容 |
|------|------|
| 発表 | GTC 2026（NVIDIA） |
| ベース | OpenClaw（2026年1月公開・OSS） |
| 目的 | AIエージェントの特権アクセスをセキュアに管理 |
| 分析 | ABI Research |

## OpenClaw の特徴

- ローカルデバイスのファイルやツールに**統一的かつ自動的にタスク実行**できるシステム
- AIエージェントが「デバイスリモートアクセス」を必要とする設計

## 特権リスク（Clawブーム）

AIエージェントの普及（**Clawブーム**）とともに、「デバイスに対する広範な特権を持つエージェントをどう統制するか」という問題が顕在化している。

ABI Research は「OpenClaw の設計上、ガバナンスとセキュリティの大きな課題がある」と指摘。

## NemoClaw の対応策

**OpenShell レイヤー**を通じて以下を管理：
- エージェントのデータアクセス制御
- ツール使用権限の管理
- ユーザー設定ポリシー

## 文脈

AIエージェントへの特権付与リスクは [[wiki/mcp-gateway-google-sa]] や [[wiki/mcp-security-vulnerability-2026]] でも取り上げられており、2026年のAIセキュリティの主要テーマの一つ。

## 関連ページ

- [[wiki/mcp-security-vulnerability-2026]] — MCP のシステム的脆弱性 6件
- [[wiki/mcp-gateway-google-sa]] — MCP ゲートウェイと Google SA：AI への過剰権限付与を防ぐ設計
- [[wiki/aws-frontier-agents]] — AWS DevOps Agent / Security Agent（GA）
- [[wiki/claude-security]] — Anthropic のAIコードセキュリティツール
