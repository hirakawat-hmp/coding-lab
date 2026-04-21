---
type: entity
status: []
tags:
  - tool/claude-code
  - ai/agent
  - design/system
sources:
  - "https://www.anthropic.com/news/claude-design-anthropic-labs"
created: 2026-04-18
updated: 2026-04-21
---

# Claude Design

![Claude Design](https://www-cdn.anthropic.com/images/4zrzovbb/website/33dbe8f783d4835a838b4c4ae85d3c04e352fee1-1000x1000.svg)

Anthropic Labs が 2026年4月17日に発表したビジュアルデザイン協働ツール。
Claude Opus 4.7 を活用し、デザイン・プロトタイプ・スライド・マーケティング素材を
ユーザーと共同制作する。Claude Pro / Max / Team / Enterprise のリサーチプレビューで利用可能。

## 主な機能

- **ブランド統合:** コードベースやデザインファイルから組織のデザインシステムを自動構築・適用
- **フレキシブル入力:** テキストプロンプト・画像アップロード・ドキュメント（DOCX/PPTX/XLSX）・Web キャプチャに対応
- **洗練ツール:** インラインコメント・直接テキスト編集・間隔/色/レイアウトのカスタム調整
- **コラボレーション:** 組織スコープでの表示・編集権限付き共有
- **エクスポート:** 内部URL・フォルダ・Canva・PDF・PPTX・HTML
- **開発ハンドオフ:** Claude Code へのシームレスな実装パッケージング

## ユースケース

インタラクティブプロトタイプ、ワイヤーフレーム、デザイン探索、ピッチデッキ、
マーケティング資材、コード駆動プロトタイプ

## パートナー・実績

- Canva・Brilliant が統合を進めている
- Datadog: 1週間かかっていたデザインサイクルが1会話で完結
- アクセス: claude.ai/design
- Enterprise 管理者は Organization 設定で機能を有効化

## 市場インパクト（2026年4月20日）

Claude Design のリリース（4月17日）を受け、競合デザインツールの株価が急落：

| 企業 | 株価変動 |
|------|---------|
| Figma | **-7%** |
| Adobe | -2.7% |
| Wix | -4.7% |

Qiita での技術評価（2026-04-20）では「5〜15秒で初期デザインを生成」「Figma ファイルや手書きスケッチを入力として受け付ける」など実用レベルに達していると評価される一方、トークン消費量の多さと Undo の挙動（全セッションリセット）が課題として指摘されている。

## 関連ページ

- [[wiki/claude-code-desktop-parallel]] — Claude Code Desktop との連携（設計ハンドオフ）
- [[wiki/ai-pptx-generation-overview]] — AI による PPTX 生成の全体像
- [[wiki/openai-agents-sdk-v2]] — OpenAI 側の競合アプローチ
