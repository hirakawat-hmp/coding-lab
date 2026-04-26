---
type: how-to
status: [verified]
tags:
  - ai/llm
  - infra/gcp
sources:
  - "https://dev.classmethod.jp/articles/gemini-gem-googledrive-chatbot/"
created: 2026-04-26
updated: 2026-04-26
---

# Gemini Gem で社内Google Driveチャットボットを作成

![Gemini Gem Drive Chatbot](https://images.ctfassets.net/ct0aopd36mqt/wp-thumbnail-6a331d7c70f1897ca2ef1ad4cbe7c6bf/78c556633ae5115aa065636cc4a1160a/eyecatch_gemini)

Gemini の Gem（システムプロンプト機能）を活用して、社内Google Drive専用のチャットボットを構築する手法。構築作業が非常にシンプルで、コーディング不要。

## 課題

社内のGoogle Driveでファイルが増えると、必要な情報を見つけるのが困難になる。キーワード検索では「記憶しているキーワードと実際のファイル名が一致しない」ケースが頻発。

## 解決策

Gemini の Gem に以下を設定するだけ：

```
システムプロンプト：
「正確に回答してください。
参照ドライブ: [共有ドライブのURL]
```

## 効果

**サイドバーのGeminiより正答率が約4倍高い**（ハルシネーション削減）。

## 運用方法

1. Gemini で新しい Gem を作成
2. システムプロンプトに共有ドライブURLを指定
3. 作成した Gem を「Gemini Gemsフォルダ」から対象ドライブに移動
4. ドライブにアクセス権のあるメンバー全員が利用可能

## 注意点

- システムプロンプト内でドライブURLを指定しても、**ユーザーのアクセス権のある別ドライブの情報も参照することがある**（2026年4月時点の制限）
- 機密情報を扱うドライブでは権限設定の慎重な確認が必要

## 関連ページ

- [[wiki/gemini-personal-intelligence]] — Gemini パーソナルインテリジェンス（Gmail/Photos横断RAG）
- [[wiki/gemini-macos-app]] — Gemini macOSアプリ
