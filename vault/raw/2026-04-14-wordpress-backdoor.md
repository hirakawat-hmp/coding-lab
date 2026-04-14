# WordPress Plugin Supply Chain Attack — Raw Source

Source: https://anchor.host/someone-bought-30-wordpress-plugins-and-planted-a-backdoor-in-all-of-them/
Fetched: 2026-04-14
Feed: Hacker News (Top)

## 事件の概要

30以上のWordPressプラグインが買収後に改ざんされ、バックドアが仕込まれた。攻撃者は「Essential Plugin」のポートフォリオをFlippaで購入し、数ヶ月後に悪意のあるコードを有効化した。

## 影響を受けたプラグイン

- Countdown Timer Ultimate
- Popup Anything on Click
- WP Testimonial with Widget
- Post Grid and Filter Ultimate
- その他多数のスライダーやギャラリー関連プラグイン

## 技術的詳細

**実装方法：** `fetch_ver_info()`メソッドが攻撃者サーバーから取得したデータを`@unserialize()`で処理し、任意の関数を実行可能にした。

**潜伏期間：** 2025年8月8日に仕込まれ、8ヶ月後の2026年4月に発動した。

**ペイロード配信：** `wp-config.php`に約6KBのPHPコードを注入し、Googlebotにのみ検索エンジン最適化スパムを表示した。

**C2管理：** C2ドメインをEthereumスマートコントラクトで管理し、従来のドメイン無効化では対応できない仕様。

## 対応策

- WordPress.orgはv2.6.9.1で強制更新実施
- セキュリティ企業は`wpos-analytics`ディレクトリ全体を削除したパッチ版を配布
- `wp-config.php`のファイルサイズ監視によるフォレンジック検査推奨

## 根本的な課題

WordPress.orgは所有権変更時の審査メカニズムがなく、新しい保守者による追加コードレビューも実施されていない。
