# ベクトルを使わないRAG。全てのナレッジを階層化する手法

- Source: https://zenn.dev/knowledgesense/articles/7dddae04a7d828
- Published: 2026-04-28
- Author: Atsushi Kadowaki

## Summary

**Corpus2Skill**: ベクトルDBを使わずに企業知識を階層ディレクトリ構造に整理し、LLMエージェントが目次を辿るようにナビゲートするRAG手法。

**4ステップ準備:**
1. 埋め込みとk-meansによるドキュメントのクラスタリング
2. LLMによるクラスター内容のサマリー化
3. 反復クラスタリングによる階層ピラミッド構築
4. SKILL.md と INDEX.md ファイルとして整理

**結果:** WixQAベンチマークで優れた性能。階層深さO(log N)でスケーラブル。ベクトルDBインフラ不要。

OGP: https://static.zenn.studio/user-upload/8de5c9aec913-20260425.png
