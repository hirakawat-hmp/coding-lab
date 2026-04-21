# Claude Code Usage Dashboard OSS — Raw Source

Source: https://qiita.com/tamepicomaru/items/8f9b238ae28e380e6029
Author: Takahiro Tamenishi (@tamepicomaru), AgenticSec Inc.
Fetched: 2026-04-21

## Key Facts

- GitHub: https://github.com/AgenticSec/ClaudeCodeUsageDashboard
- Automatically collects and visualizes team usage patterns for Claude Code
- Tracks: skills, MCP servers, sub-agents usage
- Problem: token costs visible but feature adoption (skills, MCP, agents) invisible
- Uses Claude Code Stop hook + Plugin system
- Parses session transcripts (~/.claude/projects/{hash}/{session_id}.jsonl)
- Zero disruption to developer workflows

## Metrics Tracked

- Skill usage frequency
- MCP server invocation counts
- Sub-agent activity patterns
- Token consumption and cost per user/repository
- Model distribution (Opus/Sonnet/Haiku)

## Impact

Sub-agent usage increased ~1.5x within one week of dashboard visibility (reported in inspiration article)
