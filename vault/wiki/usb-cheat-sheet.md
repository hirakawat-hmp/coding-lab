---
type: reference
status: [verified]
tags:
  - infra/hardware
sources:
  - "https://fabiensanglard.net/usbcheat/index.html"
created: 2026-04-26
updated: 2026-04-26
---

# USB規格チートシート

Fabien Sanglardが公開したUSB規格の完全リファレンス。HN フロントページに掲載（2026年4月25日）。USB 1.0（1996年）からUSB4（2019年）までをカバー。

## USB規格と速度

| 規格 | マーケティング名 | 速度 | ケーブル線数 |
|------|--------------|------|-----------|
| USB 1.1 | Full Speed | 12 Mbps | 4 |
| USB 2.0 | Hi-Speed | 480 Mbps | 4 |
| USB 3.0 / 3.1 Gen1 / 3.2 Gen1 | SuperSpeed 5Gbps | 5,000 Mbps | 8 |
| USB 3.1 Gen2 / 3.2 Gen2 | SuperSpeed+ 10Gbps | 10,000 Mbps | 8 |
| USB 3.2 Gen 2×2 | SuperSpeed+ 20Gbps | 20,000 Mbps | 12 |
| USB4 Gen 3×2 | USB4 40Gbps | 40,000 Mbps | 12 |

## コネクタ別の線数

| コネクタ | 対応最大速度 | 線数 |
|--------|-----------|------|
| Type-A | USB 3.2 Gen 2 (10Gbps) | 8 |
| Type-B | USB 3.2 Gen 2 (10Gbps) | 8 |
| Type-C | USB4 (40Gbps) | 12 |

Type-C の追加ピン：CC1/CC2（方向検出・PD交渉）、SBU1/SBU2（DisplayPort Altモード等）

## USB Power Delivery（充電）

| 規格 | 最大電圧 | 最大電流 | 最大電力 |
|------|---------|---------|---------|
| USB PD 3.0 | 20V | 5A | 100W |
| USB PD 3.1 EPR | 48V | 5A | **240W** |

## よくある混乱ポイント

- **USB 3.0 / 3.1 Gen1 / 3.2 Gen1** はすべて同じ 5Gbps
- **コネクタの色**（青=USB 3.0以上）は非標準
- **USB4 = Thunderbolt 3互換**（ただし40Gbpsはオプション）

## 仕様書リンク

USB 1.0（1996）〜 USB4（2019）の公式仕様書へのリンクを掲載。
