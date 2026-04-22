# n8n BBCニュース自動翻訳・要約→Discord通知 — Raw

source: https://qiita.com/wan-code/items/7138654568f8ef43785b
fetched: 2026-04-22

## Summary

Automated workflow using n8n to fetch BBC News RSS hourly, deduplicate articles, translate/summarize via Google Gemini, and post to Discord.

## Workflow Steps

1. RSS Feed Trigger (1-hour intervals) → BBC News RSS
2. Remove Duplicates node → prevent redundant notifications
3. Gemini AI translation + summarization → Japanese headline + 2-3 bullets
4. Discord notification → formatted message
5. Error handling → single article failure doesn't halt pipeline

## Potential Improvements Mentioned

- Add original article URLs to Discord messages
- Categorize by topic
- Archive to database
- Filter by importance/relevance

Published: April 21, 2026
