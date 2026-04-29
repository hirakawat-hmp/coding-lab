---
type: entity
status: []
tags:
  - tool/claude-code
  - ai/agent
  - infra/ci-cd
sources:
  - "https://zenn.dev/layerx/articles/20260428-ccgate"
  - "https://github.com/tak848/ccgate"
created: 2026-04-29
updated: 2026-04-29
---

# ccgate：AI コーディングエージェントの Permission 確認を 97% 自動化

![ccgate](https://static.zenn.studio/user-upload/deployed-images/cf4d7dff9739e614c2be8505.png)

LayerX の TAK848 が開発・公開した OSS CLI ツール（2026年4月28日）。Claude Code・OpenAI Codex などのコーディングエージェントが発する `PermissionRequest` フックを傍受し、別 LLM（デフォルト: Claude Haiku）が自動判断する。

## 背景

AI コーディングエージェントを多用すると、Permission 確認プロンプトが日200件以上に達する。1 件あたり 3 秒超の判断時間 × 200 件 = 10 分以上が毎日失われる。「全許可」では環境破壊リスク、逐一確認では意思決定疲弊。

## 3 段階判定システム

| 判定 | 動作 | 説明 |
|---|---|---|
| `allow` | 許可 | 安全と判断 |
| `deny` | 拒否（理由付き） | 危険と判断 |
| `fallthrough` | 人間にエスカレーション | 判断困難な場合 |

ルールは **jsonnet**（JSON スーパーセット）で自然言語記述。

## 1 ヶ月の実績（2026年4月）

| 分類 | 件数 | 割合 |
|---|---|---|
| allowed | 1,764 | 85% |
| denied | 190 | 9% |
| escalated | 113 | 5% |
| **計** | **2,000+** | **97% 自動化** |

応答レイテンシ: 平均約 3 秒

## 特徴

- Claude Code の Auto Mode とは別レイヤー（Plan Mode でも動作）
- `ccgate metrics` コマンドで統計・ログを確認
- Claude Code・Codex CLI の両方に対応（hooks 経由）

## Auto Mode との違い

Claude Code 内蔵の Auto Mode はデフォルトモードのみで動作するが、ccgate は hooks レイヤーとして Plan Mode 等あらゆるコンテキストで機能。著者は両ツールを補完的に併用。

## 関連ページ

- [[wiki/claude-code-hooks]] — Claude Code Hooks システム（ccgate が依拠する仕組み）
- [[wiki/claude-code-hooks-patterns]] — Hooks の実用実装パターン
- [[wiki/ai-self-merge-policy]] — AI を活用したレビュー自動化の別事例
- [[wiki/envguard]] — AI ツールへの秘密鍵漏洩を事前チェック
