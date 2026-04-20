---
type: concept
status: []
tags:
  - infra/hardware
  - security/supply-chain
sources:
  - "https://warontherocks.com/cogs-of-war/the-bromine-chokepoint-how-strife-in-the-middle-east-could-halt-production-of-the-worlds-memory-chips/"
created: 2026-04-20
updated: 2026-04-20
---

# ブロミン・チョークポイント：メモリチップ製造を止める可能性のある地政学リスク

![The Dead Sea bromine extraction facility](https://warontherocks.com/wp-content/uploads/2026/04/The_Dead_Sea_ASTER-1024x576.jpg)

DRAM・NAND フラッシュメモリの製造に不可欠な臭化水素（HBr）ガスの唯一の供給源が、中東紛争で絶たれる可能性がある。

## ブロミンとは

**臭素（Bromine）** は半導体グレードの臭化水素ガスに変換され、メモリチップ製造における**エッチング工程**で使用される原料。

### なぜ代替が効かないか

| エッチャント | ポリシリコン：酸化膜 選択比 |
|-------------|-------------------------|
| 臭化水素（HBr） | **100:1** |
| 塩素（Cl）     | 30:1 |

この精度の差が、先端ノードのトランジスタ構造のエッチングには決定的。塩素では代替不可能。

## 地政学的リスク

### 集中リスク
- **韓国の臭素輸入の 97.5% がイスラエル産**
- イスラエルの ICL グループが死海の単一施設で採掘・変換を行う
- ネゲブ地方では ICL 施設から 35km 圏内に弾道ミサイル攻撃歴がある
- **イスラエル以外に即座に規模拡大できる変換施設は存在しない**

### 需要側の脆弱性
- Samsung + SK hynix：世界 DRAM 市場の約 70%
- SK hynix：HBM（高帯域幅メモリ）市場の約 57%
- DRAM サプライヤーの在庫は **わずか 2〜3 週分**

## 現実的な影響

イスラエルの臭素生産が停止した場合：
- 代替供給源の立ち上げに数ヶ月以上かかる
- DRAM・NAND 価格の急騰（2026 年すでにバングラデシュでスマホ価格が 10-25% 上昇）
- AI インフラに必須の HBM 供給にも影響

イスラエルのイスラエル港の戦争リスク保険料はすでに 0.2% から 0.7-1.0%/航海に上昇している。

## 産業への示唆

半導体供給チェーンの「見えないチョークポイント」は、最終製品（CPU、GPU）や先端プロセスだけでなく、原材料レベルにも潜む。TSMC や Samsung の地政学リスクが議論される一方で、**原料調達リスクは見落とされがち**。

## 関連ページ

- [[wiki/intel-advanced-packaging]] — Intel の半導体パッケージング戦略（サプライチェーン観点）
- [[wiki/bitnet-cpp]] — ローカル推論による HBM 依存度低減の可能性
