# Microsoft Foundry Local 正式リリース

source: https://www.publickey1.jp/blog/26/aifoundry_localmaclinux.html
fetched: 2026-04-14

## 概要

マイクロソフトが2026年4月12日に「Foundry Local」の正式版をリリース。
アプリケーションにバンドルしてインストーラで配布できるコンパクトなローカルAI環境。

## 主な特徴

配布方式:
- 開発者はAI環境をアプリにバンドルしてインストーラで提供
- ユーザーはクラウド依存なしに利用可能
- 追加設定・導入作業不要

技術基盤:
- ONNX Runtime と Windows ML を採用
- 実行ハードウェア（GPU / NPU / CPU）に最適化

対応AIモデル:
- GPT OSS, Qwen Family, Deepseek, Whisper, Mistral, Phi など複数モデルから選択
- OpenAI互換のRESTful API

対応環境:
- Windows / Mac / Linux クロスプラットフォーム
- macOS: Metal API でAppleシリコンGPUを活用
- 開発言語: JavaScript, C#, Python, Rust

## 今後の展開

- カタログ充実
- NPU/GPU対応範囲拡大
- リアルタイム音声文字起こし
- 複数アプリ間でのモデル共有機能
