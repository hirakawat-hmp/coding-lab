# Investigation Checklist

Quick-reference checklist for conducting a reference codebase investigation.

## Pre-Investigation

- [ ] Read all existing project docs (docs/, README, CLAUDE.md, ADRs)
- [ ] Note what's already documented vs gaps
- [ ] Clarify focus areas with the user (or investigate broadly)
- [ ] Identify the output document location

## Survey

- [ ] Directory tree (2-3 levels)
- [ ] Entry points identified
- [ ] Scale estimated (files, LOC per subsystem)
- [ ] Subsystems classified and named

## Per-Subsystem Deep Dive

- [ ] Key files and their roles listed
- [ ] Data structures / interfaces documented with actual code
- [ ] Processing pipeline mapped (input → output)
- [ ] Integration points with other subsystems noted
- [ ] Code patterns extracted with real examples
- [ ] Edge cases and error handling reviewed

## Analysis

- [ ] Strengths identified (what works well)
- [ ] Limitations cataloged (what's missing or degraded)
- [ ] Tradeoffs explained (why X over Y)
- [ ] Migration notes (reuse vs rebuild vs adapt)

## Output Quality

- [ ] Every claim backed by file path or code snippet
- [ ] No duplication with existing docs
- [ ] Code examples are real, not paraphrased
- [ ] Actionable for someone building on this reference
- [ ] Uncertainties explicitly flagged
