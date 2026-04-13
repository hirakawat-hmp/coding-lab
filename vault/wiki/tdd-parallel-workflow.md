---
tags:
  - insight
sources:
  - "/Users/hdymacuser/Desktop/feederrrr/.serena/memories/development_workflow.md"
created: 2026-04-06
updated: 2026-04-06
---

# TDD 並列開発ワークフロー

AI コーディングエージェント（Claude Code subagent）を活用し、探索・計画・実装を並列化する TDD ワークフロー。

## 全体構造: 3フェーズ

### Phase 1: 探索フェーズ（並列実行）

2つの調査を同時に走らせる:

1. **内部コードベース分析** -- 既存コードパターン、類似機能の実装方法を調査
2. **外部ドキュメント調査** -- 最新のベストプラクティス、ライブラリドキュメントを確認

### Phase 2: TDD 開発フェーズ

#### 2-1. 計画

TDD 実装計画を立案する:
- Red-Green-Refactor サイクルの設計
- バックエンド/フロントエンドの責務分離
- テスト戦略策定
- **並列実装可能性の判断**（最重要）

#### 2-2. 並列実装（独立している場合）

**バックエンド**:
1. **RED**: Vitest 統合テスト作成
2. **GREEN**: Agent/API 実装
3. **REFACTOR**: エラーハンドリング、型安全性向上

**フロントエンド**:
1. **RED**: Vitest コンポーネントテスト作成
2. **GREEN**: UI コンポーネント実装
3. **REFACTOR**: アクセシビリティ向上、Storybook ストーリー作成

### Phase 3: 統合・検証

1. 並列実装の統合
2. E2E テスト（必要に応じて）
3. 完了チェックリスト実行
4. コミット

## ベストプラクティス

### テストファースト

実装前に必ずテストを書く。テストが失敗することを確認してから実装に入る。

### 並列実行の活用

バックエンドとフロントエンドが独立している場合は並列に実装する。依存関係がある場合は順次実行。

### Storybook 実行の制限

- ストーリーファイル（`.stories.tsx`）は実装者が作成する
- ただし `npm run storybook` の起動はメインプロセスのみが行う
- 理由: ポート競合やリソース問題の防止

### 外部 API 実装時の徹底検証

- ドキュメント精読
- 実 API レスポンス検証
- 構造の文書化
- 推測での実装厳禁

（詳細は [[wiki/external-api-integration-lessons]] 参照）

## Agent 構成例

| Agent 名 | 役割 | タイミング |
|-----------|------|-----------|
| serena-explore | 内部コードベース分析 | Phase 1 |
| research | 外部ドキュメント調査 | Phase 1 |
| tdd-planner | TDD 実装計画立案 | Phase 2-1 |
| ui-implementor | フロントエンド実装 | Phase 2-2 |
| backend-implementor | バックエンド実装 | Phase 2-2 |

## 技術スタック（典型例）

- **Frontend**: Next.js + shadcn/ui + Storybook + Vitest
- **Backend**: Mastra + Next.js API Routes + Vitest
- **AI**: Google Gemini 2.5 Pro

## 関連ページ

- [[wiki/mastra-patterns]] -- バックエンド実装で使用する Mastra のパターン
- [[wiki/shadcn-storybook-integration]] -- フロントエンド実装の UI 開発環境
- [[wiki/external-api-integration-lessons]] -- 外部 API 実装時の注意事項
