---
type: entity
status: []
tags:
  - media/3d
sources:
  - "https://3dnchu.com/archives/zibragds-open-beta/"
created: 2026-04-30
updated: 2026-04-30
---

# ZibraGDS — UE5向け高速ジオメトリシーケンス再生プラグイン（Open Beta）

## 概要

ZibraAI が2026年4月29日にオープンベータを公開した Unreal Engine 5 向けプラグイン。巨大なアニメーションジオメトリシーケンス（Alembic キャッシュ等）をリアルタイムで超高速・軽量再生することを目的とする。

## 性能比較

| 指標 | ZibraGDS | 標準 Geometry Sequences |
|------|----------|------------------------|
| 再生速度 | 標準比 **6〜10倍** 高速 | ベースライン |
| ファイルサイズ | 最大 **92% 削減** | ベースライン |
| 最大ポリゴン/フレーム | 数百万ポリゴン（安定） | 制限あり |
| 100GB+ Alembic | クラッシュなし対応 | 困難 |

## 対応データ

位置（Position）・法線（Normals）・速度（Velocity）・色（Color）・UV・マルチマテリアル

## UE バージョン対応

UE 5.3 〜 5.7

## Beta 特典

- フル ZibraGDS Unreal プラグイン（無料）
- 1ヶ月間のベータライセンス
- テストアセット段階的公開

## ターゲットユーザー

VFX アーティスト・リアルタイム映像制作者。特に複雑なシミュレーション（流体・破壊・群衆）を UE5 でリアルタイム再生する用途。

## 関連ページ

- [[wiki/liveactionaov-vfx]] — LiveActionAOV（実写映像から AI で AOV パス抽出）
- [[wiki/sato-strips-as-tokens]] — SATO: アーティスト品質 3D メッシュ生成 AI
