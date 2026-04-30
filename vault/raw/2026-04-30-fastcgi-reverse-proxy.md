# Raw: FastCGI: 30 years old and still the better protocol for reverse proxies

Source: https://www.agwa.name/blog/post/fastcgi_is_the_better_protocol_for_reverse_proxies
Fetched: 2026-04-30
HN Points: 224 | Comments: 52

## Main Arguments

1. HTTP/1.1 はリバースプロキシに根本的な欠陥を持つ（明示的なメッセージフレーミングがない → デシンク攻撃のリスク）
2. FastCGI は30年前から「明確なメッセージ境界」を実装済み
3. HTTP のヘッダーインジェクション脆弱性: `X-Real-IP` 等のヘッダーが信頼できないか不明瞭
4. FastCGI はクライアント制御データと proxy 信頼データを構造的に分離（HTTP プレフィックスで区別不可能な詐称を防止）
5. 主要プロキシ（nginx, Apache, Caddy, HAProxy）が FastCGI をサポート

## 制限

- WebSocket 非対応
- HTTP に比べてツールの最適化が少ない
