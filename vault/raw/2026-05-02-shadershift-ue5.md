# ShaderShift: Engine Shader Overrides for Unreal Engine

source: https://3dnchu.com/archives/shadershift/
retrieved: 2026-05-02

## 概要
Hidden Empire製のUnreal Engineエディタプラグイン。エンジン変更やカスタムビルドなしでシェーダーカスタマイズを実現。

## 主な機能
- トーンマッピング：AgX (Neutral/Golden/Punchy)、Reinhard、Uncharted 2 Style
- ブルーム：Dual Kawase blur、COD-style hierarchical bloom、FFT diffraction spikes、アナモフィックレンズ等
- Diffuse BRDF：Energy Conserving Oren-Nayar、Lambert-Sphere、Gotanda
- Specular BRDF：Multi-Lobe Cinematic rendering

## 動作原理
エンジンシェーダーソースファイル（.usf/.ush）を実行時にパッチ適用しシェーダー再コンパイル。
変更は非破壊的でエディタ終了またはプラグイン無効化時に自動的にリバート。

## 価格
- 個人ライセンス：$69.99
- プロフェッショナルライセンス：$599.99（Fab上販売）
