# Raw: GitHub Copilot CLI Remote Sessions

Source: https://zenn.dev/microsoft/articles/github-copilot-cli-remote-session
Fetched: 2026-04-15
Published: April 14, 2026
Version: GitHub Copilot CLI v1.0.25

## Overview

Remote session capability in GitHub Copilot CLI (public preview). Enables monitoring and operating running CLI sessions from GitHub.com or GitHub Mobile.

## Key Functionality

- Streams local session output to GitHub in real-time
- Session continues executing on local machine
- User-specific access (no cross-user sharing)
- Works within GitHub-hosted repositories only

## Activation Methods

1. `/remote` command during active session
2. `copilot --remote` at startup
3. `"remoteSessions": true` in `~/.copilot/config.json`

## Remote Capabilities

From remote interface:
- Approve/deny permission requests
- Answer follow-up questions
- Approve/reject operational plans
- Submit new prompts
- Switch between Interactive/Plan/Autopilot modes
- Cancel tasks

## Limitations

- 60MB output size limit per session
- Slash commands unavailable in remote UI
- Requires GitHub Business/Enterprise admin enablement for orgs

Zenn: https://zenn.dev/microsoft/articles/github-copilot-cli-remote-session
