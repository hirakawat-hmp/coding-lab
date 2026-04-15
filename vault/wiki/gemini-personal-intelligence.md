---
type: entity
status: []
tags:
  - ai/agent
  - ai/rag
sources:
  - "https://www.itmedia.co.jp/aiplus/articles/2604/15/news070.html"
created: 2026-04-15
updated: 2026-04-15
---

# Gemini パーソナルインテリジェンス

Google が Gemini に追加した個人データ統合機能。Gmail・Google Photos・GitHub などの個人データを参照しながら、文脈に応じたパーソナライズされた回答を生成する。2026年4月14日より日本でも提供開始。

## 概要

- **名称**: パーソナルインテリジェンス（Personal Intelligence）
- **提供開始**: 2026年4月14日（日本）
- **対象プラン**: Google AI Plus / Pro / Ultra
- **対応プラットフォーム**: Web / Android / iOS

## 対応サービス統合

| カテゴリ | 統合サービス |
|---------|------------|
| Google Workspace | Gmail、Calendar、Keep、Tasks、Docs、Drive |
| メディア | Google Photos、YouTube Music |
| 開発 | GitHub |
| その他 | SynthID |

## 機能の仕組み

1. ユーザーの質問を受信
2. 接続された各サービスのデータを検索・取得
3. 複数ソースからの情報を統合・推論
4. パーソナライズされた回答を生成

### 具体的なユースケース

- ホテルの予約確認を Gmail で検索し、スケジュールを Calendar から統合して旅行計画を整理
- 特定の写真の撮影日時や場所を Google Photos から確認
- GitHub のリポジトリ状況を把握しながら作業の優先順位を提案

## プライバシー設計

- サービスごとにアクセスのオン/オフを個別制御可能
- センシティブデータカテゴリには特別保護を適用
- 処理にはユーザーの明示的な同意が必要
- データはサードパーティに提供しない

## RAG アーキテクチャとの類似点

パーソナルインテリジェンスは実質的に**個人データに対する RAG システム**と見なせる:

| RAG 要素 | パーソナルインテリジェンス実装 |
|---------|---------------------------|
| ベクトルDB | 各 Google サービスのインデックス |
| チャンク化 | メール/写真/カレンダーイベント単位 |
| リトリーバル | サービス横断検索 |
| 生成 | Gemini によるコンテキスト統合 |

## 関連ページ

- [[wiki/writeback-rag]] — RAG の知識ベース自動改善手法
- [[wiki/llm-wiki-pattern]] — ローカル知識ベースパターン
