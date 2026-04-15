# Raw: Claude Code Routines Documentation

Source: https://code.claude.com/docs/en/routines
Fetched: 2026-04-15

A routine is a saved Claude Code configuration: a prompt, one or more repositories, and a set of connectors, packaged once and run automatically.

## Trigger Types

- **Scheduled**: recurring cadence (hourly, daily, weekdays, weekly, custom cron)
- **API**: HTTP POST to per-routine endpoint with bearer token
- **GitHub**: pull requests, pushes, issues, workflow runs, etc.

## Key Features

- Runs on Anthropic-managed cloud infrastructure (works when laptop is closed)
- Create at claude.ai/code/routines or via `/schedule` CLI command
- Available on Pro, Max, Team, Enterprise plans with Claude Code on the web enabled
- Access via Web, Desktop app, CLI
- Repositories cloned at run start; Claude creates `claude/`-prefixed branches by default

## GitHub Trigger Events

PRs, reviews, pushes, releases, issues, discussions, check runs, workflow runs, etc.

## API Trigger Example

```bash
curl -X POST https://api.anthropic.com/v1/claude_code/routines/trig_xxx/fire \
  -H "Authorization: Bearer sk-ant-oat01-xxxxx" \
  -H "anthropic-beta: experimental-cc-routine-2026-04-01" \
  -d '{"text": "Alert fired"}'
```

## Usage Limits

- Daily cap on runs per account
- Extra usage (overage) available via billing settings

HN discussion: https://news.ycombinator.com/item?id=47769796 (365 pts, 236 comments)
