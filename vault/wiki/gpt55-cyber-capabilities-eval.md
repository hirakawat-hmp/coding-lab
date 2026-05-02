---
type: insight
status: []
tags:
  - ai/llm
  - ai/eval
  - security/web
sources:
  - "https://www.itmedia.co.jp/aiplus/articles/2605/01/news108.html"
created: 2026-05-02
updated: 2026-05-02
---

# GPT-5.5 と Claude Mythos のサイバー攻撃能力比較評価（英AISI 2026年5月）

![GPT-5.5 vs Claude Mythos](https://image.itmedia.co.jp/aiplus/articles/2605/01/260501tm_ctf.png)

英政府機関の AI Security Institute（AISI）が、OpenAI の GPT-5.5 と Anthropic の Claude Mythos Preview のサイバー攻撃能力を実環境テストで比較評価した。

## 評価結果

### CTF（Capture the Flag）テスト

| モデル | 成功率 |
|--------|--------|
| GPT-5.5 | **71.4%**（Expert レベル） |
| Claude Mythos Preview | 68.6% |

### TLO（The Last Ones）シミュレーション

重要インフラへの攻撃を模した最高難度のシミュレーション：

- **GPT-5.5：** 10月2日に完全破壊達成
- **Claude Mythos：** 10月3日に同様に完全破壊達成
- 差は1日以内で実質的には同等の能力

### Cooling Tower シミュレーション

- 両モデルとも破壊に**失敗**

## AISI の所見

> 「高度なセキュリティ脅威は限定的ではあるが、両モデルの幅広い攻撃能力に懸念がある。AIモデルによるサイバーセキュリティ脅威は、特定分野の限界を超えて包括的なリスクを示唆する。」

## 解釈

1. **「Mythos超え」の意味** — CTF の成功率で GPT-5.5 が 3 ポイント上回ったが、TLO では実質的に同等。「Mythos超え」の見出しは誇張気味
2. **重要インフラへの現実的脅威は限定的** — Cooling Tower シミュレーション失敗が示すとおり、最高難度の攻撃にはまだ届かない
3. **しかし能力の向上は継続的** — CTF 71% はエキスパートレベルであり、数年前の評価から大幅に向上

## 経産省の反応

同評価を受け、日本の経済産業省が電力事業者に緊急点検を要請。新型 AI モデルのサイバー能力向上が重要インフラへの現実的リスクとして認識され始めている。

## 関連ページ

- [[wiki/claude-mythos]] — Anthropic のサイバーセキュリティ特化モデル（AISI 検証）
- [[wiki/gpt-5-5]] — OpenAI GPT-5.5（エージェント的タスク実行強化モデル）
- [[wiki/gpt-5-4-cyber]] — OpenAI GPT-5.4-Cyber（防御的サイバーセキュリティ特化）
- [[wiki/n-day-bench]] — LLM が実世界の N-Day 脆弱性を発見する能力評価ベンチマーク
