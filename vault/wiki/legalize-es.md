---
type: entity
status: []
tags:
  - dev/git
  - dev/markdown
  - policy/regulation
sources:
  - "https://gigazine.net/news/20260425-legalize-es/"
created: 2026-04-26
updated: 2026-04-26
---

# legalize-es

![legalize-es](https://i.gzn.jp/img/2026/04/25/legalize-es/00_m.png)

スペインの全法律（8,600以上）をMarkdown形式でGitHubに公開するプロジェクト。2026年3月にIT系独立コンサルタントのEnrique Lopez氏が Claude Code を使って約4時間弱で開発した。Hacker Newsでも話題になった。

## 概要

各法律は個別のMarkdownファイルとして管理され、法改正はGitコミットとして記録される。連邦法と17の自治州法がディレクトリで分類整理されている。

## 技術構造

```
legalize-es/
├── federal/        # 連邦法
│   ├── civil-code.md
│   ├── penal-code.md
│   └── ...
└── autonomous/     # 自治州法（17州）
    ├── cataluna/
    └── ...
```

各ファイルの構造：
- **YAML frontmatter**: メタデータ（法律番号・発効日・改正履歴）
- **本文**: Markdown形式

## 主な利点

### 法改正の追跡
```bash
git log -- federal/civil-code.md   # 改正履歴を確認
git diff HEAD~1 HEAD -- federal/civil-code.md  # 最新改正の差分
```

### 透明性と再利用性
- Markdown形式により人間が読みやすい
- LLMへの入力として直接利用可能
- リーガルテック・コンプライアンス分野でのビジネス展開が容易

## 意義

法律をGitで管理するアイデア自体は以前からあるが、LLM（Claude Code）の助けを借りて個人が短期間で8,600件の法律を変換・整理できたことは、**AIによるレガシーデータの構造化**の典型例。

「ガバナンスのオープン化」と「テック的な透明性」を組み合わせた取り組みとして注目されている。

## 関連ページ

- [[wiki/japan-gov-ai-gennai]] — 政府AIのオープンソース化（同じくGov×Openの動き）
- [[wiki/dev/git]] — Gitの活用事例
