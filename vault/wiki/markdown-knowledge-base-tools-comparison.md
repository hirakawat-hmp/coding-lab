---
tags:
  - comparison
sources:
  - "[[raw/2026-04-07-markdown-knowledge-base-tools]]"
created: 2026-04-07
updated: 2026-04-07
---

# Markdown ナレッジベースツール比較（Obsidian 代替）

Obsidian 以外でローカル Markdown ファイル群を GUI で管理・閲覧できるツールの比較。[[wiki/llm-wiki-pattern]] との相性を重視して評価。

## 概要

ローカル Markdown ファイルをそのまま扱えるツールは意外と少ない。多くの「ローカルファースト」を謳うツールも内部形式は独自 JSON やデータベースで、Markdown はインポート/エクスポート手段に過ぎない。LLM Wiki パターンのように LLM がファイルシステム上の `.md` ファイルを直接読み書きするワークフローでは、**プレーン Markdown をネイティブに扱うツール**に絞られる。現実的な選択肢は Logseq、Zettlr、Foam（VS Code）の 3 つ。Dendron もプレーン Markdown だが 2023 年に開発停止しメンテナンスモードのためリスクがある。SiYuan や AnyType はローカルファーストだが独自形式のため LLM 直接編集には不向き。クラウド系（Notion, Tana, Heptabase 等）はそもそもローカルファイルアクセスができない。

## 比較表

| ツール | ファイル形式 | ストレージ | グラフビュー | バックリンク/WikiLink | OSS/有料 | LLM Wiki 相性 |
|--------|-------------|-----------|-------------|---------------------|----------|--------------|
| **Logseq** | Markdown/org-mode | ローカル | あり | あり | OSS (AGPL) | **◎ 高い** — プレーン MD を直接読み書き可。ただしブロック参照の UUID に注意 |
| **Zettlr** | Markdown | ローカル | なし（リンク一覧のみ） | WikiLink 対応 | OSS (GPL) | **◎ 高い** — 純粋な Markdown エディタ。学術向け機能（Zotero, Pandoc）が強み |
| **Foam** | Markdown | ローカル | あり | あり | OSS (MIT) | **◎ 高い** — VS Code 拡張なので LLM 編集と完全互換。最軽量の選択肢 |
| **Dendron** | Markdown | ローカル | あり | あり | OSS (Apache 2.0) | **△ 注意** — プレーン MD だが 2023 年に開発停止。階層命名規約（ドット区切り）が独自 |
| **SiYuan** | JSON (.sy) | ローカル/セルフホスト | あり | あり（ブロック単位） | OSS (AGPL) | **× 不向き** — 内部形式が JSON + SQLite。LLM が直接編集すると破損リスク |
| **AnyType** | Any-Block (protobuf) | ローカル(P2P同期) | あり | あり | OSS (各種) | **× 不向き** — 独自バイナリ形式。MD エクスポートは可能だがインポート経由のみ |
| **AFFiNE** | JSON/独自 | ローカル/クラウド/セルフホスト | なし | あり | OSS (MIT) | **× 不向き** — Notion 風 UI だが内部形式が独自。直接ファイル編集不可 |
| **Trilium** | HTML (内部DB) | セルフホスト | あり（リンクマップ） | あり | OSS (AGPL) | **× 不向き** — SQLite DB 内に HTML 保存。ファイルシステム上に MD なし |
| **Joplin** | Markdown (内部DB) | ローカル/クラウド同期 | なし | プラグインで対応 | OSS (AGPL) | **△ 注意** — MD だが SQLite DB 内に格納。ファイルシステム直接アクセス不可 |
| **AppFlowy** | 独自 | ローカル/セルフホスト | なし | 限定的 | OSS (AGPL) | **× 不向き** — Notion 代替だが独自形式 |
| **Notion** | 独自ブロック | クラウド | なし | あり | 有料(フリー枠あり) | **× 不可** — API 経由のみ。ローカルファイルなし |
| **Capacities** | 独自 | クラウド | あり | あり | 有料(フリー枠あり) | **× 不可** — クラウド専用 |
| **Heptabase** | 独自 | クラウド | キャンバス型 | あり | 有料 | **× 不可** — クラウド専用、ビジュアル特化 |
| **Reflect** | 独自 | クラウド(E2E暗号化) | あり | あり | 有料 | **× 不可** — クラウド専用 |
| **Tana** | 独自(ノード) | クラウド | なし | あり(ノード参照) | 有料(フリー枠あり) | **× 不可** — クラウド専用、エクスポート限定的 |
| **Docmost** | Markdown | セルフホスト | なし | 限定的 | OSS (AGPL) | **○ 可能** — チーム Wiki 向け。API 経由で操作可能だがファイル直接編集とは異なる |

## LLM Wiki パターンに最適なツール

### 第1候補: Logseq

- Obsidian と同様にプレーン Markdown ファイルをそのまま使用
- グラフビュー・バックリンクが標準装備
- ブロックベースのアウトライナーなので、全行がリスト項目（`- `）になる点が Obsidian との違い
- LLM が生成した通常の Markdown（見出し + 段落）はそのまま表示されるが、Logseq ネイティブの操作感とは異なる
- 2025 年に DB 版（Logseq DB）への移行が進行中で、将来的にプレーン MD から離れる可能性あり

### 第2候補: Foam (VS Code 拡張)

- VS Code 上で動作するため、LLM（Claude Code 等）と同じ環境で完結
- プレーン Markdown + WikiLink をそのまま扱う
- グラフビューあり（VS Code パネル内）
- プラグインエコシステムは Obsidian より小さいが、VS Code 拡張で補完可能
- 最もシンプルで LLM Wiki パターンとの摩擦が少ない

### 第3候補: Zettlr

- 学術・長文執筆向けの Markdown エディタ
- WikiLink 対応、YAML フロントマター完全サポート
- グラフビューはないが、リンク一覧・バックリンク表示あり
- Zotero 連携、Pandoc エクスポートが強み
- LLM が生成する標準的な Markdown と完全互換

## 結論

LLM Wiki パターン（LLM がファイルシステム上の `.md` を直接読み書き）との相性で見ると、現実的な Obsidian 代替は **Logseq**、**Foam**、**Zettlr** の 3 択。このうち Logseq は DB 版移行のリスク、Zettlr はグラフビュー欠如がそれぞれ弱点。Foam は最軽量だがエコシステムが小さい。現時点では Obsidian が依然としてこのパターンに最も適したツールであり、代替を選ぶ明確な理由がなければ Obsidian を継続するのが合理的。
