# pu.sh — 400行shellのコーディングエージェントハーネス

source: https://pu.dev/
fetched: 2026-05-01

## 概要

Show HN で紹介されたコーディングエージェントハーネス。約400行のシェルスクリプトで実装されており、npm・pip・Dockerなど重い依存関係なしで動作する。

## 技術詳細

依存関係: `curl`（HTTPリクエスト）+ `awk`（テキスト処理）+ APIキー（LLM連携）のみ

インストール:
```bash
curl -sL pu.dev/pu.sh -o pu.sh && chmod +x pu.sh
```

## 設計思想

「ポケットに入るほど小さなスロップキャノン」（slop cannon small enough to fit your pocket）——軽量・自己完結・ポータブルを重視。

## ライセンス・リポジトリ

- GitHub: NahimNasser/pu
- ライセンス: MIT
- サイト: pu.dev
