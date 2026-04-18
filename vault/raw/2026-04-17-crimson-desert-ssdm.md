# Crimson Desert の疑似3D表現技術 — SPOM / SSDM 解析

**Source:** https://3dnchu.com/archives/crimson-desert-spom-ssdm/
**Fetched:** 2026-04-18
**Published:** 2026-04-17

## 調査対象

2026年3月19日発売のゲーム「Crimson Desert」が採用している疑似3D（視差マッピング系）レンダリング技術の解析。

## 検討技術3種

### SPOM (Silhouette Parallax Occlusion Mapping)
- 従来の視差マッピングを拡張し、シルエット生成も追加
- 深度感を提供しながらエッジ定義を維持
- 2000年代から存在（CryEngine でも使用）
- フリッカーとスクリーンエッジ歪みのアーティファクトあり

### PPOM (Prism Parallax Occlusion Mapping)
- 精確なシルエット生成
- 計算コストが高く実用例が限られる

### SSDM (Screen Space Displacement Mapping)
- UV ベースではなくスクリーンスペースで動作
- シーン情報を用いてレンダリング後に変位を再計算
- 広範なシーン要素に適用可能
- 著者は Crimson Desert の実際の実装がこれである可能性を示唆

## コミュニティ実装

- **Godot:** Amose05 が SPOM シェーダーを Godot Shaders プラットフォームで公開
- **UE5:** Mestaria が Relaxed Cone Step Mapping を実装、kicol5 が POM 拡張チュートリアルを公開

## 制限事項

フリッカーアーティファクト・視点依存の破綻・深度の不整合
