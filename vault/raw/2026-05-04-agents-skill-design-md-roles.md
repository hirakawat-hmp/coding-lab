# AIに渡す指示書の役割分担: AGENTS.md/SKILL.md/DESIGN.mdと仕様駆動開発 (2026-05-04)

Source: https://zenn.dev/genda_jp/articles/f71d3ed7d4d7e8
Published: 2026-05-02

Key points:
- AIエージェント向け指示書が3層に分業されつつある動きを整理
- DESIGN.md: デザインシステム仕様（色・タイポグラフィ・コンポーネント）。Google Labs標準化。CLIで検証可能
- SKILL.md: 再利用可能なタスク単位と手順。Anthropic Claude Skills標準
- AGENTS.md/CLAUDE.md: エージェント全体の前提・ロール・禁止事項。OpenAI等が共同策定
- 検証可能な部分（色コントラスト比・用語）は仕様化でき、文体や文化ニュアンスは自然言語で残す
- 仕様駆動開発（SDD）は一過性の仕様策定プロセス、3層分業は永続的な規範管理
- 両者は競合せず相互参照可能
