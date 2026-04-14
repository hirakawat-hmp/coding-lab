---
type: entity
status: []
tags:
  - tool/officecli
  - ai/agent
sources:
  - "https://github.com/iOfficeAI/OfficeCLI"
  - "https://officecli.ai"
created: 2026-04-14
updated: 2026-04-14
---

# OfficeCLI

AI エージェント向けに設計された、Office ドキュメント（Word / Excel / PowerPoint）の作成・読取・編集を行うコマンドラインツール。iOfficeAI が開発。オープンソース（GitHub）で、.NET ランタイム内蔵のシングルバイナリとして配布される。Microsoft Office のインストールは不要。

## 基本情報

| 項目 | 詳細 |
|------|------|
| リポジトリ | [iOfficeAI/OfficeCLI](https://github.com/iOfficeAI/OfficeCLI) |
| ライセンス | オープンソース |
| 言語 | .NET（シングルバイナリ、ランタイム内蔵） |
| 対応形式 | `.docx`, `.xlsx`, `.pptx` |
| 対応 OS | macOS (ARM64/x64), Linux (x64/ARM64), Windows (x64/ARM64) |
| 最新版 | v1.0.45（2026-04-13） |

## 3 層アーキテクチャ

OfficeCLI は 3 つのレイヤーで構成され、上位レイヤーを優先して使う設計。

| レイヤー | 目的 | コマンド |
|----------|------|---------|
| **L1: Read** | ドキュメントの意味的なビュー | `view`, `get`, `query`, `validate` |
| **L2: DOM** | 要素レベルの構造操作 | `set`, `add`, `remove`, `move`, `swap`, `batch` |
| **L3: Raw XML** | XPath による直接 XML アクセス | `raw`, `raw-set`, `add-part` |

## 主要コマンド

### ドキュメント操作

```bash
officecli create deck.pptx                          # 新規作成
officecli view deck.pptx outline                    # 構造確認
officecli get deck.pptx '/slide[1]' --depth 2 --json  # 要素取得
officecli query deck.pptx 'shape[fill=FF0000]'      # CSS ライク検索
officecli validate report.docx                       # スキーマ検証
```

### 編集操作

```bash
# プロパティ設定
officecli set deck.pptx '/slide[1]/shape[1]' --prop text="Hello" --prop bold=true

# 要素追加
officecli add deck.pptx / --type slide --prop title="Q4 Report"

# テキスト検索・置換（正規表現対応）
officecli set doc.docx / --prop find=draft --prop replace=final

# バッチ操作（複数操作を1回の保存で実行）
officecli batch deck.pptx --commands '[{"op":"set","path":"/slide[1]/shape[1]","props":{"text":"Hi"}}]'
```

### ライブプレビュー

```bash
officecli watch deck.pptx --port 26315  # ブラウザでリアルタイムプレビュー
```

ブラウザ上でシェイプをクリック選択でき、エージェントが `get <file> selected` で選択状態を読み取れる。

### レジデントモード

```bash
officecli open report.docx   # メモリに保持（高速化）
officecli set report.docx ...
officecli close report.docx  # 保存して解放
```

毎コマンドでファイル I/O を行わず、ニアゼロレイテンシで操作可能。デフォルトで自動レジデント（60 秒アイドルタイムアウト）。

## 安定 ID アドレッシング

位置インデックス（`/slide[1]/shape[2]`）は要素の追加・削除でずれるため、安定 ID（`/slide[1]/shape[@id=550950021]`）の使用が推奨される。`get` コマンドは安定 ID 形式のパスを返す。

## ヘルプシステム

プロパティ名を推測せず、階層的ヘルプでディスカバリーする設計:

```bash
officecli pptx set              # 設定可能な全要素一覧
officecli pptx set shape        # シェイプのプロパティ一覧
officecli pptx set shape.fill   # fill の詳細フォーマット
```

## AI エージェント連携

### SKILL.md

`SKILL.md` ファイルが同梱されており、コマンド構文・アーキテクチャ・よくある落とし穴を網羅。エージェントのチャットに `curl -fsSL https://officecli.ai/SKILL.md` を貼るだけで即利用可能。

### MCP サーバー

組み込みの MCP サーバーにより、シェルアクセスなしで JSON-RPC 経由で全操作を公開:

```bash
officecli mcp claude    # Claude Code に登録
officecli mcp cursor    # Cursor に登録
officecli mcp vscode    # VS Code / Copilot に登録
```

### スキル自動インストール

```bash
officecli install  # PATH にコピー + 検出された全 AI エージェントにスキル登録
```

Claude Code、Cursor、Windsurf、GitHub Copilot 等を自動検出。

## Marks（編集提案）

`mark` コマンドで非永続的な編集提案を作成し、watch プレビュー上でハイライト表示。人間がレビュー後に適用するヒューマン・イン・ザ・ループ・ワークフローを実現。

```bash
officecli mark doc.docx '/body/p[1]' --prop find="誤字" --prop tofix="正字" --prop note="修正提案"
officecli get-marks doc.docx --json  # 提案一覧取得
officecli unmark doc.docx --all       # 全提案クリア
```

## 対応機能の範囲

### Word (.docx)

段落、ラン、テーブル、スタイル、ヘッダー/フッター、画像、数式、コメント、脚注、透かし、ブックマーク、目次、チャート、ハイパーリンク、セクション、フォームフィールド、コンテンツコントロール（SDT）、フィールド、OLE オブジェクト

### Excel (.xlsx)

セル、数式（150+ 組込関数、自動評価）、シート、テーブル、条件付き書式、チャート、ピボットテーブル（マルチフィールド、日付グルーピング、showDataAs、ソート、grandTotals、サブトータル、レイアウト選択）、スライサー、名前付き範囲、データ検証、画像、スパークライン、コメント、オートフィルター、シェイプ、OLE、CSV/TSV インポート

### PowerPoint (.pptx)

スライド、シェイプ、画像、テーブル、チャート、アニメーション、モーフトランジション、3D モデル（.glb）、スライドズーム、数式、テーマ、コネクター、ビデオ/オーディオ、グループ、ノート、OLE、プレースホルダー

## よくある落とし穴

1. **ヘルプを使わない**: プロパティ名の推測 → 失敗 → リトライのループは非効率。`officecli <format> set <element>` で確認
2. **ループ内で位置インデックスを使う**: 挿入/削除でずれる。安定 ID `@id=value` を使う
3. **大きなファイルで出力を制限しない**: `--max-lines`, `--start`, `--end` を活用
4. **Excel の marks は常に stale**: v1 では `.xlsx` のセレクション/マーク非対応

## 関連ツール

- [[wiki/aionui]] — OfficeCLI をバックエンドとする GUI デスクトップアプリ
- [[wiki/python-pptx]] — Python による PPTX 操作ライブラリ（OfficeCLI はより広範なフォーマット対応）
- [[wiki/pptxgenjs]] — JavaScript PPTX 生成ライブラリ
- [[wiki/ai-pptx-generation-overview]] — AI PPTX 生成アプローチの概観
