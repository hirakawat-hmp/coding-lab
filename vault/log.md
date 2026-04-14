# Log

## [2026-04-14] digest | 2026-04-14 daily digest (run 2)
- RSS フィード 7 本を巡回（Hacker News, Publickey, Zenn, Qiita, はてブ, ITmedia AI+, OpenAI News）
- 直近24時間の新着記事から7件を選別（既存ニュースレターへ追記、計20トピック）
- `vault/tags.md` に新規タグ追加: `dev/javascript`
- 新規 raw ファイル 7 件を保存（`vault/raw/2026-04-14-*.md`）
- 新規 wiki ページ 7 件を作成:
  - `vault/wiki/axios-cve-2026.md` — axios CVSS 10.0 脆弱性と信頼性論争（insight）
  - `vault/wiki/microsoft-foundry-local.md` — Microsoft Foundry Local ローカル AI ランタイム（entity）
  - `vault/wiki/bun-headless-browser.md` — Bun v1.3.12 ヘッドレスブラウザ自動化（entity）
  - `vault/wiki/skill-md-pattern.md` — SKILL.md パターン・折りたたみ式マニュアル（concept）
  - `vault/wiki/rust-for-cpython.md` — Python 3.16 への Rust 統合計画（concept）
  - `vault/wiki/claude-code-harness-patterns.md` — ハーネスパターン10選（insight）
  - `vault/wiki/claude-mythos.md` — Claude Mythos セキュリティ特化モデル（entity）
- `vault/newsletters/2026-04-14.md` にトピック14-20を追記（合計20トピック）
- `vault/index.md` を更新（Entity 31、Concept 22、Insight 10）

## [2026-04-14] digest | 2026-04-14 daily digest
- RSS フィード 6 本を巡回（Hacker News, Publickey, Zenn Trending, Anthropic Blog※, OpenAI Blog, Google Cloud Blog※）
  ※ Anthropic Blog は 404、Google Cloud Blog はエラーのため取得不可
- 直近 24 時間以内の記事 13 件を選別（max_total_articles: 20）
- `vault/tags.md` に新規タグを追加：
  - `infra/cloudflare`、`infra/sre`、`security/web`、`security/supply-chain`
- 新規 raw ファイル 13 件を保存（`vault/raw/2026-04-14-*.md`）
- 新規 wiki ページ 13 件を作成:
  - `vault/wiki/ai-math-revolution.md` — AlphaEvolve・LLM による数学研究の革命（concept）
  - `vault/wiki/n-day-bench.md` — LLM N-Day 脆弱性発見ベンチマーク（entity）
  - `vault/wiki/gaia-local-ai-agent.md` — AMD のローカル AI エージェントフレームワーク（entity）
  - `vault/wiki/github-stacked-prs.md` — GitHub Stacked PRs ツール（entity）
  - `vault/wiki/wordpress-plugin-supply-chain-attack.md` — WP プラグイン一斉バックドア事件（insight）
  - `vault/wiki/cloudflare-cf-cli.md` — Cloudflare 統合 CLI「cf」と Local Explorer（entity）
  - `vault/wiki/lean-formal-verification-limits.md` — Lean 形式検証の限界（insight）
  - `vault/wiki/snapstate.md` — AI エージェント永続状態管理（entity）
  - `vault/wiki/aws-service-retirement-2026.md` — AWS サービス終了計画（reference）
  - `vault/wiki/aws-frontier-agents.md` — AWS DevOps/Security Agent GA（entity）
  - `vault/wiki/platform-engineering.md` — Platform Engineering 概念（concept）
  - `vault/wiki/ingress-nginx-to-gateway-api.md` — Ingress NGINX → Gateway API 移行（how-to）
  - `vault/wiki/claude-code-job-queue.md` — Claude Code マルチセッション ジョブキュー（concept）
- `vault/newsletters/2026-04-14.md` を作成（13 トピック集約）
- `vault/index.md` を更新（Entity 28、Concept 20、How-to 4、Reference 4、Insight 8）

## [2026-04-14] ingest | OfficeCLI — AI エージェント向け Office 操作 CLI
- Obsidian Clippings から OfficeCLI の GitHub README を取り込み
- GitHub SKILL.md およびリリースノートから技術詳細を追加調査
- 新規 wiki ページ 2 件を作成:
  - `vault/wiki/officecli.md` — OfficeCLI entity ページ（3層アーキテクチャ、コマンド体系、AI 連携、対応機能詳細）
  - `vault/wiki/aionui.md` — AionUi entity ページ（OfficeCLI ベースの GUI デスクトップアプリ）
- `vault/tags.md` に `tool/officecli` タグを追加
- `vault/raw/2026-04-14-officecli.md` に元ソースを保存
- `vault/index.md` を更新

## [2026-04-10] research | fujito 記事3本から技術要素ごとの解説 Wiki を作成
- Issue #4 のリクエストに基づき、fujito 著の生成 AI ニュース記事 3 本を分析
- 対象記事:
  - [2026-04-06] https://note.com/toshia_fuji/n/n558e3d946c4d
  - [2026-04-07] https://note.com/toshia_fuji/n/n8f414f44b57f
  - [2026-04-08] https://note.com/toshia_fuji/n/n27e5d7e57b4b
- `vault/tags.md` に新規ドメインタグを追加:
  - `ai/video-gen`, `ai/audio-gen`, `ai/image-gen`, `ai/computer-vision`, `media/3d`
- 新規 wiki ページ 11 件を作成（技術要素ごとの深掘り解説）:
  - `vault/wiki/bitnet-cpp.md` — Microsoft 1.58-bit 量子化 LLM 推論エンジン
  - `vault/wiki/meshtailor.md` — グラフ Transformer による 3D UV シーム自動生成
  - `vault/wiki/ace-step.md` — ACE Studio/StepFun の音楽生成基盤モデル
  - `vault/wiki/token-warping.md` — ViT トークンを使った MLLM 視点変換推論テクニック
  - `vault/wiki/triattention.md` — プリ-RoPE 三角関数による KV キャッシュ圧縮
  - `vault/wiki/sam3-1.md` — Meta SAM 3.1（7× スループット向上）
  - `vault/wiki/freemocap.md` — オープンソース・マーカーレスモーションキャプチャ
  - `vault/wiki/seedance-2.md` — ByteDance の 4 モダリティ動画生成モデル
  - `vault/wiki/happyhorse-1.md` — 匿名動画生成モデル（詐欺サイト注意）
  - `vault/wiki/flux-2.md` — Black Forest Labs の統合画像生成モデル
  - `vault/wiki/agentic-mme.md` — マルチモーダル AI エージェントのプロセス検証ベンチマーク
- `vault/newsletters/2026-04-10.md` に記事リンクと技術 Wiki 一覧を追記
- `vault/index.md` を Entity 22 件・Concept 17 件に更新

## [2026-04-10] migrate | 既存 vault (~/repos/vault) から 36 wiki + 12 raw を移行
- `vault/tags.md` 拡張:
  - tool/ に 7 タグ追加（pptxgenjs, python-pptx, marp, presenton, pptagent, rtk, google-stitch）
  - framework/ セクション新設（mastra, adk）
  - stats/ セクション新設（bayesian, mmm, optimization）
  - design/ セクション新設（system）
  - ui/ セクション新設（components, visualization）
  - dev/markdown 追加
  - project/aaip を project/aaas-ai-planner にリネーム
- 既存 vault から移行:
  - raw/ 12 ファイルを丸ごとコピー（immutable）
  - wiki/ 36 ページを新スキーマ（type/status/tags）で frontmatter 書き換えつつコピー
  - qmd-search-engine.md は空なので除外
- `vault/index.md` を全 41 ページで再構成（type 別分類）
- `scripts/vault-cli.py` の lint 改善:
  - Rich マークアップのエスケープ（`[` を `\[` に）
  - Obsidian エイリアスリンク `[[wiki/foo|表示名]]` に対応
  - orphan 検出で index.md も incoming link の対象に含める
- lint 結果: broken 0, orphans 0, unindexed 0, schema 0, unknown tags 0

## [2026-04-10] update | CLI を Python(uv) に移行、Projects/archived を tag library に追加
- `scripts/vault-cli.py` 新規作成（uv シバンスクリプト）:
  - サブコマンド: `list`, `tags`, `lint`, `show`
  - フィルタ文法: フィールド間 AND、同フィールド内カンマ OR、`-` プレフィックスで除外
  - PyYAML で frontmatter を正確にパース、Rich で整形出力
- `scripts/vault-list.sh` と `scripts/lint-check.sh` を削除（vault-cli.py に統合）
- `skills/vault-list`, `skills/vault-tags`, `skills/vault-lint` の SKILL.md を vault-cli.py 呼び出しに書き換え
- `vault/tags.md` 更新:
  - `archived` status を追加（全 type で使用可能、デフォルト検索から除外）
  - Projects セクションを新設（期間・ステータス列付き）
  - `project/knowledge-vault`, `project/aaip` を初期登録

## [2026-04-10] update | Frontmatter スキーマ刷新と agentic search 基盤整備
- `vault/tags.md` を新規作成: type / status / ドメインタグの tag library
- Frontmatter スキーマを刷新:
  - `type` フィールドを新設（entity, concept, how-to, reference, insight, comparison, decision, troubleshooting, idea, meta）
  - `status` を string[] に変更（Lifecycle / Quality / Freshness の3カテゴリ）
  - `tags` をドメインタグ（階層構造、slash 区切り）に統一
- 既存5ページの frontmatter を新スキーマに移行
- `CLAUDE.md` 更新: 新スキーマ、tag library 参照ルール、agentic search の手順を追記
- `scripts/lint-check.sh` 刷新: type/status/tags の整合性チェック、未登録タグ検出を追加（macOS/Linux 両対応）
- `scripts/vault-list.sh` 新規: type/tag/status でのフィルタリング
- Plugin に新スキル追加:
  - `/vault-tags` — tag library の表示
  - `/vault-list` — type/tag/status でページ検索

## [2026-04-10] update | 実運用で得た知見を追記
- `vault/wiki/knowledge-vault-lessons.md` を新規作成（insight）:
  - Tag mode での WebSearch/WebFetch 有効化問題
  - auto-merge の git push 認証エラー → API 経由マージで解決
  - Claude bot トラッキングコメントによる無限ループ問題
  - prompt 指定で tag mode の恩恵を失う問題
  - id-token:write 不足による OAuth 認証失敗
- `vault/wiki/claude-code-auto-merge.md` にパターン5（GitHub API 経由の直接マージ）を追記
- 既存4ページの関連ページセクションに lessons ページへのリンクを追加
- action-modes ↔ action-tools 間の相互リンクを補完
- `vault/index.md` の Insights セクションに新ページを追加

## [2026-04-10] research | Claude Code GitHub Actions auto-merge 設計パターン追記
- Issue #3 の追加リクエストに基づき auto-merge パターンを調査
- WebSearch/WebFetch で auto-merge 実装パターン・continuous-claude・無限ループ防止を調査
- `vault/wiki/claude-code-auto-merge.md` 作成: auto-merge 設計パターン詳細（4パターン・gh CLI リファレンス）
- `vault/wiki/claude-code-github-actions.md` 更新: auto-merge セクション追加
- `vault/newsletters/2026-04-10.md` にトピック4を追記
- `vault/index.md` に新規ページを追加

## [2026-04-10] research | Claude Code GitHub Actions 設計パターン調査
- Issue #3 のリクエストに基づき調査実施
- WebSearch/WebFetch で公式ドキュメントと DeepWiki を参照
- `vault/wiki/claude-code-github-actions.md` 作成: GitHub Actions 全体の概要
- `vault/wiki/claude-code-action-modes.md` 作成: Tag Mode と Agent Mode の詳細比較・移行ガイド
- `vault/wiki/claude-code-action-tools.md` 作成: allowedTools 設定と WebSearch/WebFetch 有効化方法
- `vault/newsletters/2026-04-10.md` 作成
- `vault/index.md` の Concepts セクションに3ページを追記

## [2026-04-10] init | Knowledge Vault 初期化
- リポジトリ構成作成
- CLAUDE.md, index.md, log.md, config/feeds.yml を作成
- GitHub Actions ワークフロー設定
