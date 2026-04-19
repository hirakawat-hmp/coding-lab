---
type: how-to
status: [draft]
tags:
  - tool/claude-code
  - ai/llm
sources:
  - "https://dev.classmethod.jp/articles/claude-code-working-in-english-environment-setup/"
created: 2026-04-19
updated: 2026-04-19
---

# Claude Code で業務しながら英語学習する環境構築

![Claude Code English Learning](https://images.ctfassets.net/ct0aopd36mqt/3KBTm8tdpO9RJJuaVvVzod/a9964bb03097b448b2327edc6920bf9f/Claude.png?w=3840&fm=webp)

Claude Code の設定・カスタムスキル・フック・TTS を組み合わせて、業務効率を損なわずに英語学習環境を実現する手順（DevelopersIO 2026年4月）。

## 必要なコンポーネント

| コンポーネント | 役割 | 設定場所 |
|------|------|------|
| `language` 設定 | Claude の応答言語を英語に | `~/.claude/settings.json` |
| `EnglishCoach` 出力スタイル | 日本語入力→英語翻訳 / 英語入力→文法修正 | `~/.claude/output-styles/` |
| `english-log` スキル | 文法修正・語彙を Markdown テーブルに自動記録 | `~/.claude/skills/` |
| Kokoro TTS | 英語応答を音声で読み上げ | フックで連携 |
| DeepL Desktop | Ctrl+Shift+L で即翻訳 | 外部ツール |

## 設定手順

### 1. 言語設定

`~/.claude/settings.json` に追加:
```json
{
  "language": "en"
}
```

### 2. EnglishCoach 出力スタイル

`~/.claude/output-styles/english-coach.md` を作成:
- 日本語入力 → 英語に翻訳して応答
- 英語入力 → 文法・語彙を修正してから応答

### 3. english-log スキル

`/english-log` コマンドで呼び出すと、セッション中の文法修正と新語彙を Markdown テーブルにまとめて記録。

### 4. Kokoro TTS 連携（任意）

`PostToolUse` フックで Claude の応答テキストを Kokoro TTS に渡し、自動音声再生。

## 入力補助

- **Mac 標準音声入力 / Aqua Voice**: 複雑な日本語指示は音声入力 → 英訳して Claude に渡す
- **DeepL Desktop**: 未知の英単語を即時翻訳（Ctrl+Shift+L）

## 設計思想

「仕事しながら学ぶ」という immersion アプローチ。英語ネイティブ環境に浸りながら業務生産性は維持する。

## 関連ページ

- [[wiki/claude-code-hooks]] — フックシステムの仕組み
- [[wiki/claude-code-routines]] — Claude Code 自動実行の全体像
