# Amazon Bedrock AgentCore Managed Harness

Source: Qiita https://qiita.com/ryu-ki/items/7437eb2403875bbd3c49
Fetched: 2026-04-28

## サービス概要

Amazon Bedrock AgentCoreは、2026年4月22日に「Amazon Bedrock AgentCore Managed Harness」がプレビュー公開されたAWSサービス。「コードを書くことなく、対話形式で簡単にエージェントを作ることができる」特徴を持つ。

## 主要機能

**作成・デプロイの簡素化**
- AgentCore CLIを使用した対話的なエージェント構築
- プロジェクト名、リソース種別、ハーネス設定などを段階的に入力して構成

**モデルプロバイダー**
Amazon Bedrock、OpenAI、Google Geminiから選択可能（呼び出し時にオーバーライド可）

**設定オプション**
- 環境設定（デフォルト、ECR、Dockerfile指定）
- メモリー設定
- ツール（BrowserやCode Interpreter）
- 認証・ネットワーク・ライフサイクル

**オブザーバビリティ**
実行トレースの確認により「エージェント側の実装に集中することができる」

## 対応リージョン

プレビュー段階：us-east-1、us-west-2、eu-central-1、ap-southeast-2（Node.js 20以上必要）
