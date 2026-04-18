---
type: insight
status: []
tags:
  - security/web
sources:
  - "https://blog.calif.io/p/mad-bugs-even-cat-readmetxt-is-not"
created: 2026-04-18
updated: 2026-04-18
---

# iTerm2 SSH Integration RCE — "cat readme.txt" でコード実行

2026年3月30日報告・3月31日パッチ済みの iTerm2 の任意コード実行（RCE）脆弱性。
`cat readme.txt` を実行するだけで攻撃者コードが実行される可能性を実証した事例。

## 脆弱性の概要

**根本原因:** iTerm2 が信頼できる conductor セッション以外のターミナル出力も
conductor プロトコルとして受け付けてしまう。

### iTerm2 SSH Integration の仕組み

```
SSH 接続確立
  → conductor スクリプトを bootstrap
  → DCS 2000p / OSC 135 エスケープシーケンスで通信
  → シェル発見・ファイル転送・コマンド実行を管理
```

### 攻撃手順

```
1. 攻撃者が readme.txt に偽エスケープシーケンス埋め込み
   └── 偽 conductor セッション開始を宣言

2. iTerm2 が自動リクエストを送信
   └── readme.txt が「conductor からの正規返答」を偽造

3. base64 エンコードペイロードを注入
   └── シェルが base64 コマンドを入力として解釈

4. 最終チャンクが実行ファイルパスに解決
   └── 攻撃者コントロールの実行ファイルが起動
```

## 影響条件

- 攻撃者コントロールの実行ファイルがあるディレクトリで `cat` を実行
- PTY（疑似端末）の混乱を利用

## タイムライン

| 日付 | イベント |
|------|---------|
| 2026-03-30 | OpenAI と共同研究チームが報告 |
| 2026-03-31 | パッチリリース（commit a9e745993c2e2cbb30b884a16617cd5495899f86）|

## 教訓

「安全に見えるコマンドでも、ターミナルエミュレータの拡張機能が攻撃面を広げる」

信頼できないディレクトリでの `cat` / `less` 等の閲覧コマンドも、
SSH Integration のようなリッチ機能を持つ環境では RCE の入口になりうる。

## 関連ページ

- [[wiki/n-day-bench]] — LLM を使った脆弱性発見ベンチマーク
- [[wiki/nist-cve-enrichment-end]] — CVE エコシステムの変化
- [[wiki/claude-code-security-incidents]] — AI ツール利用時の実際のセキュリティ事故
