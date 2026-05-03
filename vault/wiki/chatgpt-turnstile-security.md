---
type: entity
status: []
tags:
  - security/web
  - ai/llm
sources:
  - "https://gigazine.net/news/20260502-chatgpt-cloudflare/"
created: 2026-05-03
updated: 2026-05-03
---

# ChatGPT Turnstile：ボット検知システムの内部構造

![ChatGPT Turnstile分析](https://i.gzn.jp/img/2026/05/02/chatgpt-cloudflare/00_m.png)

セキュリティ研究者 Buchodi による Cloudflare Turnstile（ChatGPT が使用するボット検知システム）のリバースエンジニアリング報告（2026年5月）。

## アーキテクチャ概要

Turnstile は**3層**でブラウザを検査する：

| 層 | 内容 |
|----|------|
| 1. ブラウザ特性 | WebGL、画面解像度、ハードウェア仕様、フォント計測、DOM操作パターン |
| 2. Cloudflare ネットワーク | IP レピュテーション、ASN 情報、TLS フィンガープリント |
| 3. ChatGPT アプリ状態 | セッション情報、ユーザー行動履歴 |

合計 **約55のプロパティ**を検査。

## 暗号化スキーム

**2段階復号化：**
1. 第1段階：XOR 演算によるトークンベースの復号
2. 第2段階：VM 命令内の浮動小数点値を鍵とする 19KB の暗号化プログラムを復号

377プログラムの分析で一貫した構造を確認。難読化の目的はフィンガープリント詳細の隠蔽とリプレイ攻撃の防止。

## 補助的な検知手法

### Signal Orchestrator
**行動バイオメトリクス**：キーストロークのタイミング、マウス速度・加速度のパターン分析

### Sentinel Challenge（プルーフ・オブ・ワーク）
フィンガープリント + SHA-256 ハッシュ計算の組み合わせ。計算コストを課すことでボットの大量アクセスを抑制。

## 意義

高度なボット検知の実装詳細が公開されることで：
- セキュリティ研究コミュニティでの分析が可能に
- 「Turnstile を使えば安全」という過信への警鐘
- 防御側も同等以上の複雑さが必要

**関連ページ:** [[wiki/gpt55-cyber-capabilities-eval]] — ChatGPTのサイバーセキュリティ能力評価  
**関連ページ:** [[wiki/moneyforward-github-breach-2026]] — セキュリティインシデント事例
