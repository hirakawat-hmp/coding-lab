# AIにコーディングを全任せした結果、ドメイン設計に辿り着いた話 — Raw Source

Source: https://zenn.dev/tan_go238/articles/002437e923913c
Author: tan_go238
Fetched: 2026-04-21
Published: April 20, 2026

## Journey

Phase 1: Combined AI tools (kiro, spec-kit, Team Kit, office-hours, build-score) → requirements to implementation pipeline. "Development could be nearly completed by AI."

Phase 2: Problems in multi-service monorepo:
- Purchase/Transaction concept naming inconsistencies
- Shared logic reimplemented separately
- Fixes in one area broke others

Root Problem: "AI cannot maintain consistent design without decision criteria provided."

## Solution: Domain Design + AI Collaboration

| Layer | Responsibility | Tests |
|-------|---------------|-------|
| Domain | Human-led; AI assists with careful design | Property-based |
| Application | AI collaborates; human validates | Mutation testing |
| Infrastructure/Presentation | Full AI automation | Unit/E2E |

## Key Insight

"Future value lies not in writing code, but in defining what to build and why — engineers must move toward designing meaning, not just code."
