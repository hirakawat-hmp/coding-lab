---
type: insight
status: []
tags:
  - security/supply-chain
  - dev/javascript
  - security/web
sources:
  - "https://socket.dev/blog/bitwarden-cli-compromised"
created: 2026-04-24
updated: 2026-04-24
---

# Bitwarden CLI サプライチェーン攻撃（2026年4月）

![Bitwarden CLI 侵害](https://cdn.sanity.io/images/cgdhsj6q/production/65ef8dc5e66260e20fdf13cead82ebd41b705ee6-1018x666.png)

Bitwarden CLI バージョン **2026.4.0** が「Checkmarx サプライチェーンキャンペーン」の一部として侵害された事件。10,000,000+ ユーザー、50,000+ 企業が影響を受けた可能性がある。

## 侵害の詳細

| 項目 | 内容 |
|------|------|
| 侵害バージョン | `2026.4.0` |
| 悪意のあるファイル | `bw1.js` |
| 侵害経路 | GitHub Actions の CI/CD パイプライン |
| C2 エンドポイント | `audit.checkmarx[.]cx/v1/telemetry` |
| 窃取対象 | GitHub トークン、クラウド認証情報 |
| 実行エンジン | Bun v1.3.13 インタプリタ悪用 |
| 地域回避 | ロシアロケールのシステムでは自動終了 |

## Indicators of Compromise (IOC)

- IP アドレス: `94.154.172.43`
- ロックファイル: `/tmp/tmp.987654321.lock`

## 影響範囲

- **npm パッケージ**: 侵害確認
- Chrome 拡張機能: 未影響
- デスクトップアプリ: 未影響

## 推奨対応

1. 影響バージョン (`2026.4.0`) の即時削除
2. 認証情報のローテーション（GitHub トークン、クラウド認証情報全て）
3. GitHub Actions ログの監査
4. 不正なワークフローの確認・削除

## 注目点

Bun インタプリタを悪意のある目的で悪用した点が技術的に特徴的。また、ロシアロケール回避という地政学的な設計が含まれている。

CI/CD パイプライン経由の侵害は検出が難しく、広範な企業サプライチェーンに波及するリスクがある。

## 関連ページ

- [[wiki/wordpress-plugin-supply-chain-attack]] — WP プラグイン一斉バックドア事件
- [[wiki/vercel-2026-breach]] — Vercel サプライチェーン侵害事例
- [[wiki/aws-supply-chain-monitor]] — AWS マネージドサービスで作るサプライチェーン攻撃検知
