---
type: entity
status: []
tags:
  - dev/typescript
  - ui/components
  - dev/react
sources:
  - "https://blog.inorinrinrin.com/entry/2026/05/02/231104"
created: 2026-05-03
updated: 2026-05-03
---

# TSRX：AI時代のUIコンポーネントフレームワーク

![TSRX](https://ogimage.blog.st-hatena.com/6802418398318546029/17179246901364840044/1773563608)

TSRX（TypeScript Render Extensions）：構造・スタイル・制御フローを1ファイルに統合する宣言的 UI TypeScript 拡張（アルファ版、2026年5月2日発表）。

## 対応フレームワーク

React、Preact、Solid、Vue、Ripple

## AI ファースト設計哲学

### コンテキスト近接性

LLM は関連情報が近接している場合に最高のパフォーマンスを発揮するという Liu et al. の研究を踏まえ、TSRX では「関連情報を近くに置く」設計を採用。

### AI が生成したコードが壊れない

コンパイラが React の Hooks ルールなどフレームワーク固有の制約を自動処理。AI が生成したコードを手動でリファクタリングせず済む。

**通常の TSX：** AI が Hooks ルール違反のコードを生成 → 手動修正が必要  
**TSRX：** コンパイラが自動修正 → AI 生成コードがそのまま動く

## 開発体験

通常の TSX との比較：

```tsx
// 通常のTSX（三項演算子が強制される）
return isLoggedIn ? <Dashboard /> : <Login />

// TSRX（直感的なif文が使える）
if (isLoggedIn) {
  return <Dashboard />
} else {
  return <Login />
}
```

変数を使う場所のすぐそばで宣言できる「空間的局所性」が可読性を向上。

## 段階的採用

既存の TypeScript/TSX コードベースと共存可能。全ファイルを一度に移行する必要はない。

## 関連

AI ネイティブな開発ツールの潮流（[[wiki/cursor-3]]、[[wiki/claude-design]] など）と同じ方向性だが、フレームワーク側がAI生成コードの特性に合わせて設計された例として注目。

**関連ページ:** [[wiki/cursor-3]] — Cursor 3.0（AI統合コードエディタ）  
**関連ページ:** [[wiki/claude-design]] — AnthropicのAIデザインツール
