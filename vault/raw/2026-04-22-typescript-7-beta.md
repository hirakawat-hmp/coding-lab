# TypeScript 7.0 Beta — Raw

source: https://devblogs.microsoft.com/typescript/announcing-typescript-7-0-beta/
fetched: 2026-04-22

## Summary

Microsoft announced TypeScript 7.0 Beta on April 21, 2026. The compiler was rewritten from TypeScript (self-hosted) to Go over the past year. Performance improvement: approximately 10x faster than TypeScript 6.0.

VS Code (1.5M lines): 89s → 8.74s (10.2x)
Sentry project: 133s → 16s

## Key Facts

- Install: `npm install -D @typescript/native-preview@beta`, command: `tsgo`
- New flags: `--checkers` and `--builders` for multi-threaded compilation
- Breaking changes: `target: es5`, `downlevelIteration`, some module resolution options deprecated
- New defaults: `strict: true`, `module: esnext`, `types: []`
- VS Code extension: TypeScript Native Preview available
- Stable release expected within ~2 months
- Tested by Google, Figma, Slack, and others

## Performance by Project Size

- Large projects (1M+ lines): ~10x improvement
- Medium projects (100K lines): 2-5x improvement
- The Go codebase was methodically ported from existing TS implementation, not rewritten from scratch
- Type-checking logic is structurally identical to TypeScript 6.0
