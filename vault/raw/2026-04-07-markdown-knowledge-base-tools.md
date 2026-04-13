# Markdown ナレッジベースツール調査（2026-04-07）

Obsidian 以外で、ローカル Markdown ファイル群を GUI で管理・閲覧できるアプリ・サービスの調査結果。

## 調査対象

### ローカルファイルベース・プレーン Markdown
- **Logseq**: OSS、ブロックベースアウトライナー、プレーン Markdown/org-mode。グラフビュー・バックリンク標準装備。日次ジャーナル中心。2025年にDB版へ移行中。
- **Zettlr**: OSS、学術向け Markdown エディタ。Zotero 連携、YAML フロントマター対応、Pandoc エクスポート。プレーン Markdown。モバイルアプリなし。
- **Foam**: VS Code 拡張。OSS、無料。プレーン Markdown + wikilink。グラフビューあり。開発はアクティブだが規模小。
- **Dendron**: VS Code 拡張。2023年にメンテナンスモードへ移行（開発停止）。Apache 2.0 ライセンス。階層的ファイル命名（ドット区切り）。プレーン Markdown。

### 独自形式だがローカルファースト
- **SiYuan**: 中国発 OSS。内部形式は JSON（.sy ファイル）。ブロックベース、SQLite インデックス。Markdown エクスポート可能だがプレーン Markdown ではない。セルフホスト対応。
- **AnyType**: P2P 同期、E2E 暗号化。独自 Any-Block 形式（protobuf/JSON）。Markdown インポート/エクスポート対応だが内部はプレーン MD ではない。OSS。
- **AFFiNE**: OSS、Notion + Miro 統合型。JSON/Markdown ベースだが独自形式。ホワイトボード・DB 機能。セルフホスト可。AI 内蔵。
- **Trilium**: セルフホスト型。階層ノート。HTML ベースの内部形式。Markdown インポート/エクスポート可。Docker で簡単デプロイ。

### クラウド中心（非ローカルファイル）
- **Notion**: プロプライエタリ。独自ブロック形式。Markdown エクスポート可。API あり。
- **Capacities**: クラウド。オブジェクト指向 PKM。独自形式。Markdown エクスポート限定的。
- **Heptabase**: クラウド。ビジュアルキャンバス型。ローカルファイルなし。
- **Reflect**: クラウド。AI 統合。E2E 暗号化。独自形式。
- **Tana**: クラウド。スーパーライナー（ノードベース）。独自形式。エクスポート限定的。

### セルフホスト型 Wiki
- **Docmost**: Notion 風の wiki。セルフホスト。Markdown サポート。チーム向け。
- **AppFlowy**: OSS Notion 代替。セルフホスト可。Flutter ベース。独自形式だが Markdown エクスポート対応。

## LLM Wiki パターンとの相性評価

プレーン Markdown ファイルを直接読み書きする LLM Wiki パターンでは：
- Logseq, Zettlr, Foam が最も相性が良い（プレーン Markdown をそのまま使用）
- Dendron もプレーン Markdown だが開発停止がリスク
- SiYuan, AnyType, AFFiNE は独自形式のため、LLM が直接ファイルを編集すると壊れる可能性
- クラウド系（Notion, Tana, Capacities 等）はローカルファイルアクセス不可
