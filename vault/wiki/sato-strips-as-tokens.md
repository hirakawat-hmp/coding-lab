---
type: entity
status: []
tags:
  - media/3d
  - ai/llm
sources:
  - "https://3dnchu.com/archives/sato-strips-as-tokens/"
created: 2026-04-16
updated: 2026-04-16
---

# SATO: Strips as Tokens — アーティスト品質 3D メッシュ生成 AI

香港大学・Deemos Technology・上海科技大学・山東大学・テキサス A&M 大学の共同研究（2026年4月15日発表）。SIGGRAPH 2026 条件付き採択。三角ストリップ着想のトークン順序付けで、アーティスト品質の 3D メッシュと UV マップを同時生成する。

## 問題意識

既存の自己回帰 Transformer による 3D メッシュ生成は、トークン順序付け戦略がプロのアーティスト基準を満たさない。生成されるメッシュはトポロジーが乱雑で、UV シームの配置がアーティストのワークフローに適合しない。

## SATO のアプローチ

### 三角ストリップ着想のトークン順序
UV 境界を明示的にエンコードした「連鎖フェイス列（Connected Chains of Faces）」として表現。これにより：
- **整然としたエッジフロー:** アーティスト製メッシュの特徴を自然に保持
- **セマンティックレイアウト:** 意味のある UV 分割が自動生成

### 統合表現フォーマット
単一フォーマットで三角メッシュ・クワッドメッシュの両方をデコード可能。両データタイプでの共同学習を実現。

## 生成物の特徴

1. クリーントポロジー（整理されたエッジループ）
2. 軽量メッシュ（効率的なポリゴン数）
3. UV マップの同時生成

## 技術仕様

- **論文投稿:** SIGGRAPH 2026（2026年7月19日）条件付き採択
- **公開予定:** Hyper3D プラットフォーム経由
- **コード:** 未公開（発表時点）

## 関連ページ

- [[wiki/meshtailor]] — グラフ Transformer による 3D メッシュ UV シーム自動生成 AI（類似研究）
- [[wiki/vray-blender-community]] — V-Ray for Blender Community Edition（同日発表 3D ツール）
