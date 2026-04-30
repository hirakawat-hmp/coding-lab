# Raw: Mistral Medium 3.5

Source: https://mistral.ai/news/vibe-remote-agents-mistral-medium-3-5
Fetched: 2026-04-30
HN Points: 413 | Comments: 195

## Summary

Mistral AI が 128B Dense モデル「Mistral Medium 3.5」をオープンウェイトで公開。同時にリモートクラウドエージェント機能「Vibe」を発表。

## Model Specs

- パラメータ数: 128B dense
- コンテキストウィンドウ: 256k トークン
- 推論: 可変推論量（configurable reasoning effort）
- ビジョン: カスタムトレーニングエンコーダ（可変解像度・アスペクト比対応）

## Benchmarks

- SWE-Bench Verified: 77.6%（Devstral 2, Qwen3.5 397B を超える）
- τ³-Telecom ベンチマーク: 91.4

## Availability

- Hugging Face でオープンウェイト公開（modified MIT ライセンス）
- API: $1.5/M input tokens、$7.5/M output tokens
- NVIDIA endpoints / NVIDIA NIM 対応

## Vibe Remote Agents

- 非同期コーディングセッションをクラウド上の隔離サンドボックスで実行
- CLI または Le Chat から起動可能
- GitHub, Linear, Jira, Sentry, Slack, Teams と統合
- ローカル CLI セッションをクラウドに転送（履歴・承認状態を維持）
