# TSRX - AI時代のUIコンポーネント (2026-05-03)

Source: https://blog.inorinrinrin.com/entry/2026/05/02/231104
Published: 2026-05-02
OGP: https://ogimage.blog.st-hatena.com/6802418398318546029/17179246901364840044/1773563608

TSRX (TypeScript Render Extensions): TypeScript language extension for declarative UI, consolidating structure, styling, and control flow in unified files.

Targets: React, Preact, Solid, Vue, Ripple.

AI-First Design Philosophy:
- Keeps "related information close together" for LLM compatibility
- Based on Liu et al.'s research: LLMs perform optimally when context clusters proximally
- Compiler handles framework-specific constraints (e.g., React Hooks rules) automatically
- AI-generated code stays valid without manual refactoring

Developer Experience:
- Standard if/for statements directly in templates (not ternary operators)
- Variable declarations adjacent to markup usage
- Gradual adoption alongside existing TypeScript/TSX

Status: Alpha version as of publication.
