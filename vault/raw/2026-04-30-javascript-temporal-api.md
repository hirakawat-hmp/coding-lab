# Raw: JavaScriptの日付の概念を変革するTemporalオブジェクト誕生までの9年間の道のり

Source: https://gigazine.net/news/20260429-fix-time-in-javascript/
Thumbnail: https://i.gzn.jp/img/2026/04/29/fix-time-in-javascript/00_m.jpg
Fetched: 2026-04-30

## Temporal とは

JavaScript の Date オブジェクトを置き換える新しい日時 API。ECMAScript 標準に追加予定。

## Date オブジェクトの問題

1990年代に10日間で実装された Date は3つの主要問題を抱える:
- **可変性**: 関数引数として渡すとオブジェクトが変更されてしまう
- **解析曖昧性**: 日付文字列のブラウザ間解釈差異
- **タイムゾーン/カレンダー制限**: グレゴリオ暦以外への対応不足

## Temporal の特徴

- イミュータブル設計
- 複数の DateTime 型（ユースケース別）
- タイムゾーン・カレンダーのファーストクラスサポート

## 開発経緯

- 2017年: TC39 へ提案
- Microsoft、Bloomberg、Igalia、Google が主要貢献
- Test262 に 4,500 件のテストケース（他の組み込み機能を大幅に超える）
- 開発期間: 約9年間
