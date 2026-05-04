---
type: concept
status: []
tags:
  - design/system
  - ai/agent
  - ui/components
sources:
  - "https://japan.zdnet.com/article/35247011/"
  - "https://startupfortune.com/ai-agents-are-killing-fixed-app-interfaces-turning-software-into-disposable-pixels/"
  - "https://chrisloy.dev/post/2026/02/14/when-interfaces-become-disposable"
created: 2026-05-04
updated: 2026-05-04
---

# 使い捨てUI（Disposable UI）パラダイム

AIエージェントが固定アプリのUIをタスク特化の一時的なインターフェースに置き換えるという、ソフトウェア設計の新しいパラダイムシフト。

## コアコンセプト

従来のアプリ設計では「画面（UI）」が耐久資産だった。使い捨てUIパラダイムでは：

**耐久資産**（変わらない）：
- データ
- パーミッション
- ワークフローロジック
- API
- 監査証跡
- ドメインモデル

**使い捨てもの**（タスクごとに生成・廃棄）：
- UIそのもの

## なぜ可能になったか

> 「AIが数秒でDBクエリ・可視化・カスタムUIを構築できるなら、固定アプリは作業の起点である必要はない」

AIエージェントがユーザーの意図を解釈し、そのタスクに最適なUIをオンデマンドで生成できる時代になった。

## デザイナーへの影響

| 従来 | 使い捨てUIパラダイム |
|------|---------------------|
| 毎画面を描く | AIが何を組み立て可能かの制約を定義する |
| 静的コンポーネントライブラリ | AIが組み立てる際のルールセット |
| ユーザーフローの設計 | AIに何を確認させるかを設計 |

## Cloudera 2026年予測

- エンタープライズ内で短命のAI生成アプリが増加
- ガバナンスへの圧力が高まる
- 誰でもUI付きアプリを即時生成できる一方で、説明責任の仕組みが必要

## TSRX との関連

[[wiki/tsrx-ui-framework]] は「使い捨てUI時代にAI生成コードが壊れないデザイン」を目指した先行実装と見ることができる。

## 批判的視点

- 重要なフローでの人間の意思決定をどう組み込むか
- アクセシビリティは使い捨てUIで保証できるか
- セキュリティレビューが追いつかないリスク

## 関連ページ

- [[wiki/tsrx-ui-framework]] — TSRX AI時代のUIコンポーネントフレームワーク
- [[wiki/ag-ui-protocol]] — AIエージェントとフロントエンドを繋ぐ標準プロトコル
- [[wiki/tui-accessibility-nightmare]] — UIのアクセシビリティ問題（TUI文脈だが適用可能）
- [[wiki/google-labs-design-md]] — DESIGN.md という「使い捨てUI時代のデザイン制約定義」
