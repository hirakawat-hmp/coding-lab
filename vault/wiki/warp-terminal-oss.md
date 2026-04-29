---
type: entity
status: []
tags:
  - industry/tech
  - ai/agent
  - dev/rust
sources:
  - "https://www.warp.dev/blog/warp-is-now-open-source"
created: 2026-04-29
updated: 2026-04-29
---

# Warp ターミナルのオープンソース化（2026年4月）

2026年4月28日、AI 支援ターミナル・コーディングツール「Warp」が AGPL ライセンスでオープンソース化を発表。OpenAI がファウンディングスポンサー。CEO Zach Lloyd が公式ブログで経緯と設計思想を説明。

## オープンソース化の設計

### Oz オーケストレーションプラットフォーム
コミュニティ貢献をスケールさせるために、エージェントが実装を担当し、人間（コミュニティメンバー + Warp チーム）が製品方向性と検証に集中するモデルを採用。

> "Humans managing agents at scale to build production-grade software is the model, and implementing this model in the open will allow software to improve most quickly."

### ライセンス・リポジトリ
- ライセンス: AGPL
- 貢献フロー: GitHub でアイデア提出 → Oz エージェントが実装 → コミュニティ・チームがレビュー

## 新機能

- オープンソース AI モデル対応拡張（Kimi・MiniMax・Qwen）
- カスタマイズオプション: 基本ターミナル〜フル IDE まで
- プログラマティック制御 + デバイス間ポータビリティのための設定ファイル

## 戦略的意図

「価格競争ではなく、より優れた製品と関与したコミュニティで競争する」という方針。AI 時代の OSS モデルとして、エージェントを用いたコントリビューション管理が新しい事例となる。

## 関連ページ

- [[wiki/ghostty-leaving-github]] — GitHub 依存からの脱却（同じく開発者ツール動向）
- [[wiki/zed-parallel-agents]] — 類似の AI エージェント統合エディタ
- [[wiki/cursor-3]] — AI コードエディタの競合製品
- [[wiki/ai-era-engineering-shift]] — AI 時代のエンジニアリング変革
