---
name: reference-investigation
description: >
  Systematically deep-dive into a reference codebase to document its architecture, patterns,
  implementation details, and gotchas. Use PROACTIVELY when the user asks to "investigate reference
  implementation", "deep dive into codebase", "analyze this project", "study how X works",
  "understand the architecture of", or mentions wanting to understand a reference project before
  building something similar. Also use when the user opens or discusses reference code and wants
  to extract actionable knowledge from it.
user-invocable: true
---

Delegate to the `reference-investigator` agent with the user's target directory and focus areas.

The agent handles the full investigation workflow (orient → survey → deep dive → analyze → document)
and produces a structured markdown document. See the agent definition for details.
