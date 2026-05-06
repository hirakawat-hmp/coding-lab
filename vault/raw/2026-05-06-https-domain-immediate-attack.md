# 外部からアクセス可能なhttpsサイトはドメイン設定後「即」攻撃にさらされる件

Source: https://zenn.dev/kusuke/articles/25330f7759eba4
Author: Yusuke Kawabata
Retrieved: 2026-05-06
OGP Image: https://static.zenn.studio/user-upload/c4700bf50fa8-20260505.png

## Summary

新規デプロイのHTTPSサイトが公開前から自動攻撃ボットに検出される仕組みと対策。実際に27件の正当アクセスに対して1,620件のボットリクエストが来た実例。

## 攻撃発見の仕組み

**Certificate Transparency (CT) ログ:**
- HTTPS証明書発行時にドメイン情報が公開登録
- CTログは誰でも検索可能
- 悪意あるアクターがCTログを監視して新規ドメインを自動スキャン

## なぜ危険か

- 新規公開サイトはセキュリティ設定が未完全なことが多い
- ステージング・内部専用ページも同様にスキャン対象
- 公開前から攻撃されている

## 推奨対策

1. dev/stagingに別ドメインを使用
2. 未完成サービスにBasic認証またはIP制限を実装
3. Cloudflare等のWAFでsuspicious trafficをブロック
4. ワイルドカード証明書でCTログのサブドメイン露出を抑制
5. 本番デプロイ前にセキュリティ設定を検証

## 重要な教訓

「内部専用サーバー」もbotスキャンには無差別。適切なセキュリティ措置は必須。
