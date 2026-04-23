# Google Cloud Spanner Omni — 発表

Source: https://www.publickey1.jp/blog/26/google_cloudrdbspanner_omni.html
Fetched: 2026-04-23

## 要点

GoogleはGoogle Cloud Next 2026で、オンプレミス環境にインストール可能な大規模分散RDB「Spanner Omni」のプレビュー版を公開。

- Google Cloud Spannerの機能をローカルマシンで利用可能に
- 単一サーバから数千台規模クラスタへのスケールアウト対応
- ベンチマーク：秒間数百万件のクエリ処理を実証
- Google独自のColossusファイルシステムと原子時計技術への依存を抽象化レイヤーで解消
- ローカルファイルシステムとの連携でほぼ同等のパフォーマンスを提供
- Google Cloud とオンプレミスでDBを統一し、ホット/コールドフェイルオーバーやAIアプリ構築が可能

OGP: https://www.publickey1.jp/2026/spanner-omni-ann01.png
