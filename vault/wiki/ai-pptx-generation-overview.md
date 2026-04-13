---
type: concept
status: []
tags:
  - ai/agent
  - dev/typescript
  - dev/python
  - project/aaas-ai-planner
sources:
  - "[[raw/2026-04-06-claude-pptx-skill]]"
  - "[[raw/2026-04-06-presenton]]"
  - "[[raw/2026-04-06-pptagent]]"
  - "[[raw/2026-04-06-marp-claude-workflow]]"
  - "[[raw/2026-04-06-ai-pptx-landscape]]"
created: 2026-04-06
updated: 2026-04-06
---

# AI エージェントによる PPTX 生成の全体像

AI エージェントがプレゼンテーション（PPTX）を自動生成するアプローチは、大きく5つのカテゴリに分類できる。それぞれ精度・柔軟性・実装コスト・Claude Code との相性が異なる。

## 5つのアプローチ

### 1. JavaScript API 直接生成（PptxGenJS）

LLM が JavaScript コードを生成し、[[wiki/pptxgenjs]] で直接 PPTX を構築する。Claude Code の公式 pptx skill が採用するメイン方式。

**パイプライン**: LLM → JavaScript コード → PptxGenJS API → .pptx

**特徴**:
- ネイティブ PPTX 生成（中間フォーマットなし）
- テキスト、チャート、テーブル、画像、シェイプをすべて API で制御
- react-icons + sharp でアイコンも埋め込み可能
- Slide Master でレイアウトテンプレートを定義

**適用場面**: テンプレートなしでゼロからプレゼンを作る場合

### 2. XML 直接編集（テンプレートベース）

既存の PPTX をアンパックし、XML を直接編集して再パックする。Claude Code pptx skill の editing ワークフロー。

**パイプライン**: テンプレート .pptx → unpack → XML 編集 → clean → pack → .pptx

**特徴**:
- 元のデザイン・レイアウトを完全に保持
- スライドの複製・削除・並べ替えが可能
- XML 操作は Claude Code の Edit ツールと相性が良い
- サブエージェントで並列編集可能（スライドごとに別 XML）

**適用場面**: 企業テンプレートがあり、コンテンツだけ差し替える場合

### 3. Markdown → スライド変換（Marp）

[[wiki/marp]] で Markdown をスライドに変換する。LLM は Markdown を生成するだけで済む。

**パイプライン**: LLM → Marp Markdown → Marp CLI → HTML/PDF/PPTX

**特徴**:
- LLM の負荷が最も軽い（Markdown 生成のみ）
- Git でバージョン管理・差分管理が容易
- CSS テーマでデザインをカスタマイズ
- PPTX 出力は Chromium + LibreOffice 経由のため非ネイティブ（編集性に制約）

**適用場面**: 社内勉強会、技術発表など、編集性よりスピード重視の場合

### 4. Python API 生成（python-pptx）

[[wiki/python-pptx]] でプログラマティックに PPTX を生成。エージェントフレームワーク（PPTAgent 等）の基盤技術。

**パイプライン**: LLM → Python コード → python-pptx → .pptx

**特徴**:
- Python エコシステムとの親和性（pandas, matplotlib 等）
- テンプレートの読み込み・操作に強い
- [[wiki/pptagent]] が V2 でフリーフォーム生成に対応
- 既存の PPTX を解析して構造を学習するアプローチが可能

**適用場面**: データ分析パイプラインの末端でレポート生成する場合

### 5. HTML/React → PPTX 変換

HTML/CSS でスライドをデザインし、PPTX に変換する。dom-to-pptx や react-pptx など。

**パイプライン**: LLM → HTML/React → レンダリング → PPTX 変換

**特徴**:
- Web デザインの自由度をそのまま活用
- CSS（グラデーション、シャドウ、角丸）を PPTX に変換可能
- React コンポーネントとしてスライドを宣言的に記述可能
- 変換精度に限界あり（CSS → OOXML の完全な対応は困難）

**適用場面**: Web アプリに組み込むスライド生成機能

## 統合プラットフォーム

上記の基盤技術を組み合わせた統合プラットフォームも存在する:

- **[[wiki/presenton]]**: Next.js + FastAPI + HTML/Tailwind テンプレート。マルチ LLM・マルチ画像プロバイダ対応の OSS
- **[[wiki/pptagent]]**: リファレンスベースの edit アプローチ + Deep Research。サンドボックス環境で 20 以上のツールを使用
- **Gamma**: API v1.0 GA（2025年11月）。SaaS 型で最も手軽だが、カスタマイズ性に制約
- **SlidesGPT**: API 提供あり。Prompt → Outline → Slides の簡潔なパイプライン

## Claude Code での推奨選択

| 状況 | 推奨アプローチ |
|------|-------------|
| ゼロから高品質プレゼン | PptxGenJS（公式 skill） |
| 企業テンプレートあり | XML 直接編集（公式 skill） |
| 技術発表・社内勉強会 | Marp |
| データ分析レポート | python-pptx |
| Web アプリ組み込み | react-pptx / dom-to-pptx |

## 関連ページ

- [[wiki/pptx-generation-comparison]] — 各アプローチの詳細比較
- [[wiki/pptxgenjs]] — PptxGenJS エンティティ
- [[wiki/presenton]] — presenton エンティティ
- [[wiki/python-pptx]] — python-pptx エンティティ
- [[wiki/marp]] — Marp エンティティ
- [[wiki/pptagent]] — PPTAgent エンティティ
- [[wiki/pptx-analysis-pipeline]] — PPTX 解析（逆方向: PPTX → データ）
