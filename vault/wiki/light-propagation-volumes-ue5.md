---
type: entity
status: []
tags:
  - media/3d
sources:
  - "https://3dnchu.com/archives/light-propagation-volumes-v1-0/"
created: 2026-04-28
updated: 2026-04-28
---

# Light Propagation Volumes (GI) v1.0 for UE5

Dmitry Karpukhin 氏が開発した Unreal Engine 5 向けカスタムグローバルイルミネーション（GI）プラグイン。「残像なし・軽量なGI表現」を実現する拡散グローバルイルミネーション（DGI）手法。

## 技術的背景

2009年にCrytekが提案したLight Propagation Volumes（LPV）理論を UE5 向けに実装。「太陽からの反射光を近似して表現」するアプローチで、リアルタイムゲーム向けのパフォーマンスを優先。

## 主要機能

| 機能 | 詳細 |
|------|------|
| 即時反応性 | ライティング変化に瞬時に反応（残像・時間的ノイズなし） |
| カスケードシステム | 光の到達距離を延長 |
| SDF オクルージョン | SDF基づくオクルージョンで光漏れを大幅に防止 |
| Sky Atmosphere 対応 | ✓ |
| Volumetric Cloud Shadows 対応 | ✓ |
| DX12 / Vulkan | ✓ |
| ステレオレンダリング | ✓ |

## 制限事項

- **Deferred レンダラーのみ対応**（Forward レンダラー不可）
- 物理的正確性は低い（シネマティック映像には不適）
- 低解像度のため光漏れは避けられない

## 価格

| プラン | 価格 |
|--------|------|
| 個人向け | $89.99 |
| プロ向け | $699.99 |

Fab で販売中。

## 関連

- [[wiki/cinematic-toolkit-ue5]] — UE5 向け三点照明・ショットプリセット（無料）
- [[wiki/niagara-automotive-ue5]] — Niagara Automotive UE5.7 VFX コース
