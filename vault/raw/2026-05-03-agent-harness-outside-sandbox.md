# The Agent Harness Belongs Outside the Sandbox (2026-05-03)

Source: https://www.mendral.com/blog/agent-harness-belongs-outside-sandbox
Author: Andrea Luzzardi, Mendral

Two architecture models:
1. Loop lives in same container as code it works on (simple, not scalable)
2. Loop on backend infrastructure, calling into sandboxes via API for tool execution (recommended)

Key advantages of backend harnesses:
- Credentials stay outside sandboxes, eliminating permission enforcement needs
- Sandboxes suspend when idle, reducing resource waste
- Sandboxes become replaceable; failures don't terminate sessions
- Multi-user scenarios shift from distributed filesystem to shared databases

Mendral's implementation:
- Durable execution: Inngest for checkpointing across deploys
- Sandbox lifecycle: Blaxel (25ms resume times)
- Filesystem virtualization: routing paths transparently to sandboxes or Postgres

Remaining challenges:
- Diverges from standard Claude Code patterns
- Bash commands can bypass virtualization layers
- Consistency models for concurrent memory updates unsolved
