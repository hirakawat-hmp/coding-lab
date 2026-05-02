# NVIDIA NemoClaw AIエージェント特権リスク

source: https://atmarkit.itmedia.co.jp/ait/articles/2605/01/news057.html
retrieved: 2026-05-02

## 概要
ABI ResearchがNVIDIAのGTC 2026カンファレンスで発表したNemoClawは、AIエージェント用セキュリティスタック。
オープンソースの「OpenClaw」プラットフォームにエンタープライズグレードのセキュリティ機能を追加。

## OpenClawの特徴
- 2026年1月に公開
- ローカルデバイスのファイルやツールに「統一的かつ自動的にタスク実行」できるシステム
- GitHubで開発中

## 特権リスク（Clawブーム）
- AIエージェントの広がりに伴い、本質的なセキュリティと統治の課題
- デバイスリモートアクセスが必要な設計上、「ガバナンスとセキュリティの大きな課題」

## NemoClawの対応
OpenShellレイヤーを通じて：
- エージェントのデータアクセス制御
- ツール使用権限管理
- ユーザー設定ポリシー管理
