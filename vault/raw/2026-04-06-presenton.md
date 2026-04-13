---
url: "https://github.com/presenton/presenton"
title: "presenton — OSS AI プレゼンテーション生成プラットフォーム"
date_fetched: 2026-04-06
---

# presenton

Gamma / Beautiful.ai の OSS 代替。セルフホスト型 AI プレゼン生成ツール。

## Tech Stack

- Frontend: Next.js + TypeScript (78.2%)
- Backend: FastAPI (Python 3.11+)
- Desktop: Electron
- テンプレート: HTML + Tailwind CSS
- コンテナ: Docker（GPU サポート）

## パイプライン

1. Input: プロンプト / ドキュメントアップロード / slides_markdown 配列
2. LLM 生成: OpenAI, Gemini, Claude, Ollama, OpenAI互換エンドポイント
3. スライド作成: 個別スライドコンテンツ生成（Web 検索グラウンディング対応）
4. 画像統合: DALL-E 3, Gemini Flash, Pexels, Pixabay, ComfyUI
5. レンダリング: テンプレートシステムで最終形式にコンパイル
6. エクスポート: PPTX / PDF

## テーマシステム

- 名前付きテンプレート（デフォルト: "general"）
- tone パラメータ: default, casual, professional, funny, educational, sales_pitch
- verbosity: concise, standard, text-heavy
- タイトルスライド、目次の有無切替

## 特徴

- BYOK (Bring Your Own Key) — APIキー持ち込み
- 完全ローカル実行可能
- MCP サーバー統合あり
- Docker ワンコマンドデプロイ
