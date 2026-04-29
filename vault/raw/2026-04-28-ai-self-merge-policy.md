# 人間レビューはもう不要？AIと人間のレビューの線引きを決めた話

- Source: https://ai.acsim.app/articles/introducing-self-merge-policy
- Published: 2026-04-28
- Author: Ryota Sasazawa (Acsim)

## Summary

AIによる開発増加でPRバックログが発生。「本当に全PRに人間の承認が必要か？」を検討。

**解決策:** Jeff Bezos のOne-Way Door / Two-Way Door フレームワークで「容易に元に戻せるか」を基準に判断。

**人間レビュー必須:**
- DBスキーマ変更、RLSポリシー、認証・認可システム
- インフラ/CI-CDデプロイ
- 基盤ライブラリの追加・置換
- チーム合意文書（Design Docs, ADR, コーディング規約）

**自動化:** Claude Code Actionが自動評価、self-merge可否と理由をコメント

**2週間の結果:**
- 159件中80%（127件）self-merge承認
- p90リードタイム: 132-316時間 → 92時間
- 24時間以内マージ率: 77%
