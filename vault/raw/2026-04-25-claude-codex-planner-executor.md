# Claude Code は planner、Codex CLI は executor — 3ヶ月実測

**ソース:** https://qiita.com/nogataka/items/2668b9ca9d12f0bef1e5
**取得日:** 2026-04-26
**公開日:** 2026-04-25

## 記事内容

著者が3ヶ月間、Claude CodeとCodex CLIの両方を本番運用で検証。「どちらか一方を選ぶという前提そのものが古い」と結論。

### 各ツールの特性

**Claude Code（計画型）**
- 1M tokensの長文脈対応で大規模リポジトリ全体を把握
- Agent Teamsとフックイベント26種類で「思考過程への介入」が可能
- 「広く考える」設計思想

**Codex CLI（実行型）**
- Rust実装でカーネルレベルサンドボックス搭載
- トークン消費が1/4〜1/2程度（Express.js リファクタリング実測値）
- 「決まった手順を壊さず回す」効率性

### 実測値データ

Express.js大規模リファクタ（約1,200行差分）:
- Claude Code: 約6.2M トークン、1時間17分
- Codex CLI: 約1.5M トークン、1時間41分

小規模バグ修正ではCodexが優位（約180K vs 42K）

### 推奨分業モデル
「Claude Code が plan.md を作成 → Codex CLI が実装」フロー

### コスト構造（月額$40）
- Claude Code: 約62%
- Codex CLI: 約28%
- CI環境: 約10%

### キーメッセージ
「Codex for keystrokes, Claude Code for commits」
