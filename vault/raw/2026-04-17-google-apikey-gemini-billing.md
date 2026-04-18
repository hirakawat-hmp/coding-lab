# Google APIキーの脆弱性により13時間で約900万円請求される事案

**Source:** https://qiita.com/miruky/items/fde2d0747358cd7870d7
**Fetched:** 2026-04-18
**Published:** 2026-04-17

## インシデント概要

Firebase プロジェクトオーナーが Firebase AI Logic with Gemini API を有効化後、13時間以内に €54,000（約900万円）の予期しない請求が発生。

## 問題の本質

2つの要因が重なった：
1. **GCP API キーはデフォルトで無制限** — 制限なしで全有効 API にアクセス可能
2. **事後的な権限拡大** — Gemini API を有効化すると、従来「非機密」だった Firebase キーが突然 Gemini エンドポイントの認証資格情報になる

攻撃者は `AIza...` 形式のキーをソースコードから発見し、以下でリクエスト送信：
```
curl "https://generativelanguage.googleapis.com/v1beta/files?key=$API_KEY"
```

## 影響規模

- Truffle Security が 2025年11月時点で 2,863 件の脆弱な API キーを発見
- 被害者には $13,428 や $82,000 USD の請求報告も
- Fortune 500 企業や主要セキュリティ企業も影響

## 対策

1. API キーごとに使用 API を明示制限（Generative Language API を除外）
2. 定期的な API キーローテーション
3. 使用金額上限の設定（プリペイドクレジット）
4. Firebase / Maps / Gemini 用途別にキーを分離

## Google の対応状況

- 新「Auth Keys」形式の導入（セキュリティ強化）
- 流出検出されたキーの自動ブロック
- 無制限キーの Gemini 利用禁止（時期未定）
- バジェットアラートは最大10分遅延の問題が残存
