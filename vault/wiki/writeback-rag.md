---
type: concept
status: []
tags:
  - ai/rag
sources:
  - "https://zenn.dev/knowledgesense/articles/5a50d06fce072d"
created: 2026-04-15
updated: 2026-04-15
---

# WriteBack-RAG

AI を使ってナレッジベース自体を自動的に書き換え・整理する手法。過去のクエリから有用な情報を蒸留し、再利用可能な知識として保存することで RAG の精度を継続的に向上させる。

## 問題意識

### 従来の RAG の課題

大企業では情報が複数ドキュメントに分散している（情報の分散問題）。

- **通常 RAG**: 散在した情報を効率よく処理できない
- **Agentic RAG**: 複数ソースから収集できるが、その結果は回答生成後に**失われる**
- 同様の質問のたびに同じ検索コストが発生

### WriteBack-RAG の解決策

検索によって価値が向上した回答から得られたインサイトを、**次回のクエリのために保存**する。

## 仕組み

```
ユーザークエリ → 検索 → 回答生成
                  ↓
          [品質改善が確認された回答]
                  ↓
          WriteBack プロセス:
          1. Sample Selection（有用なクエリを特定）
          2. Document Identification（貢献ドキュメントを抽出）
          3. Distillation（AI で複数 docs を1つに蒸留）
          4. Write-Back（蒸留結果を専用 DB に保存）
                  ↓
        次回クエリ: 元 DB + Write-Back DB を並列検索
```

## 4 フェーズの詳細

| フェーズ | 内容 |
|---------|------|
| **Sample Selection** | 検索が回答品質を向上させた過去クエリを特定 |
| **Document Identification** | 改善に貢献した具体的ドキュメントを抽出 |
| **Distillation** | 複数ドキュメントを AI で1コンパクト文書に統合 |
| **Write-Back** | 蒸留結果を専用 DB に保存（元 DB は保持） |

## ベンチマーク結果

48 種の設定でテスト:

| ベンチマーク | 改善幅 |
|------------|--------|
| 平均 | **+2.14%** |
| FEVER（ファクトチェック） | **+4.79%** |
| NQ（オープンドメイン QA） | **+3.01%** |

Write-Back ドキュメントは元の 2-7 倍に圧縮（平均 72-93 トークン）。

## システム特性

- **累積改善**: 使えば使うほどナレッジベースが整理される
- **元データ保持**: 蒸留後も元ドキュメントを削除しない
- **レトロアクティブ**: 過去クエリのログから遡及適用可能

## Knowledge Vault への応用

この vault の `vault/raw/` → `vault/wiki/` のパイプラインは WriteBack-RAG の変形と見なせる:
- `raw/`: 元ソース（蒸留前の生データ）
- `wiki/`: 蒸留・構造化された知識
- 日次ダイジェストが「Sample Selection + Distillation + Write-Back」を担う

## 関連ページ

- [[wiki/llm-wiki-pattern]] — Karpathy の raw/wiki/schema 3層モデル
- [[wiki/gemini-personal-intelligence]] — 個人データへの RAG 適用
- [[wiki/rag-mcp-sidecar]] — RAG をサイドカーとして実装するアーキテクチャ
