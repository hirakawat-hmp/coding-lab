# なぜ Rust なのか — 企業視点からの採用理由

Source: https://voluntas.ghost.io/why-rust/
Retrieved: 2026-05-07
Author: Voluntas

## Rust 採用の主な理由（C++ からの移行）

1. **社内エキスパートの存在**: Rust 歴10年以上の社員がいる。分散システムを構築できるエキスパートがいると、指導が得やすい。

2. **ビルドシステムへの疲れ**: C++ のビルドツールを Python で書き続けることへの疲弊。Cargo の標準化されたアプローチは魅力的。

3. **LLM によるサポート**: Rust のコンパイラの複雑さについての懸念とは反対に、LLM がコンパイルの課題を効果的に解決してくれる。

## 技術的に優れている点

- build.rs によるビルドカスタマイズ
- fmt と clippy によるコード品質
- Tokio エコシステム（非同期ランタイム）
- Rustls 統合（TLS サポート）
- proptest と fuzzing によるテスト
- tracing ライブラリによる可観測性

## 欠点

- target ディレクトリの過剰なディスク消費
- 依存関係が急速に肥大化する
- GitHub Actions キャッシュが効きにくい
