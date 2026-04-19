# Claude Code で仕事しながら英語を学ぶ環境を整えてみた

**Source:** https://dev.classmethod.jp/articles/claude-code-working-in-english-environment-setup/
**Fetched:** 2026-04-19
**Published:** 2026-04-17 (はてブで 2026-04-18 トレンド)
**Author:** kasama (yosh-k) / DevelopersIO

## 概要

Claude Code の設定・スキル・フックを組み合わせ、業務効率を損なわずに英語学習環境を構築する手順。

## 構成要素

| コンポーネント | 役割 |
|------|------|
| 言語設定（settings.json） | Claude Code の出力言語を英語に設定 |
| EnglishCoach 出力スタイル | 日本語入力→英語翻訳、英語入力→文法修正 |
| english-log スキル | 文法修正・語彙をMarkdownテーブルに自動記録 |
| Kokoro TTS | 英語応答を音声で読み上げ |
| DeepL Desktop | Ctrl+Shift+L で即座に翻訳 |

## 入力補助

- Mac 標準音声入力 or Aqua Voice: 複雑な指示は日本語で音声入力
- DeepL Desktop: 未知の単語を即翻訳

## 設定ファイルの場所

`~/.claude/` 配下に hooks、skills、output-styles を配置。

## ポイント

「仕事しながら学ぶ」という理念。英語ネイティブ環境に浸りながら業務効率は維持。

Thumbnail: https://images.ctfassets.net/ct0aopd36mqt/3KBTm8tdpO9RJJuaVvVzod/a9964bb03097b448b2327edc6920bf9f/Claude.png?w=3840&fm=webp
