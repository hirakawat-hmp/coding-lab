---
type: entity
status: []
tags:
  - tool/presenton
  - dev/typescript
  - dev/python
  - project/aaas-ai-planner
sources:
  - "[[raw/2026-04-06-presenton]]"
created: 2026-04-06
updated: 2026-04-06
---

# presenton

Gamma / Beautiful.ai の OSS 代替となるセルフホスト型 AI プレゼンテーション生成プラットフォーム。

- **リポジトリ**: https://github.com/presenton/presenton
- **ライセンス**: OSS
- **スター**: 急成長中（2025-2026年）

## アーキテクチャ

```
ユーザー入力 → LLM 生成 → スライド作成 → 画像統合 → テンプレートレンダリング → PPTX/PDF
```

### Tech Stack

| レイヤー | 技術 |
|---------|------|
| Frontend | Next.js + TypeScript (78.2%) |
| Backend | FastAPI (Python 3.11+, 18.7%) |
| Desktop | Electron |
| テンプレート | HTML + Tailwind CSS |
| コンテナ | Docker（GPU サポート） |
| リバースプロキシ | NGINX |

### LLM プロバイダ（マルチ対応）

- OpenAI
- Google Gemini
- Anthropic Claude
- Ollama（ローカル）
- OpenAI 互換エンドポイント（カスタム）

### 画像プロバイダ

- DALL-E 3 / GPT Image 1.5
- Gemini Flash
- Pexels / Pixabay（無料ストック）
- ComfyUI（セルフホスト）

## テーマ・テンプレートシステム

- 名前付きテンプレート（デフォルト: "general"）
- **tone**: default, casual, professional, funny, educational, sales_pitch
- **verbosity**: concise, standard, text-heavy
- タイトルスライド・目次の有無を切替可能
- HTML + Tailwind CSS でカスタムテンプレートを無制限に作成可能

## 入力方式

1. **プロンプト**: テキストで指示
2. **ドキュメントアップロード**: ファイルから変換
3. **slides_markdown 配列**: プリフォーマット済みコンテンツ

## デプロイ

- **Desktop**: `npm run setup:env && npm run dev`
- **Docker**: `docker run -p 5000:80 ghcr.io/presenton/presenton:latest`
- **API**: チーム / エンタープライズ向けにホスト可能

## 差別化要因

- **BYOK**: 既存の API キーを使用（サブスクリプション不要）
- **完全ローカル実行**: Ollama + ComfyUI で外部 API 依存ゼロ
- **MCP サーバー統合**: Claude Code 等のエージェントから直接呼び出し可能

## 関連ページ

- [[wiki/ai-pptx-generation-overview]] — PPTX 生成の全体像
- [[wiki/pptx-generation-comparison]] — アプローチ比較
- [[wiki/pptagent]] — 別の OSS エージェントフレームワーク
