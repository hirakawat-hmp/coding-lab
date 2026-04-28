# GitHub Copilot 利用量ベース課金への移行

Source: GitHub Blog https://github.blog/news-insights/company-news/github-copilot-is-moving-to-usage-based-billing/
Source: ITmedia https://www.itmedia.co.jp/aiplus/articles/2604/28/news051.html
Fetched: 2026-04-28

## 変更内容と実施時期

GitHub Copilotは定額制（Premium Request Units / PRU）から **GitHub AI Credits を使った利用量ベース課金**へ移行する。有効日：**2026年6月1日**。

トークン消費量（入力・出力・キャッシュ）に基づいて計算され、各モデルの公開 API レートに合わせた価格設定。

## 価格設定の詳細

**個人向け：**
- Copilot Pro: 月額 $10（$10 相当のクレジット込み）
- Copilot Pro+: 月額 $39（$39 相当のクレジット込み）

**法人向け：**
- Copilot Business: 月額 $19/ユーザー（$19 相当のクレジット込み）
- Copilot Enterprise: 月額 $39/ユーザー（$39 相当のクレジット込み）

## 変わらないもの

コード補完（Code completions）と Next Edit Suggestions は引き続きすべてのプランでクレジット消費なしで利用可能。

「Fallback experiences は廃止」——利用可能なクレジットがなくなると低コストモデルへの自動切り替えは行われない。

## ユーザーへの影響

- 月次サブスクライバー：6月1日に自動移行
- 年間プラン：更新時に移行
- 法人・エンタープライズ：8月まで促進的な含有利用あり、チーム横断のクレジットプール管理とバジェット管理が新設

この変更は Copilot がエージェント型プラットフォームへ進化し、計算需要が大幅に増加したことを反映している。
