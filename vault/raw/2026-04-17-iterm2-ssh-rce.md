# MAD Bugs: "cat readme.txt" も安全ではない — iTerm2 SSH RCE

**Source:** https://blog.calif.io/p/mad-bugs-even-cat-readmetxt-is-not
**Fetched:** 2026-04-18
**Published:** 2026-04-17

## 概要

iTerm2 の SSH Integration 機能を悪用した任意コード実行（RCE）の脆弱性。
`cat readme.txt` を実行するだけで攻撃者コードが実行される可能性を実証。

## 脆弱性の仕組み

### iTerm2 SSH Integration の動作
1. リモートヘルパースクリプト「conductor」をブートストラップ
2. ターミナルエスケープシーケンス（`DCS 2000p`・`OSC 135`）でプロトコルを確立
3. シェル発見・ファイルアップロード・コマンド実行を管理

### 信頼の失敗
「iTerm2 は、実際の信頼できる conductor セッションから来ていないターミナル出力を受け付けてしまう」

悪意ある readme.txt ファイルが偽造エスケープシーケンスで conductor を装い、
最終的にエージェントが選んだパスの実行ファイルを起動させる。

## 詳細フロー

1. readme.txt に偽エスケープシーケンスを埋め込み（偽 conductor セッション開始）
2. iTerm2 の自動リクエストに対して細工された返答を提供
3. base64 エンコードペイロードを注入
4. シェルが base64 コマンドを入力として解釈・実行

## タイムライン

- 報告: 2026年3月30日
- パッチ: 2026年3月31日（commit a9e745993c2e2cbb30b884a16617cd5495899f86）
- 研究パートナー: OpenAI と共同

## 影響範囲

- PTY（疑似端末）の混乱を利用
- 攻撃者コントロールの実行ファイルがあるディレクトリで `cat` を実行した場合
