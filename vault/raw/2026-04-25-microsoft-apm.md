# Microsoft APM（Agent Package Manager）

**ソース:** https://zenn.dev/microsoft/articles/agent-package-manager-handson
**取得日:** 2026-04-26
**公開日:** 2026-04-25

## 記事内容

APMは「AIエージェント設定のための package.json」として機能するオープンソースツール（MIT、v0.9.1以上）。Copilot・Claude Code・Cursorなど複数のAIハーネスへの設定配布を一元管理する。

### 主な特徴

**1. 統一的な依存管理**
- `apm.yml`で依存を宣言し、`apm install`で全ハーネスに一括展開
- `apm.lock.yaml`に40桁のコミットハッシュでピン留めし再現性を保証

**2. 開発者の利点**
- 新メンバーのオンボーディングが`apm install`1コマンドで完了
- ルール更新がGitの履歴に乗り、チーム全員へ自動伝搬
- ハーネス追加時も既存ルールがそのまま機能

**3. セキュリティ対策**
- 不可視Unicode文字の自動検出
- `apm-policy.yml`によるローカル・CI両段階での違反ブロック
- 40桁フルSHAによる改ざん防止

### 技術仕様
- オーナー: Microsoft
- ライセンス: MIT（OSS）
- 対応: macOS、Linux、Windows（PowerShell）

OGP画像: https://static.zenn.studio/user-upload/deployed-images/d5099117b6e2005fc1279098.png
