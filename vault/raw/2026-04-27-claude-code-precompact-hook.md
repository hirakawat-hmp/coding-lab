# Claude Code PreCompact Hook & Discord 遠隔操作

source: https://qiita.com/nogataka/items/95efda0c7c9ea2405139
fetched: 2026-04-27

## 問題

Claude Code が長時間セッション中にコンテキストウィンドウが逼迫すると auto-compact（自動会話圧縮）が走り、「未解決の論点」や「途中で棚上げした課題」が「解決済み」として扱われて議論の結論がすり替わってしまう。

## 解決策：PreCompact Hook

2026年に追加された PreCompact Hook を使うことで圧縮処理に介入できる。

### exit codes
- exit 0: 標準の自動圧縮を実行
- exit 2: 圧縮を中止
- decision:replace: カスタム要約に置き換え

### 実装例
未解決マーカー（`TODO:`, `未決:` 等）を含む行を保全するbashスクリプトを settings.json に登録。

## 関連機能

- Session Notes: 10K トークンごとに要点を自動保存
- Channels（研究プレビュー）: Discord 等から外部割り込みが可能
- Auto Memory: セッション跨ぎの知識蓄積

## セキュリティ

Channels 経由の指示を受け入れる場合、`permissions.deny` の徹底とプロンプトインジェクション対策が必須。
