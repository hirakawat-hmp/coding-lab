---
type: entity
status: []
tags:
  - infra/gcp
  - security/api
created: 2026-05-05
updated: 2026-05-05
sources:
  - "https://dev.classmethod.jp/articles/google-cloud-session/"
---

# Google Cloud セッション有効期限変更 — 2026年6月8日から16時間に

![Google Cloud](https://images.ctfassets.net/ct0aopd36mqt/wp-thumbnail-ad93048e78cc95a1273ab7c104fc3e59/8216b21fb1b7aea8439c60f82d7ecdec/gcp-google-cloud-eyecatch-2021.png)

2026年6月8日から、`gcloud auth login` で取得した認証情報のセッション有効期限が「無期限」から「**16時間**」に変更される。セキュリティ強化が目的だが、CI/CDなどの非対話型ワークロードには影響がある。

## 変更内容

| 変更前 | 変更後 |
|--------|--------|
| セッション期限：無期限 | セッション期限：16時間 |
| 再認証不要 | 16時間ごとに再認証必要 |

## セキュリティ上の意義

リフレッシュトークンが漏洩した場合、これまでは「永続的なアクセスを攻撃者に許す」リスクがあった。16時間制限により漏洩による被害ウィンドウを大幅に縮小。

## 影響を受けるユースケース

- CI/CDパイプライン（非対話型）
- バッチ処理スクリプト
- 長時間実行ジョブ

## 対応方法

1. **Workload Identity Federation** への移行（推奨）
2. 「信頼済みアプリ」への登録で例外設定
3. **オプトアウト期限**: 2026年5月29日までに申請で現在の設定を維持可能

## 関連ページ

- [[wiki/google-apikey-gemini-billing]] — Google APIキー脆弱性インシデント
- [[wiki/mcp-gateway-google-sa]] — MCP ゲートウェイとGoogle SA設計
