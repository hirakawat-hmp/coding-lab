---
type: entity
status: []
tags:
  - tool/vscode
  - ai/agent
  - tool/claude-code
sources:
  - "https://zenn.dev/headwaters/articles/f629e2f92828e7"
created: 2026-05-04
updated: 2026-05-04
---

# VS Code 1.118

2026年4月29日リリース。GitHub Copilot従量課金移行（2026年6月）を前に複数の最適化が入った主要アップデート。

## 主要新機能

### 1. スキルの独立コンテキスト実行

frontmatterに`context: fork`を指定することでカスタムスキルを**独立したサブエージェント**として実行できる。

```yaml
---
context: fork
---
```

メインの会話コンテキストは一切影響を受けないため、重いタスクを分離できる。

### 2. リモートコントロール機能

GitHub.comやスマホアプリから**GitHub Copilot CLIの進捗確認と承認**が可能になった。長時間タスクを手元のデバイスから監視・操作できる。

### 3. トークン効率の大幅改善

| 最適化 | 効果 |
|--------|------|
| プロンプトキャッシュ最適化 | 93%以上のリクエストがキャッシュ再利用 |
| ツール検索ツール導入 | 最大20%のトークン削減 |
| OpenAI WebSocket通信 | 12%高速化 |

### 4. Chronicle機能

チャット履歴をSQLiteで構造化し、以下のコマンドが使えるようになった：

```
/chronicle:standup   → スタンドアップレポートを生成
/chronicle:tips      → 使用方法の改善提案
```

### 5. セマンティック検索の拡大

全ワークスペースで「単語ではなく意味で検索」が可能に。命名規則が統一されていないコードベースでも効果的。

## その他の改善

- TypeScript 7.0 Betaサポート強化
- Dev Container ロックファイルのデフォルト有効化
- GitHub テキスト検索ツール追加

## 関連ページ

- [[wiki/typescript-7-beta]] — TypeScript 7.0 Beta（このリリースでサポート強化）
- [[wiki/github-copilot-usage-billing]] — GitHub Copilot 利用量ベース課金への移行
- [[wiki/claude-code-project-conventions]] — context: fork パターンとの比較
