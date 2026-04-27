---
type: concept
status: []
tags:
  - security/web
  - ai/llm
  - ai/prompt-engineering
sources:
  - "https://qiita.com/harupython/items/ed256553d10578cfec2a"
created: 2026-04-27
updated: 2026-04-27
---

# AI 脆弱性特定の Deep Structure Map 手法

ソースコードを直接 AI に読ませるのではなく、コードの構造をグラフ化した「Deep Structure Map」を入力することで、AI が脆弱性を高精度で特定できるという手法。

## 問題意識

生のコードを AI に丸ごと渡す手法は「情報の暴力」であり、AI がコードの文脈・依存関係・データフローを把握しきれず、見落としが多い。AI が本来得意な「グラフの矛盾探索」に集中させることで精度を向上させる。

## Deep Structure Map の構築

```python
import ast

# 1. コードを AST に変換
tree = ast.parse(source_code)

# 2. クラス・関数の依存関係を抽出 → Mermaid 形式で可視化
# 3. 変数スコープと参照関係を JSON として圧縮
```

出力例（Mermaid）:
```
graph TD
  UserInput --> validate_input
  validate_input --> execute_query
  execute_query --> db.execute
```

## 脆弱性が成立する 3 要素（SPS モデル）

| 要素 | 説明 | 例 |
|------|------|-----|
| **Source** | 外部からの入力源 | `request.form['q']` |
| **Propagator** | サニタイズなしの変数伝播 | 未検証のまま変数に代入 |
| **Sink** | 危険な関数への到達 | `eval()`, `execute()`, `os.system()` |

3 要素が直接つながっているパスが脆弱性。AI にグラフ上でこのパスを探させる。

## 実装フロー

```
1. 静的抽出 → 変数スコープ・関数呼び出しをリスト化
        ↓
2. マップ変換 → Mermaid + JSON に圧縮
        ↓
3. AI へのプロンプト → 「Source から Sink へ到達するパスを列挙せよ」
        ↓
4. 精密スキャン → AI が指摘した箇所のみ生コードで詳細確認
```

## 適用できる脆弱性種別

- SQL インジェクション（Source → Sink: `db.execute`）
- XSS（Source → Sink: innerHTML 操作）
- コマンドインジェクション（Source → Sink: `os.system`）
- 安全でないデシリアライゼーション

## 限界

- コンパイル時に決まらない動的呼び出し（`getattr(obj, method_name)()`）は追跡困難
- ゼロデイ的な新手法のシンクは事前定義が必要
- 理論編であり実装ツールは示されていない

## 関連ページ

- [[wiki/n-day-bench]] — LLM が実世界の脆弱性を発見する能力を評価するベンチマーク
- [[wiki/security-agent-harness]] — セキュリティ分析 AI エージェントのハーネスエンジニアリング
- [[wiki/claude-code-security-incidents]] — Claude Code で実際に起きたセキュリティ事故
