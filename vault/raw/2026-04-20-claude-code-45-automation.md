# Claude Codeで日常のタスクを45個自動化した東大院生の全記録 (Raw)

Source: https://zenn.dev/shunya_sudo/articles/claude-code-45-automation-tasks
Author: Shunya (東大M2、バイオエンジニアリング)
Fetched: 2026-04-20

OGP Image: https://res.cloudinary.com/zenn/image/fetch/s--Xdr9h6_H--/c_limit%2Cf_auto%2Cfl_progressive%2Cq_auto%2Cw_1200/https://storage.googleapis.com/zenn-user-upload/deployed-images/9421fbd1d3e648c277fbab1e.png

## System Overview
- 45 cron jobs
- 36 custom AI agents
- 132 Python scripts
- Running 24/7 on macOS

## Automated Tasks
1. **Email Processing** - 4-tier classification, auto-draft responses, saves 20-30 min/day
2. **Calendar/Schedule Management** - ICS URLs (not APIs) for stability, meeting slot insertion
3. **Academic Paper Monitoring** - Daily new paper detection with relevance scoring → Slack
4. **Daily/Weekly Reports** - Auto-generates git commit summaries, task completions
5. **AI/Tech News Aggregation** - Three daily runs, summarized
6. **Meeting Transcription** - Folder monitor, auto-summarize audio → Slack
7. **ML Code Development** - Scaffolding, debugging, refactoring assistance
8. **System Self-Monitoring** - Health checks for automation system itself

## Design Principles
- Separate judgment from execution: AI drafts, humans decide
- Stability over sophistication: ICS URLs vs OAuth
- Slack as dashboard: 12 channels
- Start small: 5-minute scripts first

## Cost & Impact
- ~$15,000/month (Claude Code Max subscription)
- Frees 30-60 min/day
