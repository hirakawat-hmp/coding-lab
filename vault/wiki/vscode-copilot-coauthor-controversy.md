---
type: insight
status: []
tags:
  - dev/git
  - industry/tech
sources:
  - "https://github.com/microsoft/vscode/pull/310226"
created: 2026-05-03
updated: 2026-05-03
---

# VS Code「Co-authored-by Copilot」デフォルト化騒動

VS Code の PR #310226「Enabling ai co author by default」が 372 件の down vote を受けてコミュニティの反発を招いた事例。

## 何が起きたか

Microsoft が VS Code Git 拡張の設定 `git.addAICoAuthor` のデフォルト値を `"off"` → `"all"` に変更するプルリクエストを出した。

**実際の影響：**
- AI を全く使っていないコミットに `Co-authored-by: Copilot` が自動挿入される
- `"chat.disableAIFeatures": true` で AI 機能を無効化していても動作した
- ユーザーが気づかないまま属性が付与される

## コミュニティの反発

### 同意・透明性の問題

「コード所有権のメタデータを本人の知らないうちに書き換えることはユーザーの信頼を裏切る」という声が多数。

### 法的・ライセンス上の懸念

共著者の明記はライセンス帰属にも関わる。AI が実際に寄与していないコードに AI 共著者を付けることの法的曖昧さ。

### 技術的バグ

Copilot 自身のコードレビューが「設定スキーマとランタイムのフォールバックが整合していない」と検出した。

## 解決

2026年5月2日、コントリビューターの dmitrivMS が regression を認め、以下を約束：
- `disableAIFeatures` 設定を尊重するよう修正
- 誤った属性付与を防止
- テストカバレッジの向上

## 示唆：AI 帰属表示の時代的課題

AI が開発に関与する範囲が広がるにつれ、「誰が書いたか」の定義が揺らいでいる。この騒動は**デフォルト値の設計が倫理的・法的な意味を持つ**時代の到来を示している。

**関連ページ:** [[wiki/ai-era-engineering-shift]] — AI時代のエンジニアリング変化  
**関連ページ:** [[wiki/gh-skill-github-cli]] — GitHub CLIのAIスキル管理（supply chain保護含む）
