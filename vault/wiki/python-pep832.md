---
type: entity
status: []
tags:
  - dev/python
sources:
  - "https://atmarkit.itmedia.co.jp/ait/articles/2604/21/news007.html"
created: 2026-04-21
updated: 2026-04-21
---

# Python PEP 832 — 仮想環境パス .venv 標準化

![PEP 832](https://image.itmedia.co.jp/ait/articles/2604/21/di-pyn02201.png)

2026年4月17日に Draft として提出された Python Enhancement Proposal。プロジェクトの仮想環境ディレクトリ名を **`.venv`** に統一することを提案する。Python 3.15 をターゲットとする。

## 背景

現状、Python の仮想環境は `venv`, `.venv`, `env`, `.env` など複数の命名規則が混在しており、ツール間の自動検出・連携が不一致を起こしていた。

## 提案内容

### 3 つのロケーションカテゴリ

1. **ローカル作成仮想環境**: プロジェクトごとの `.venv` サブディレクトリ
2. **名前付き仮想環境**: ドットプレフィックスでツールから隠す（`.venv-dev` 等）
3. **複数 Python バージョン管理**: バージョンをまたいだ統一的な仮想環境管理

### 推奨事項

- プロジェクトルートの `.venv` サブディレクトリをデフォルト先とする
- `.venv` を使用しない場合はデフォルトパスマッピングファイルを作成する

## ステータス

- 提出日: 2026年4月17日
- 状態: **Draft**
- ターゲット: Python 3.15

## コミュニティの反応

- Python フォーラムで議論が活発化
- 一部メンテナは「合意形成への懐疑」を表明
- 標準化へのコンセンサスが得られるかが今後の焦点

## 関連ページ

- [[wiki/rust-for-cpython]] — CPython への Rust 統合計画（Python の言語進化の並行トピック）
