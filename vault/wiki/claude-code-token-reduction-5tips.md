---
type: how-to
status: [verified]
tags:
  - tool/claude-code
sources:
  - "https://qiita.com/ennagara128/items/26e7168007e80024cf54"
created: 2026-05-03
updated: 2026-05-03
---

# Claude Code トークン消費を抑える5つの実務テクニック

著者：ennagara128（同氏は [[wiki/claude-code-three-layer-design]] も執筆）。  
「外部ツール不要でレート制限を回避しながらコード品質を維持できる」実践手法。

> [[wiki/mcp-token-optimization]] が MCP 通信路のトークン最適化なのに対し、こちらは Claude Code 全体のトークン管理。

## テクニック1：`.claudeignore` の設定

```
node_modules/
dist/
*.lock
.env*
```

Claude が不要ファイルを読み込まないよう除外。単純だが効果大。

## テクニック2：Skills の活用

繰り返しタスクを短いコマンドで呼び出せる Skills に変換。長い手順書を毎回入力する代わりに `/deploy` などの短いコマンドで実行。

**効果：** 入力トークンを大幅削減。

## テクニック3：サブエージェント委譲

大きな中間データ処理（ファイル変換・大量検索結果の処理など）をサブエージェントに委譲し、メイン会話コンテキストを汚染しない。

長時間セッションでのコンテキスト肥大化防止に特に有効。

## テクニック4：CLAUDE.md の最小化

- プロジェクト固有ルールのみ記載
- 詳細手順は別ファイルに分離し、import 構文で参照
- 不要な説明を排除し、指示密度を高める

## テクニック5：選択的ファイル読み込み

```
# 行番号指定
Read(file_path, offset=100, limit=50)

# grep ターゲティング
grep -n "function handleSubmit" src/
```

大きなファイルを丸ごと読まず、必要な行範囲のみを読み込む。**ファイルあたり最大90%削減**が可能。

## まとめ

| テクニック | 主な効果 |
|-----------|---------|
| .claudeignore | 不要ファイルの除外 |
| Skills | 繰り返し入力削減 |
| サブエージェント | コンテキスト汚染防止 |
| CLAUDE.md 最小化 | 常時読み込みコスト削減 |
| 選択的読み込み | ファイル読み込み90%削減 |

**関連ページ:** [[wiki/mcp-token-optimization]] — MCPサーバーのトークン最適化（別アプローチ）  
**関連ページ:** [[wiki/claude-code-three-layer-design]] — 同著者の3層設計パターン  
**関連ページ:** [[wiki/claude-code-project-conventions]] — プロジェクト規約自動抽出
