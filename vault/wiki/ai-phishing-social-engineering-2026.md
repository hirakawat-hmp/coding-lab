---
type: insight
status: []
tags:
  - security/web
  - ai/llm
sources:
  - "https://wired.jp/article/ai-model-phishing-attack-cybersecurity/"
created: 2026-04-30
updated: 2026-04-30
---

# AIモデルによるフィッシング・ソーシャルエンジニアリング（2026年）

## 概要

WIRED が報告した実験。主要 AI モデル5つが生成したフィッシング攻撃のリアルな脅威を実証した。Charlemagne Labs が開発したテストプラットフォームを使用。

## テストされたモデル

- Claude 3 Haiku
- GPT-4o
- NVIDIA Nemotron
- DeepSeek-V3
- Alibaba Qwen

5モデルすべてが説得力のある詐欺シナリオを生成することに成功した。

## 具体的な攻撃例

DeepSeek-V3 が WIRED 記者のニュースレターや研究関心を参照したパーソナライズドフィッシングメッセージを生成し、記者自身が「不気味なほど巧妙だった」と評価した。

## 脅威の本質

- 「企業への攻撃の 90% は人的リスクから始まる」（セキュリティ専門家）
- AI の言語推論能力がソーシャルエンジニアリングに直接転用される
- 詐欺師はすでに: メール生成、音声クローニング、ディープフェイク作成に AI を活用
- 攻撃ワークフロー全体の自動化により、1人の攻撃者が前例のない規模でキャンペーンを展開可能

## 対策の方向性

フィッシング検知の従来手法（送信者偽造・スペルミス等）が AI 生成コンテンツには効かない。受信者の行動変容とゼロトラストアーキテクチャが重要。

## 関連ページ

- [[wiki/ai-maga-influencer-scam]] — AI 生成 MAGA 美女インフルエンサー詐欺事例
- [[wiki/deepfake-schools-crisis]] — 学校でのディープフェイク被害
- [[wiki/ai-tool-security-incidents-8-2026]] — AI ツールセキュリティ実在インシデント
