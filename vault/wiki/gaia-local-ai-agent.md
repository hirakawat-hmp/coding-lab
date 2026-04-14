---
type: entity
status: []
tags:
  - ai/agent
sources:
  - "https://amd-gaia.ai/docs"
created: 2026-04-14
updated: 2026-04-14
---

# GAIA — ローカルAIエージェントフレームワーク

AMD が開発するオープンソースのAIエージェントフレームワーク。ローカルハードウェア上で完全に動作し、クラウドAPIへの依存なしにエージェントを構築できる。

## 特徴

| 特徴 | 内容 |
|------|------|
| オンデバイス処理 | 全ての処理がローカルで完結。データ流出なし |
| クラウド不要 | APIキーや外部サービスへの依存なし |
| AMD最適化 | Ryzen AIのNPUとGPUアクセラレーションに対応 |
| 多言語SDK | PythonとC++の両方で完全なSDKを提供 |

## 主要機能

### Python環境
- **Agent UI**：ドキュメント質問応答対応のWebインターフェース
- **音声対話**：Whisper ASR（音声認識）+ Kokoro TTS（音声合成）
- **コード生成・画像生成**：マルチモーダルなエージェント機能
- **MCP統合**：Model Context Protocol対応でツール連携が可能

### C++環境
- システムヘルスエージェント
- Wi-Fiトラブルシューティング
- カスタムエージェント構築

## 使用例

```python
# シンプルなAPIで自然言語クエリを処理
result = gaia.query("Summarize my meeting notes")
```

## 定置づけ

クラウドAI（Claude、GPT等）のAPIを使いたくない、またはオフライン環境でエージェントを動かす必要がある場合の選択肢。AMD製ハードウェアを使用していると最大限の恩恵を受けられる。

## 関連ページ

- [[wiki/snapstate]] — AIエージェントの永続状態管理
- [[wiki/aws-frontier-agents]] — クラウド側のAIエージェント（対比）
- [[wiki/mastra-patterns]] — エージェントフレームワークの設計パターン
