---
type: insight
status: []
tags:
  - dev/typescript
  - dev/python
sources:
  - "/Users/hdymacuser/Desktop/prompt-management-system/.serena/memories/kie-api-implementation-lessons.md"
created: 2026-04-06
updated: 2026-04-06
---

# 外部 API 実装時の教訓

外部 API 統合時に「推測で実装する」ことで発生するコスト増・手戻りを防ぐための汎用的な教訓。Kie.ai API 実装での失敗体験から抽出。

## 失敗パターン: 推測ベース実装

ある API エンドポイントのレスポンス構造を、別のエンドポイントと「同じだろう」と推測して実装した結果:

- 文字列配列を期待したが、実際はオブジェクト配列だった
- 実行コスト（API 課金）を消費した後にようやく問題が判明
- ドキュメントには正しい構造が記載されていた

## 必須プロセス

### 1. ドキュメント精読

- API ドキュメントを完全に確認する
- レスポンス例の詳細を確認する
- エンドポイント間の差異を比較する

### 2. 実レスポンス検証（実装前）

```bash
# 必ず実装前に実 API を叩いて確認
curl -X GET "https://api.example.com/endpoint?id=REAL_ID" \
  -H "Authorization: Bearer ${API_KEY}"
```

過去のデータ（タスク ID 等）があれば必ず使う。

### 3. 構造の文書化

レスポンス構造をコードコメントに明記する:

```typescript
/**
 * Handles three different response formats:
 * - ModelA: JSON string `{resultUrls: ["url1"]}`
 * - ModelB: Direct array `{response: {resultUrls: ["url1"]}}`
 * - ModelC: Object array `{resultInfoJson: {resultUrls: [{resultUrl: "url1"}]}}`
 */
```

### 4. 実構造ベースのテストケース

実際の API レスポンスと同じ構造でテストを書く。モックデータは実データから作る。

### 5. 差異の比較表

複数エンドポイント/モデルがある場合、レスポンス構造の差異を比較表にまとめる:

| モデル | ステータスフィールド | 結果フィールド | 結果の型 |
|--------|---------------------|---------------|---------|
| A | `state` (string) | `resultJson` | JSON 文字列 |
| B | `successFlag` (int) | `response.resultUrls` | 文字列配列 |
| C | `successFlag` (int) | `resultInfoJson.resultUrls` | オブジェクト配列 |

## チェックリスト

外部 API 実装時に必ず実施:

- [ ] API ドキュメント完全読了
- [ ] 実際の API レスポンス確認（curl / test script）
- [ ] レスポンス構造をコメント/ドキュメントに記録
- [ ] 実際の構造に基づくテストケース作成
- [ ] 異なるエンドポイント/モデル間の差異を比較表にまとめる
- [ ] **推測で実装しない** -- 不明な点は必ず確認

## 核心的な教訓

> 「似ている」は「同じ」ではない。API のレスポンス構造は推測せず、必ず実データで確認する。

## 関連ページ

- [[wiki/tdd-parallel-workflow]] -- テストファースト開発でこの問題を早期に発見できる
