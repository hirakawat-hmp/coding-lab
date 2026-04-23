---
type: entity
status: []
tags:
  - media/3d
  - ai/agent
  - ai/llm
sources:
  - "https://3dnchu.com/archives/blender-buddy/"
created: 2026-04-23
updated: 2026-04-23
---

# Blender Buddy

CGMatterが開発したBlender向け**ローカル完全動作AIエージェント**アドオン。**APIキー不要**、サードパーティーサービス不要でローカルマシン上で完全動作する（2026年4月22日公開）。

## 概要

- **動作方式**：Llama.cpp を使用してローカルLLMを実行
- **知識ベース**：Blenderのドキュメントを網羅した専用学習済みモデル
- **価格**：無料（Superhive上で配布）
- **開発者**：CGMatter

## 機能

| 機能 | 説明 |
|------|------|
| テキスト質問 | Blenderの操作・APIについて質問 |
| アクションモード | 自然言語でBlender操作を実行 |
| ビジョンモード | スクリーンショットを解析して支援 |
| Web検索 | 最新情報の検索 |

## 動作要件

| 項目 | 要件 |
|------|------|
| Blenderバージョン | 5.1以降 |
| RAM | 16GB以上 |
| ストレージ | 10〜22GB |
| OS | Windows・macOS・Linux |

## 意義

プライバシーを重視するユーザーや、クラウドAPIの従量課金を避けたいユーザー向けの選択肢として登場。ローカルLLMがBlenderの複雑なAPIを理解できるかが実用性の鍵。

## 関連ページ
- [[wiki/freemocap]] — オープンソース・マーカーレスモーションキャプチャ（ローカル動作の3Dツール）
- [[wiki/cinematic-toolkit-ue5]] — UE5向け無料シネマティックツール
- [[wiki/microsoft-foundry-local]] — ローカルAIランタイム
