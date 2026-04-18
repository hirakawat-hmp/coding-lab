---
type: insight
status: []
tags:
  - security/api
  - security/web
sources:
  - "https://qiita.com/miruky/items/fde2d0747358cd7870d7"
created: 2026-04-18
updated: 2026-04-18
---

# Google API キー脆弱性：13時間で約900万円請求インシデント

Firebase プロジェクトに Gemini API を有効化した直後、露出した API キーが悪用され
13時間で €54,000（約900万円）が課金された事案（2026年4月）。

## インシデントのメカニズム

### なぜ起きたか

```
Firebase プロジェクト
  ├── Firebase SDK キー（`AIza...` 形式）
  │     └── 従来：「非機密」なパブリック識別子として設計
  │
  └── Gemini API を有効化
        └── 突然：Firebase キーが Gemini の有効な認証資格情報に変わる
```

攻撃者はソースコードから `AIza...` キーを発見し、`curl` で Gemini エンドポイントにリクエスト。

### 規模感

- Truffle Security が 2025年11月時点で **2,863件** の脆弱な API キーを発見
- 他の被害者: $13,428・$82,000 の請求事例も
- Fortune 500 企業や主要セキュリティ企業も影響

## 防止策（優先順）

1. **API キーのスコープ制限** — Generative Language API を明示的に除外
2. **用途別キー分離** — Firebase / Maps / Gemini で別々のキーを使用
3. **使用上限の設定** — プリペイドクレジット・予算アラートの二重設定
4. **定期ローテーション** — キーを定期的に再生成し、移行期間は新旧両方を維持

## バジェットアラートの落とし穴

- アラートは**最大10分遅延**で発火
- 事後通知のみで自動停止はしない（2026年3月23日導入のプリペイドモデルを除く）

## Google の対応状況（2026年4月時点）

| 項目 | 状況 |
|------|------|
| 新「Auth Keys」形式 | 導入中 |
| 流出キーの自動ブロック | 実施中 |
| 無制限キーの Gemini 利用禁止 | 未定 |
| バジェットアラートの遅延問題 | 未解決 |

## 関連ページ

- [[wiki/claude-code-security-incidents]] — AI ツール利用時の類似セキュリティ事故
- [[wiki/mcp-security-vulnerability-2026]] — MCP の API アクセス制御問題
- [[wiki/axios-cve-2026]] — API クライアントライブラリの脆弱性（CVSS 10.0）
