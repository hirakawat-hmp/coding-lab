---
type: entity
status: []
tags:
  - tool/officecli
  - ai/agent
sources:
  - "https://github.com/iOfficeAI/AionUi"
created: 2026-04-14
updated: 2026-04-14
---

# AionUi

iOfficeAI が開発するオープンソースのデスクトップアプリケーション。自然言語で Office ドキュメント（Word / Excel / PowerPoint）を作成・編集できる GUI フロントエンドで、バックエンドに [[wiki/officecli]] を使用する。

## 概要

| 項目 | 詳細 |
|------|------|
| リポジトリ | [iOfficeAI/AionUi](https://github.com/iOfficeAI/AionUi) |
| ライセンス | オープンソース |
| 種別 | デスクトップアプリ（Cowork アプリ） |
| 対応 AI | 20+ プラットフォーム（クラウド・ローカル） |

## 特徴

- **自然言語 UI**: テキストで指示するだけで Office ドキュメントを作成・編集
- **OfficeCLI 内蔵**: [[wiki/officecli]] をバックエンドとして使い、PPT（Morph 対応）、Word、Excel を操作
- **マルチ AI 対応**: Gemini CLI、Claude Code、Codex、OpenCode、Qwen Code、Goose CLI、Auggie 等 20+ の AI プラットフォームに対応
- **12 プロフェッショナルアシスタント**: 定義済みの専門スキルを持つアシスタント群。カスタムスキルで拡張可能
- **ローカル実行**: フリー、ローカル動作、24/7 稼働可能

## OfficeCLI との関係

OfficeCLI が CLI ベースのエンジン（AI エージェント・開発者向け）であるのに対し、AionUi はそのエンジンの上に構築された GUI アプリケーション（エンドユーザー向け）。OfficeCLI 単体でも使えるが、AionUi を通じてより直感的に利用できる。

## 関連ページ

- [[wiki/officecli]] — AionUi のバックエンドとなる CLI ツール
