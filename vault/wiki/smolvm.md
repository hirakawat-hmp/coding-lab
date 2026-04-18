---
type: entity
status: []
tags:
  - infra/vm
  - dev/rust
  - ai/agent
sources:
  - "https://github.com/smol-machines/smolvm"
created: 2026-04-18
updated: 2026-04-18
---

# smolvm — サブ秒コールドスタートのポータブル仮想マシン

2026年4月17日に v0.5.18 をリリースした Rust 製 CLI ツール。
「デフォルトで隔離されたソフトウェアを出荷・実行する」ことをコンセプトとする。
macOS（Hypervisor.framework）と Linux（KVM）でサブ秒（<200ms）の VM を実現。

## 主な特長

| 特長 | 詳細 |
|------|------|
| コールドスタート | < 200ms |
| メモリ | elastic 8 GiB RAM（virtio balloon） |
| CPU | 4 vCPUs（デフォルト） |
| ネットワーク | **デフォルト無効**、egress allowlist でオプトイン |
| ライセンス | Apache-2.0 |

## 主要機能

### エフェメラル & 永続 VM
```bash
# 一時的なサンドボックス
smolvm run --ephemeral ./script.sh

# 永続開発マシン
smolvm create dev-machine
smolvm ssh dev-machine
```

### Smolfile（宣言的 VM 定義）
```toml
[machine]
name = "my-project"
cpus = 2
memory = "4GiB"

[network]
egress = ["github.com", "npm.npmjs.com"]
```

### ポータブルパッキング
VM を単一の実行ファイルにバンドルしてクロスプラットフォーム配布可能。

### SSH エージェント転送
秘密鍵はホストに残りつつ、VM がホストの SSH 認証情報を利用。

## 技術スタック

- **言語:** Rust（82.4%）
- **VMM:** libkrun + カスタム libkrunfw カーネル
- **macOS:** Hypervisor.framework
- **Linux:** KVM

## AI エージェントとの関係

ネットワークを完全に隔離した VM 内で AI エージェントを実行することで、
MCP ツールや任意コード実行のリスクを最小化できる。

## リポジトリ統計（2026-04-17）

- Stars: 836 / Forks: 33

## 関連ページ

- [[wiki/mcp-security-vulnerability-2026]] — AI エージェントのサンドボックス化の重要性
- [[wiki/openai-agents-sdk-v2]] — OpenAI Agents SDK のサンドボックス機能
- [[wiki/claude-code-harness-patterns]] — ハーネスパターンとサンドボックス
