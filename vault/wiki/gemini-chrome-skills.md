---
type: entity
status: []
tags:
  - ai/llm
  - ai/agent
sources:
  - "https://wired.jp/article/how-to-use-google-chrome-ai-powered-skills/"
created: 2026-05-01
updated: 2026-05-01
---

# Gemini in Chrome Skills — ブラウザ統合AI再利用可能プロンプト機能

![Gemini Chrome Skills](https://media.wired.jp/photos/69eda7b438f6fd591d6aa8f5/master/w_2560%2Cc_limit/GettyImages-2253795269.jpg)

Google Chromeに追加されたAI機能「Skills」。キーボードショートカット（スラッシュ `/`）で呼び出せる再利用可能なAIプロンプトライブラリ。米国では2026年4月中旬から提供開始、日本では「Gemini in Chrome」（4月21日開始）に伴い順次展開。

## 機能概要

- **50種類以上**のプリセットプロンプトライブラリ
- カスタムSkills作成機能
- スラッシュ `/` 入力でSkillsメニューが表示

## 使用例

| Skill名 | 動作 |
|---------|------|
| `/Protein max` | 現在のページのレシピを分析し、タンパク質含有量を推定 |
| YouTube要約 | 再生中の動画を要約 |
| 求人評価 | 求人ページのフィットを評価 |

## 位置づけ

Gemini in ChromeをAIエージェントの操作基盤として位置づける試み。競合:
- **Microsoft Copilot InBrowser** — Edgeに統合
- **Arc Browse** — Arc Browserの閲覧AI

Googleとしては[[wiki/gemini-personal-intelligence]]（Gmail/Photos/GitHub横断RAG）と組み合わせてブラウザをAIのフロントエンドにする戦略の一環。

## [[wiki/skill-md-pattern]]との対比

Claude CodeのSKILL.mdパターンが「AIエージェントへの機能追加」だとすれば、Chrome Skillsは「ブラウザユーザーへのAI機能追加」。両者とも「再利用可能な手順書」という概念は同じ。

## 関連ページ

- [[wiki/gemini-personal-intelligence]] — Geminiパーソナルインテリジェンス（Gmail/Photos/GitHub統合）
- [[wiki/gemini-macos-app]] — GeminiネイティブmacOSアプリ
- [[wiki/skill-md-pattern]] — SKILL.mdパターン（Claude Code版「Skills」）
