---
type: concept
status: []
tags:
  - security/web
  - dev/javascript
sources:
  - "https://blog.inorinrinrin.com/entry/2026/04/18/232104"
created: 2026-04-19
updated: 2026-04-19
---

# Reporting API によるフロントエンド Observability

2026年3月に Baseline ステータスに到達した Reporting API を使ったブラウザ側イベント監視の設計パターン。サーバーサイド監視では捕捉できない問題を可視化する。

## Reporting API とは

ブラウザが検知した問題（CSP 違反、非推奨 API 使用、ブラウザ介入など）をレポートとして収集・送信する Web 標準 API。2026年3月に Baseline（主要ブラウザ全対応）に到達。

## 2つの受信方法

### 1. ReportingObserver（クライアントサイド）

JS のコールバックでリアルタイム受信:

```js
const observer = new ReportingObserver((reports) => {
  reports.forEach(report => {
    console.log(report.type, report.body);
  });
}, { types: ['csp-violation', 'deprecation'] });
observer.observe();
```

### 2. Reporting-Endpoints ヘッダー（サーバーサイド）

ブラウザが自動的に指定エンドポイントへ POST:

```http
Reporting-Endpoints: default="https://your-api.example.com/reports"
Content-Security-Policy: ...; report-to default
```

## サポートされるレポートタイプ

| タイプ | 内容 |
|--------|------|
| `deprecation` | 非推奨 API の使用 |
| `intervention` | ブラウザの介入（広告ブロック、自動再生防止） |
| `csp-violation` | Content Security Policy 違反 |
| `coep` | Cross-Origin Embedder Policy 違反 |
| `integrity-violation` | サブリソース整合性違反 |
| `crash` | ブラウザのクラッシュ |

## 推奨ユースケース

1. **非推奨 API の事前検知**: ブラウザ更新でコードが壊れる前に検出
2. **CSP 違反モニタリング**: `Report-Only` モードでポリシー影響を安全に確認
3. **ブラウザ介入の可視化**: ユーザー環境で何がブロックされているか把握

## 実装例（Hono）

`/api/reports` エンドポイントを作成し、両方式（ReportingObserver + Reporting-Endpoints）を併用するとクライアントとサーバーの両方でレポートを収集できる。

## 関連ページ

- [[wiki/mcp-security-vulnerability-2026]] — セキュリティ可視化の重要性
- [[wiki/flock-lpr-privacy]] — ブラウザ・クライアント側の監視問題
