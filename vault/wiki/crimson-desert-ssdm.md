---
type: entity
status: []
tags:
  - media/3d
sources:
  - "https://3dnchu.com/archives/crimson-desert-spom-ssdm/"
created: 2026-04-18
updated: 2026-04-18
---

# Crimson Desert の疑似 3D レンダリング技術（SPOM / SSDM）

2026年3月19日発売のゲーム「Crimson Desert」が採用している疑似3D表現技術の解析。
3dnchu による技術調査記事（2026年4月17日）。

## 検討された3技術

### SPOM（Silhouette Parallax Occlusion Mapping）
- 従来の POM を拡張してシルエット生成を追加
- 2000年代から存在（CryEngine でも採用）
- **長所:** 深度感を保ちつつエッジを定義
- **短所:** フリッカー、スクリーンエッジ歪みのアーティファクト

### PPOM（Prism Parallax Occlusion Mapping）
- より精確なシルエット生成
- 計算コストが高く実用例が限られる

### SSDM（Screen Space Displacement Mapping）
- スクリーンスペースで動作（UV ベースではない）
- レンダリング後にシーン情報で変位を再計算
- 広範なシーン要素に適用可能
- **著者の結論: Crimson Desert の実装の可能性が最も高い**

## エンジン別の実装情報

| エンジン | 実装者 | 内容 |
|---------|--------|------|
| Godot | Amose05 | SPOM シェーダー（Godot Shaders 公開）|
| UE5 | Mestaria | Relaxed Cone Step Mapping |
| UE5 | kicol5 | POM 拡張チュートリアル |

## 共通の制限事項

- フリッカーアーティファクト
- 視点依存の破綻（極端な角度で機能しなくなる）
- 深度の不整合（オブジェクトとの交差で問題発生）

## 関連ページ

- [[wiki/sato-strips-as-tokens]] — 3D メッシュ生成 AI（SIGGRAPH 2026 採択）
- [[wiki/hitem3d-2]] — プロダクション対応 AI 3D アセット生成
- [[wiki/vray-blender-community]] — V-Ray for Blender レンダリング環境
