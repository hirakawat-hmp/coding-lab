# Light Propagation Volumes (Global Illumination) v1.0 for UE5

Source: 3dnchu https://3dnchu.com/archives/light-propagation-volumes-v1-0/
Fetched: 2026-04-28

## 概要

Dmitry Karpukhin氏が開発したUE5向けカスタムGIプラグイン。「残像が無く軽量なGI表現」を実現する拡散グローバルイルミネーション(DGI)レンダリング手法。

## 技術的特徴

「太陽からの反射光を近似して表現」する仕組み。2009年にCrytekが初めて提案したLight Propagation Volumes理論を実装。

主な機能：
- **即時反応性**：「ライティングの変化に瞬時に反応（残像や時間的ノイズなし）」
- **カスケードシステム**：光の到達距離を延長
- **オクルージョン実装**：「SDF基づくオクルージョンにより、光の漏れを大幅に防止」
- Sky AtmosphereおよびVolumetric Cloud Shadowsに対応
- DX12およびVulkanサポート
- ステレオレンダリング対応

## パフォーマンス特性

「ゲームに最適なパフォーマンス」、「動作させるために特別な設定は不要」

## 制限事項

- Deferredレンダラーのみ対応（Forwardレンダラー未対応）
- 物理的正確性は低く、シネマティック映像に不適切
- 低解像度のため光漏れは避けられない

## 価格・販売

個人向け：$89.99、プロ向け：$699.99 (Fab上で販売)
