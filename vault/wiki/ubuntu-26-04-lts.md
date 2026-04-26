---
type: entity
status: []
tags:
  - infra/docker
  - infra/hardware
  - ai/llm
  - security/web
sources:
  - "https://canonical.com/blog/canonical-releases-ubuntu-26-04-lts-resolute-raccoon"
created: 2026-04-26
updated: 2026-04-26
---

# Ubuntu 26.04 LTS Resolute Raccoon

![Ubuntu 26.04 LTS](https://assets.ubuntu.com/v1/1ccf5d21-resolute_raccoon_wallpaper_color_1920x1080.png)

Canonicalが2026年4月23日にリリースした Ubuntu の最新LTS（Long Term Support）バージョン。コードネーム「Resolute Raccoon」。Linux 7.0カーネルを搭載し、AI/ML対応・Rust化・完全Wayland移行が大きな特徴。

## 主要な新機能

### セキュリティとメモリ安全性
- **TPMチップ統合**による全ディスク暗号化機能の正式リリース
- **Rust**採用によるシステム部分のメモリ安全性向上（カーネルドライバ、sudo-rs、uutils coreutils）

### AI/ML対応（重要な変化）
- **NVIDIA CUDAネイティブサポート** — 初めてUbuntuリポジトリに含有
- **AMD ROCmソフトウェアプラットフォーム**をリポジトリで提供

### デスクトップ環境
- GNOME最新版統合
- **Waylandへの完全移行**（X.orgから完全脱却）

### ハードウェア対応
- **Linux 7.0** カーネル搭載
- Intel Core Ultra Series 3（Panther Lake）対応
- **Arm64サーバー向け**Canonical Livepatch初実装
- **RISC-V RVA23標準**フルサポート

### エンタープライズ
- Landscapeをデスクトップインストーラに統合
- Authd（クラウド認証サービス）
- WSLでcloud-init及びUbuntu Pro統合

### インダストリアル
- **IgH EtherCATマスタードライバ**をカーネル統合（マイクロ秒単位の精度 — 産業用途）

## 重要なポイント

CUDAがUbuntuのリポジトリに直接収録されたことは、AI/ML開発環境のセットアップを大幅に簡略化する。これまでNVIDIAの独自リポジトリから個別インストールが必要だったものが、`apt install cuda` で完結する。

## 関連ページ

- [[wiki/meta-aws-graviton5]] — AI推論インフラの変化（Arm系CPU台頭）
