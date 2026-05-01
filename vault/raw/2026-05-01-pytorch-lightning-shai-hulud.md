# Shai-Hulud Malware in PyTorch Lightning — Supply Chain Attack

source: https://semgrep.dev/blog/2026/malicious-dependency-in-pytorch-lightning-used-for-ai-training/
fetched: 2026-05-01

## 概要

2026年4月30日、PyPI パッケージ `lightning`（バージョン2.6.2・2.6.3）に悪意あるコードが混入。Semgrepが発見。AI学習ライブラリを狙ったサプライチェーン攻撃。

## 攻撃メカニズム

- インポート時に `_runtime` 隠しディレクトリからJavaScriptを起動
- 難読化された14.8MBのペイロードをダウンロード・実行

## 窃取対象

- GitHubトークン（ghp_, gho_, npm_）
- AWS認証情報（IMDSv2, Secrets Manager）
- Azure Key Vaultシークレット
- GCP Secret Managerエントリ
- CI/CDパイプライン変数

## 永続化手法

- Claude Code: `.claude/settings.json` の SessionStart hooks に dropper を仕込む
- VS Code: `.vscode/tasks.json` の folderOpen tasks に仕込む
- dropper実行ファイル: `setup.mjs`

## IoC（侵害の痕跡）

- コミットプレフィックス: `EveryBoiWeBuildIsAWormyBoi`
- リポジトリdescription: `A Mini Shai-Hulud has Appeared`

## 推奨対策

1. `lightning 2.6.2` および `2.6.3` のスキャン
2. `.claude/` `.vscode/` ディレクトリの注入ファイル確認
3. 全露出認証情報のローテーション
