---
type: insight
status: []
tags:
  - tool/claude-code
  - ai/llm
  - infra/hardware
sources:
  - "https://qiita.com/moritalous/items/cd53aec76db1dec20862"
created: 2026-05-06
updated: 2026-05-06
---

# Claude Desktop Hardware Buddy — IoTデバイスとの連携

Claude DesktopのHardware Buddy機能を使い、M5Stack Core2 For AWSをBLE通信でClaudeに接続した実装記録。AIとフィジカルデバイスの連携の現実的な難しさを示す。

## Hardware Buddy機能とは

Claude DesktopのIoT連携機能。物理デバイスをAIインターフェースに接続し、センサーデータ取得や物理的な操作ができる。

## 実装詳細

- **元デバイス:** M5 StickC Plus（オリジナルの対象デバイス）
- **使用デバイス:** M5Stack Core2 For AWS（代替でMicroPythonにポート）
- **通信:** BLE（Bluetooth Low Energy）、暗号化・非暗号化両モード対応

```python
# MicroPythonでBLE通信を実装
# esptool でファームウェア書き込み
# mpremote でスクリプト転送
```

## 遭遇した実際の課題

**Windowsのペアリング情報残留問題:**
デバイスリセット後もWindowsにBluetooth設定が残り、再接続に失敗。Bluetoothペアリングデータの手動削除が必要。

→「ハードウェアが絡むと手作業がまだ必要」という現実。

## 重要な洞察

AIが強力になっても、物理デバイスとの接続には：
- ファームウェアの手動書き込み
- ドライバーの設定
- ペアリング情報の管理

…といった手作業が依然として必要。「AIがすべてを自動化する」は物理世界では限界がある。

## 余談

ClaudeのASCIIアートマスコットを再現しようとして断念、最終的にExcelのグリッドセルで作成（日本のITあるある）。

## 関連ページ

- [[wiki/claude-code-routines]] — Claude Code自動実行Routines
- [[wiki/gemini-robotics-er]] — Gemini Robotics-ER（AI×ロボティクス）
