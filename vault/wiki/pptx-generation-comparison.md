---
tags:
  - comparison
sources:
  - "[[raw/2026-04-06-claude-pptx-skill]]"
  - "[[raw/2026-04-06-presenton]]"
  - "[[raw/2026-04-06-pptagent]]"
  - "[[raw/2026-04-06-marp-claude-workflow]]"
  - "[[raw/2026-04-06-ai-pptx-landscape]]"
created: 2026-04-06
updated: 2026-04-06
---

# AI PPTX 生成アプローチ比較

AI エージェントが PPTX を生成する主要アプローチを、精度・柔軟性・実装コスト・Claude Code との相性の4軸で比較する。

## 総合比較

| アプローチ | 精度 | 柔軟性 | 実装コスト | Claude Code 相性 | PPTX 編集性 |
|-----------|------|--------|-----------|-----------------|------------|
| [[wiki/pptxgenjs]] (JS API) | A | A | B | S | A |
| XML 直接編集 | S | B | A | S | S |
| [[wiki/marp]] (Markdown) | B | C | S | A | D |
| [[wiki/python-pptx]] (Python API) | A | A | B | B | A |
| HTML/React → PPTX | B | A | C | C | B |
| [[wiki/presenton]] (統合 OSS) | A | B | A | B | A |
| [[wiki/pptagent]] (エージェント) | A | A | B | C | A |
| Gamma API (SaaS) | A | C | S | D | B |

**凡例**: S=最高, A=高, B=中, C=低, D=最低

## 軸別詳細

### 精度（出力品質の高さ）

**S 評価: XML 直接編集**
元テンプレートのデザインを完全に保持。フォント、色、配置が1ピクセルも狂わない。ただし、テンプレートの品質に依存する。

**A 評価: PptxGenJS, python-pptx, presenton, PPTAgent, Gamma**
ネイティブ OOXML を生成するため、PowerPoint で完全に編集可能。チャート・テーブルもネイティブ。ただし、レイアウトの美しさは LLM のコード生成能力と skill のガイドラインに依存。

**B 評価: Marp, HTML → PPTX**
Marp は Chromium レンダリング経由のため、フォントの微妙なずれやレイアウト崩れが起こりうる。HTML → PPTX は CSS → OOXML の変換精度に限界がある。

### 柔軟性（表現できるデザインの幅）

**A 評価: PptxGenJS, python-pptx, HTML/React, PPTAgent**
API でスライド上の任意の位置に任意の要素を配置可能。チャート、画像、シェイプ、テキストを自由に組み合わせられる。

**B 評価: XML 直接編集, presenton**
XML 編集はテンプレートの範囲内に制約される。presenton は HTML/Tailwind テンプレートの範囲内。

**C 評価: Marp, Gamma**
Marp は基本的に Markdown の構造に縛られる。Gamma は SaaS のテンプレートシステムに制約される。

### 実装コスト（セットアップの容易さ）

**S 評価: Marp, Gamma, XML 直接編集**
Marp は `npm install -g @marp-team/marp-cli` のみ。Gamma は API キーだけ。XML 編集は Python スクリプト数本。

**A 評価: presenton**
Docker ワンコマンドデプロイ。API キー設定のみで動作。

**B 評価: PptxGenJS, python-pptx, PPTAgent**
ライブラリ自体は軽量だが、LLM が生成するコードの品質を安定させるために skill / プロンプト設計が必要。

**C 評価: HTML/React → PPTX**
dom-to-pptx 等のライブラリに加え、レンダリング環境（ブラウザ / Puppeteer）が必要。変換精度のチューニングにも工数がかかる。

### Claude Code との相性

**S 評価: PptxGenJS, XML 直接編集**
公式 pptx skill として最適化済み。PptxGenJS はデザインガイドライン・QA プロセス・落とし穴リストが skill に内蔵されている。XML 編集は Edit ツールでの直接操作、サブエージェントでの並列編集に最適化。

**A 評価: Marp**
LLM は Markdown を生成するだけで済む。CLAUDE.md テンプレートや MCP サーバーのエコシステムが充実。ただし PPTX の編集性が犠牲。

**B 評価: python-pptx, presenton**
python-pptx は Bash で Python を実行する間接的な統合。presenton は MCP サーバー経由だが、外部サービス依存が増える。

**C 評価: HTML/React, PPTAgent**
HTML/React はレンダリング環境のセットアップが複雑。PPTAgent は独自のサンドボックス環境を持ち、Claude Code との直接統合が難しい。

**D 評価: Gamma**
外部 SaaS API への依存。ネットワーク接続必須、レート制限あり、コスト発生。

## ユースケース別推奨

### 企業プレゼン（ブランドテンプレートあり）
**推奨**: XML 直接編集 > python-pptx テンプレート操作
テンプレートのデザインを100%保持しつつコンテンツを差し替える。CI/CD パイプラインに組み込む場合は python-pptx。

### ゼロからの高品質プレゼン作成
**推奨**: PptxGenJS（Claude Code）> presenton
Claude Code のインタラクティブな反復改善ループ（生成→QA→修正）が活きる。presenton は Web UI で非技術者にも使いやすい。

### データ分析レポート
**推奨**: python-pptx > PptxGenJS
pandas / matplotlib との直接連携。データ処理と同じ Python 環境でスライド生成まで完結。

### 社内勉強会・技術発表
**推奨**: Marp > PptxGenJS
スピード重視。Markdown でコンテンツに集中し、CSS テーマでデザインを一括適用。Git で差分管理。

### 大量スライドの自動生成（バッチ処理）
**推奨**: presenton API > PPTAgent > python-pptx
presenton は Docker + API で並列処理が容易。PPTAgent は Deep Research で調査から生成まで自動化。

### Web アプリ組み込み
**推奨**: react-pptx > dom-to-pptx > PptxGenJS
React コンポーネントとしてスライドを宣言的に記述。dom-to-pptx は既存の Web ページをそのまま PPTX 化。

## 組み合わせパターン

実運用では複数のアプローチを組み合わせることが多い:

1. **Marp で構成確認 → PptxGenJS で本番生成**: Marp でアウトラインとコンテンツ配置を高速にプロトタイピングし、最終版は PptxGenJS で高品質に仕上げる
2. **python-pptx で解析 → PptxGenJS で再生成**: [[wiki/pptx-analysis-pipeline]] でリファレンス PPTX を解析し、その構造を参考に PptxGenJS で新規生成
3. **presenton API + カスタム後処理**: presenton で大枠を生成し、python-pptx でデータ部分を精密に調整

## 関連ページ

- [[wiki/ai-pptx-generation-overview]] — PPTX 生成の全体像
- [[wiki/pptxgenjs]] — PptxGenJS
- [[wiki/presenton]] — presenton
- [[wiki/python-pptx]] — python-pptx
- [[wiki/marp]] — Marp
- [[wiki/pptagent]] — PPTAgent
- [[wiki/pptx-analysis-pipeline]] — PPTX 解析パイプライン（逆方向）
