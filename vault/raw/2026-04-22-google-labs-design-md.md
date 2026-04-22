# Google Labs design.md — Raw

source: https://github.com/google-labs-code/design.md
fetched: 2026-04-22

## Summary

DESIGN.md is an open-source format from Google Labs that combines machine-readable design tokens (YAML) with human-readable design rationale (Markdown) to help coding agents understand and implement design systems.

## Key Facts

- Hybrid format: YAML front matter (tokens) + Markdown prose (rationale)
- CLI tools: lint (validation), diff (version comparison), export (format conversion), spec (specification output)
- Seven linting rules: broken references, contrast ratios, orphaned tokens, section ordering
- Component definitions: backgroundColor, textColor, padding, rounded corners
- Interoperable with W3C Design Token Format (DTCG) standards
- Export targets: Tailwind, DTCG
- Status: alpha, TypeScript 94.2%
- Stats: 627 stars, 42 forks, 5 contributors
- Release: 0.1.0, April 21, 2026
