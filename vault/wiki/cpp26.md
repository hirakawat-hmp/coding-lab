---
type: entity
status: []
tags:
  - dev/cpp
sources:
  - "https://www.infoq.com/news/2026/04/cpp-26-reflection-safety-async/"
created: 2026-04-20
updated: 2026-04-20
---

# C++26

C++ の新標準規格。4つの大きな機能追加を含む：リフレクション、メモリ安全性強化、コントラクト、新しい非同期モデル（std::execution）。

## 1. リフレクション（Reflection）

- コードが自分自身の構造を記述できる「メタプログラミング」をランタイムコストなしで実現
- Herb Sutter：「C++ の内部機構の鍵を開発者に渡す」
- コンパイル時コード生成、インターフェースのような抽象化の専用構文
- Python の `inspect` や Java のリフレクションに相当するが、**コンパイル時解決**が特徴

## 2. メモリ安全性

- 未初期化変数の読み取りによる未定義動作を排除
- 標準ライブラリコンテナ（`vector`, `span`, `string`, `string_view`）に境界チェックを追加
- Google は本番環境にすでにデプロイ済み
  - **1,000 以上のバグを修正**
  - セグフォルト率 **30% 削減**

## 3. コントラクト（Contracts）

関数宣言に直接、事前条件（precondition）と事後条件（postcondition）を記述できる：

```cpp
int divide(int a, int b) 
  pre(b != 0)      // 事前条件
  post(r: r * b == a);  // 事後条件
```

- 呼び出し元と静的解析ツールから可視
- C の `assert` マクロに置き換わるネイティブアサーション機構

## 4. std::execution フレームワーク

並行・並列処理の統一抽象：
- **scheduler**（実行場所）
- **sender**（非同期操作の記述）
- **receiver**（完了ハンドラー）

C++20 コルーチンとの統合、構造化されたデータ競合なしプログラムの実現。

## 文脈

C++ はメモリ安全性を巡って Rust や Carbon との競争にさらされている。C++26 のメモリ安全性改善は、この文脈での防衛的反応でもある。Google、Microsoft、Apple が参加するコミュニティが標準化作業を主導。

## 関連ページ

- [[wiki/rust-for-cpython]] — Python の Rust 統合計画（言語安全性のトレンド）
- [[wiki/openssl-4]] — 同時期のセキュリティ重視のソフトウェア進化
