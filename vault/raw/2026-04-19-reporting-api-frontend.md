# 2026年3月にBaselineになったReporting APIを活用してフロントエンドのObservabilityを高める

**Source:** https://blog.inorinrinrin.com/entry/2026/04/18/232104
**Fetched:** 2026-04-19
**Published:** 2026-04-18
**Author:** inorinrinrin (ysknsid25)

## 概要

2026年3月に Baseline ステータスに到達した Reporting API を使ったフロントエンド Observability の向上手法。サーバーサイド監視では捕捉できないブラウザ側のイベントを可視化する。

## 受信方法

### 1. ReportingObserver（クライアントサイド）
JS のコールバックで受け取る。リアルタイム処理に向く。

```js
const observer = new ReportingObserver((reports) => {
  reports.forEach(report => console.log(report));
}, { types: ['csp-violation', 'deprecation'] });
observer.observe();
```

### 2. Reporting-Endpoints ヘッダー（サーバーサイド）
ブラウザが自動的に指定エンドポイントへ POST。

```http
Reporting-Endpoints: default="https://example.com/reports"
```

## サポートされるレポートタイプ

- `deprecation`: 非推奨 API の使用
- `intervention`: ブラウザの介入（広告ブロック、自動再生防止）
- `csp-violation`: CSP 違反
- `coep`, `integrity-violation`, `crash`

## 実装例（Hono フレームワーク）

`/api/reports` エンドポイントを Hono で実装し、両方式を併用。

## 推奨ユースケース

- ブラウザ更新前に非推奨 API 使用を事前検知
- Report-Only モードでの CSP 違反モニタリング
- ブラウザ介入の可視化
