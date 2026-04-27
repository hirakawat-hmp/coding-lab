# LLMアプリケーションにおける設計 Principal — LLMのCAP定理

source: https://zenn.dev/hsaki/articles/llm-cap-theorem
fetched: 2026-04-27

## 概要

分散システムの CAP 定理（Consistency / Availability / Partition Tolerance）の概念を LLM アプリケーション設計に適用した独創的なフレームワーク。

## LLM の CAP 定理

3 要素が同時に成立しない:

- C（一貫性）: 全ユーザーに同一モデルを使用して出力品質を安定化
- A（可用性）: TPM/RPM のクオータ制限を回避し、LLM が継続応答
- P（価格）: 安価な値段で LLM を利用できる

## 3 つの戦略パターン

- CA 選択（高品質・高可用性）: Reserved Tier / Provisioned Throughput でコスト増加
- CP 選択（品質・低コスト）: 単一モデル従量課金、RPM/TPM 超過で 429 エラー発生
- AP 選択（可用性・低コスト）: 複数モデルフォールバック、出力品質が不均一

## スループット型 SLI

LLM は TPM/RPM ベースのスループット型 SLI を採用。
従来の数値型 SLI（成功率）と本質的に異なる。
ビジネス意思決定との統合が不可欠。
