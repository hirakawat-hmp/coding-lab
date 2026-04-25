---
type: insight
status: []
tags:
  - ai/llm
  - industry/tech
sources:
  - "https://developers.openai.com/api/docs/changelog"
  - "https://openai.com/index/introducing-gpt-5-5"
created: 2026-04-25
updated: 2026-04-25
---

# GPT-5.5 API 公開（2026年4月24日）

OpenAI が 2026年4月24日、GPT-5.5 と GPT-5.5 Pro を Chat Completions / Responses API で正式公開した。Hacker News フロントページにも掲載され大きな反響を呼んだ。

## 公開モデル

| モデル | 用途 |
|--------|------|
| **GPT-5.5** | 複雑なプロフェッショナル業務 |
| **GPT-5.5 Pro** | より計算負荷の高い問題解決 |

## 主な仕様

- **コンテキストウィンドウ**：100万トークン
- 画像入力、構造化出力、関数呼び出し
- プロンプトキャッシング（拡張版）
- Batch、ウェブサーチ
- Skills、MCP、ホスト型シェル
- Apply Patch、組み込みコンピュータ使用

## デフォルト設定の変更

- 推論努力（reasoning effort）デフォルト：**「中」**（以前は未設定）
- 拡張プロンプトキャッシュのみサポート（従来型キャッシュは非対応）

## 競合との比較

同時期に DeepSeek-V4（[[wiki/deepseek-v4]]）もリリースされており、AI モデル競争は 2026年4月に一段と激化した。

## 関連ページ

- [[wiki/gpt-5-5]] — GPT-5.5 の詳細エンティティページ
- [[wiki/deepseek-v4]] — DeepSeek-V4（競合オープンソース）
- [[wiki/openai-codex-enterprise]] — OpenAI Codex エンタープライズ展開
