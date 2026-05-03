# Flue: TypeScript Agent Framework (2026-05-03)

Source: https://flueframework.com/
HN: https://news.ycombinator.com/item?id=... (Sat, 02 May 2026)

Flue is an open-source TypeScript agent harness framework for building autonomous AI agents without third-party SDKs.

Key features:
- Model + harness design: agents can plan, gather context, write files, spawn subagents, adopt roles
- Built-in virtual sandboxes or remote containers (Daytona, Cloudflare Workers)
- Structured workflows: reusable skills with type-safe outputs using Valibot validation
- Security: fine-grained access management; sandboxes never expose credentials
- Multi-deployment: HTTP servers, CLI for CI/CD, or embedded in serverless platforms

Use cases: issue triage, data analysis, coding agents, customer support

Positioning: alternative to off-the-shelf tools (Dune, Grepitile, CodeRabbit), emphasizing complete stack ownership.
