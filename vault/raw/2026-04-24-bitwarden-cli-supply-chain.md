# Bitwarden CLI サプライチェーン攻撃 2026-04 (raw)

source: https://socket.dev/blog/bitwarden-cli-compromised
fetched: 2026-04-24

## 概要

Bitwarden CLI バージョン 2026.4.0 が「Checkmarx サプライチェーンキャンペーン」の一部として侵害された。

## 被害規模

- 10,000,000+ ユーザー
- 50,000+ 企業

## 技術的詳細

- 悪意のあるコード: `bw1.js` ファイルに含有
- 侵害経路: GitHub Actions の CI/CD パイプライン
- C2 エンドポイント: `audit.checkmarx[.]cx/v1/telemetry`
- 窃取対象: GitHub トークン、クラウド認証情報
- 実行環境: Bun v1.3.13 インタプリタ悪用
- 地域回避: ロシアロケールのシステムでは自動終了

## IOC (Indicators of Compromise)

- IP: 94.154.172.43
- ロックファイル: `/tmp/tmp.987654321.lock`

## 影響範囲

- npm パッケージのみ侵害（Chrome 拡張などは未影響）

## 推奨対応

1. 影響パッケージの削除
2. 認証情報のローテーション
3. GitHub ログの監査
4. 不正ワークフローの確認

## OGP画像

https://cdn.sanity.io/images/cgdhsj6q/production/65ef8dc5e66260e20fdf13cead82ebd41b705ee6-1018x666.png
