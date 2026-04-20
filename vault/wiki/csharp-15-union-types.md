---
type: concept
status: []
tags:
  - dev/csharp
sources:
  - "https://qiita.com/hez2010/items/b656c867f9e5f57cc1cd"
created: 2026-04-20
updated: 2026-04-20
---

# C# 15 Union Types（共用体型）

C# 15 で追加予定の Union Types（共用体型）。値を複数の型のうちいずれか一つに制約し、コンパイル時の網羅性チェックを実現する。

## 基本構文

```csharp
// 宣言: Pet は Cat, Dog, Bird のいずれか
public union Pet(Cat, Dog, Bird);

// 型安全な結果型
public union Result<T>(T, Exception);
```

単一行で Union 型を宣言できる。コンパイラが内部的に `object?` Value プロパティを持つ struct を生成する。

## 主なユースケース

### 型安全な Result/Either パターン

従来は `Data` と `Error` を両方持つラッパークラスが必要だったが、Union で明確に：

```csharp
public union ApiResult<T>(T Data, ApiError Error);

var result = FetchUser(id);
var message = result switch {
    User u => $"Hello, {u.Name}",
    ApiError e => $"Error: {e.Message}"
    // 網羅性チェック: すべてのケースが必須
};
```

### 判別共用体（Discriminated Union）

F# や Rust の `enum`、Haskell の `data` に相当する機能が C# にも。

## 主な特性

| 特性 | 説明 |
|------|------|
| コンパイル時安全性 | 型システムが Union メンバーを強制 |
| 網羅性チェック | switch 式で未処理ケースを検出 |
| 暗黙の変換 | Union 型へは自動変換（ラッパー不要） |
| パターンマッチ統合 | コンパイラが値を自動的にアンラップ |
| ボクシングなし | `TryGetValue` でボクシングなしアクセス可 |

## 既存型への適用

```csharp
// [Union] 属性で既存型から Union を生成
[Union]
public record Success<T>(T Value);
[Union]  
public record Failure(Exception Error);
```

## 設計哲学

型消去（type erasure）ではなく**名前付きラッパー型**を採用。ジェネリクスとの安全性を保ちつつ、将来の言語進化で破壊的変更を避ける設計。

## 他言語との比較

| 言語 | 相当機能 |
|------|---------|
| Rust | `enum` |
| F# | Discriminated Union |
| Haskell | `data` |
| TypeScript | Union Types（`string \| number`）|
| Swift | `enum` with associated values |

TypeScript の Union と異なり、C# 15 の Union は**名前付き型**であり構造的一致ではなく名義的一致。

## 関連ページ

- [[wiki/rust-for-cpython]] — Rust の型安全性（比較観点）
- [[wiki/cpp26]] — 同時期の C++ 型安全性強化
