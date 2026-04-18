# I Measured Claude 4.7's New Tokenizer. Here's What It Costs You.

**Source:** https://www.claudecodecamp.com/p/i-measured-claude-4-7-s-new-tokenizer-here-s-what-it-costs-you
**Fetched:** 2026-04-18
**Published:** 2026-04-16

## Author
Abhishek Ray

## Key Findings

### Token Efficiency
- Anthropic documented "1.0 to 1.35x as many tokens" but real-world testing revealed **1.47x on technical docs** and **1.45x on production files**
- Different content types: shell scripts (1.39x), TypeScript (1.36x), English prose (1.20x), CJK languages nearly unchanged (1.01x)

### Performance Trade-off
- IFEval benchmark: +5 percentage point increase on strict instruction compliance
- Sample size (N=20) limits confidence

### Financial Impact
- Typical 80-turn Claude Code session: cost increased from ~$6.65 to $7.86–$8.76 (20–30% increase per session)
- Base token price unchanged

### Caching Implications
- Invalidates existing cached prefixes when switching models
- Increases token volume stored/retrieved through prompt caching
