# ハードウェアバディでClaudeとおともだち

Source: https://qiita.com/moritalous/items/cd53aec76db1dec20862
Retrieved: 2026-05-06

## Summary

Claude DesktopのHardware Buddy機能を使って物理デバイス（M5Stack Core2 For AWS）とClaudeをBLE通信で接続した実装記録。

## Hardware Buddy機能

Claude DesktopのIoT機能で、物理デバイスをAIインターフェースに接続できる。

## 技術実装

- 元はM5 StickC Plus向けだがCore2 For AWSにMicroPythonでポート
- esptoolを使ったMicroPythonファームウェア取得
- mpremoteでPythonスクリプト転送
- BLE通信（暗号化・非暗号化両モード対応）

## 課題

- Windowsでデバイスリセット後もペアリング情報が残留 → Bluetoothペアリングデータの手動削除が必要
- 「ハードウェアが絡むと手作業がまだ必要」 — IoT開発のAI化の限界

## 余談

ClaudeのASCIIアートマスコットの再現に苦労し、最終的にExcelグリッドセルで対応（日本のITあるある）。

## Tags

AWS, Bluetooth, M5Stack, Claude
