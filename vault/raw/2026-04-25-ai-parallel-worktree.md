# Claude・Codex・Geminiに同じIssueを並列実行 — git worktree × tmux

**ソース:** https://qiita.com/nogataka/items/1156e2d3a40c4dab3398
**取得日:** 2026-04-26
**公開日:** 2026-04-25

## 記事内容

複数のAIエージェントを同時に動かす際の衝突問題を git worktree と tmux で物理的に隔離する手法。`workmux` ツールを活用した実践例。

### 3つのAI比較

| AI | 強み | 実装時間 |
|---|---|---|
| Claude Code | テスト充実度（55%）、リファクタ | 約6分 |
| Codex CLI | 型安全性（55%）、ロジック実装 | 約4分 |
| Gemini CLI | UI実装（50%）、見た目の初期案 | 約5分 |

### キーポイント
- 同一リポジトリでの並列作業は node_modules、ロックファイル、.next/ などで衝突
- git worktree は物理的に独立したディレクトリを提供（Gitオブジェクトは共有）
- 人間が現実的に監視できるのは「2〜3並列が上限」
- 設計方針が割れるUIタスクで並走が有効、機械的な作業では非効率
- 「勝率はモデルの優劣より制約条件との相性で決まる」

### ツール比較
workmux、vibe-kanban、conductor、生worktreeを並列数・セットアップ・可視化の観点で比較
