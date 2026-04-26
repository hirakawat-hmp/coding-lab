# Gemini Gem で社内Google Driveチャットボットを作成

**ソース:** https://dev.classmethod.jp/articles/gemini-gem-googledrive-chatbot/
**取得日:** 2026-04-26
**公開日:** 2026-04-25

## 記事内容

Gemini の Gem（システムプロンプト機能）を活用して、社内用Google Driveチャットボットを構築する手法を紹介。

### 課題
社内のGoogle Driveで資料・フォルダが増えると、必要な情報を探すのに時間がかかる。従来のキーワード検索では「記憶しているキーワードと実際のファイル名が一致しない」ケースが発生。

### 解決方法
Gemini の Gem に「正確に回答してください」という指示を与え、特定の共有ドライブURLを指定することで社内用チャットボットを構築。

### 成果
サイドバーのGeminiより正答率が約4倍高くなり、ハルシネーション削減を実現。

### 運用方法
作成したGemを「Gemini Gemsフォルダ」から対象の共有ドライブに移動することで、そのドライブにアクセス権のあるメンバー全員が利用可能に。

### 注意点
システムプロンプト内で共有ドライブURLを指定しても、ユーザーのアクセス権のある別ドライブの情報を参照することがある（2026年4月24日時点）

OGP画像: https://images.ctfassets.net/ct0aopd36mqt/wp-thumbnail-6a331d7c70f1897ca2ef1ad4cbe7c6bf/78c556633ae5115aa065636cc4a1160a/eyecatch_gemini
