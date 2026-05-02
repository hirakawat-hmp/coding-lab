---
type: entity
status: []
tags:
  - media/3d
sources:
  - "https://3dnchu.com/archives/shadershift/"
created: 2026-05-02
updated: 2026-05-02
---

# ShaderShift

Hidden Empire 製の Unreal Engine エディタプラグイン。**エンジン変更やカスタムビルドなし**でシェーダーカスタマイズを実現する。2026年5月1日に公開。

## 概要

| 項目 | 内容 |
|------|------|
| 開発元 | Hidden Empire |
| 対象 | Unreal Engine |
| 価格 | 個人 $69.99 / プロ $599.99 |
| 配布 | Fab |

## 機能一覧

### トーンマッピング
- AgX（Neutral / Golden / Punchy）
- Reinhard
- Uncharted 2 Style

### ブルームメソッド
- Dual Kawase blur
- COD-style hierarchical bloom
- FFT diffraction spikes
- アナモフィックレンズストリーク
- アニメ/トゥーンエフェクト等

### Diffuse BRDF
- Energy Conserving Oren-Nayar
- Lambert-Sphere
- Gotanda

### Specular BRDF
- Multi-Lobe Cinematic rendering

## 動作原理

エンジンシェーダーソースファイル（`.usf` / `.ush`）を実行時にパッチし、シェーダーを再コンパイル。**全変更は非破壊的**で、エディタ終了またはプラグイン無効化時に自動リバート。

## 利点

- HLSL の専門知識不要
- カスタムエンジンのメンテナンス不要
- チームでのアセット共有が容易
- プロジェクト設定から選択・切り替えが可能

## 関連ページ

- [[wiki/cinematic-toolkit-ue5]] — Cinematic Toolkit for UE5（三点照明・ショットプリセット）
- [[wiki/light-propagation-volumes-ue5]] — Light Propagation Volumes GI v1.0（UE5向けGI）
- [[wiki/ozone-subdivs-ue5]] — Ozone Subdivs（リアルタイムサブディビジョンサーフェス）
