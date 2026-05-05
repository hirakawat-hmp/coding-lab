# あなたのClaude CodeのWebFetch、実はWebをちゃんと読んでいない

Source: https://zenn.dev/zhizhiarv/articles/claude-code-webfetch-haiku-summary
Fetched: 2026-05-05

## コア問題

Claude CodeのWebFetchツールは、ユーザーが全文を読んでいると認識していても、実際にはHaikuモデルが要約した内容のみをOpus/Sonnetに返している。

## 条件付きバイパス機構

以下の3条件をすべて満たす場合のみ要約をバイパス可能:
1. `Content-Type: text/markdown` サポート
2. 80以上の信頼ドメイン（AWS、Mozilla、Google Docsなど）に含まれる
3. Markdown長が10万文字以下

## データ切り詰め処理

- HTTPレスポンス上限：10MiB
- HTML→Markdown変換時：先頭1MiB文字で切断
- Haiku処理前：10万文字で再切断

## 透明性の欠如

「Received 204.4KB」と表示されるが、実際に処理されるのは数百文字の要約のみ。

## 著作権制約

Haikuは引用125文字以内制限と歌詞出力禁止をシステムプロンプトで実装。

## 設計理由

コスト削減、セキュリティ（Prompt Injection対策）、著作権保護が背景にあるが、ユーザーへの開示不足が主な課題。
