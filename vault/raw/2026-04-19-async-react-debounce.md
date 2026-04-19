# Async React時代の宣言的UI 2: トランジション対応のuseDebouncedフックを作る

**Source:** https://zenn.dev/uhyo/articles/async-react-debounce-2
**Fetched:** 2026-04-19
**Published:** 2026-04-18
**Author:** uhyo

## 概要

React 19 のトランジションシステムと統合した `useDebouncedValue` フックの実装解説。API コールの過剰発生を防ぎながら、ペンディング状態のフィードバックも宣言的に扱う。

## 課題

バックエンド API コールを伴う入力フィールドでは:
1. キー入力のたびに API コールが走る
2. デバウンス中は UI フィードバックが途切れる

## 実装アプローチ

### 従来のデバウンス
`setTimeout` + `useEffect` で遅延更新 → ペンディング状態が別管理になり複雑化。

### トランジション対応デバウンス
`startTransition` でデバウンスロジックをラップ → React のトランジション機構でペンディング状態を管理。

```ts
// useDebouncedValue に startTransition を注入
const [debouncedValue, isPending] = useDebouncedValue(value, {
  delay: 300,
  startTransition,
})
```

## 設計哲学

トランジションを「共有コミュニケーション機構」として使う。フックが boolean フラグを返すのではなく、React 組み込みのステート管理に乗る。

## トレードオフ

ステート更新とペンディング状態有効化の間に微小なタイミングギャップが生じる（許容範囲内）。
