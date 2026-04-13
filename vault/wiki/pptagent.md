---
tags:
  - entity
sources:
  - "[[raw/2026-04-06-pptagent]]"
created: 2026-04-06
updated: 2026-04-06
---

# PPTAgent

中国科学院（ICIP-CAS）によるリファレンスベースの PPTX 生成エージェントフレームワーク。人間のプレゼン作成プロセスを模倣した2段階 edit-based アプローチを採用。

- **リポジトリ**: https://github.com/icip-cas/PPTAgent
- **PyPI**: https://pypi.org/project/pptagent/
- **言語**: Python

## アーキテクチャ

### 2段階パイプライン

**Stage 1: 分析**
- リファレンスプレゼンテーションを入力
- スライドごとの機能タイプ（タイトル、コンテンツ、まとめ等）を分類
- コンテンツスキーマ（テキスト領域、画像領域、チャート領域）を抽出

**Stage 2: 生成**
- ユーザーの指示からアウトラインをドラフト
- リファレンススライドを選択
- 編集アクション（テキスト置換、画像差替、レイアウト調整）を反復生成
- Reflective（自己反省的）に品質を改善

### V2 の進化（2025年12月）

| 機能 | 説明 |
|------|------|
| Deep Research | Web 検索で最新情報を取得しコンテンツに反映 |
| Free-Form Visual Design | テンプレート不要の自律的デザイン |
| Autonomous Asset Creation | 必要なアセット（図表等）を自動生成 |
| Text-to-Image | スライド用画像の AI 生成 |
| Agent Environment | サンドボックス + 20以上のツール |

2026年1月にフリーフォーム生成 + テンプレート生成の両方で PPTX エクスポートに対応。

## 技術スタック

- [[wiki/python-pptx]] ベース
- Docker サンドボックス（sandbox + host コンテナ構成）
- Web UI + CLI (`pptagent onboard` で対話的セットアップ)
- llama.cpp でローカル LLM 推論対応
- MCP サーバー統合
- Tavily（Web 検索）、MinerU（PDF パース）との外部連携

## 評価指標

多次元評価を採用:
- **Content**: 内容の正確性・網羅性
- **Design**: ビジュアルデザインの品質
- **Coherence**: スライド間の論理的一貫性

## presenton との比較

| 観点 | PPTAgent | [[wiki/presenton]] |
|------|----------|----------|
| アプローチ | リファレンスベース edit | LLM + テンプレートレンダリング |
| デザイン学習 | 既存 PPTX から | HTML/Tailwind テンプレート |
| ローカル LLM | llama.cpp 対応 | Ollama 対応 |
| 成熟度 | V2（研究寄り） | プロダクション指向 |

## 関連ページ

- [[wiki/ai-pptx-generation-overview]] — PPTX 生成の全体像
- [[wiki/pptx-generation-comparison]] — アプローチ比較
- [[wiki/python-pptx]] — 基盤ライブラリ
- [[wiki/presenton]] — 別の OSS プラットフォーム
