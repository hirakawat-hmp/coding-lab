# プロンプトの再現性をAIに自動チューニングさせる方法 (Raw)

Source: https://zenn.dev/mizchi/articles/empirical-prompt-tuning
Author: mizchi
Fetched: 2026-04-20

## Core Method
Have a separate AI evaluate and iterate on prompts in a controlled loop, eliminating author bias. Dispatch prompts to independent AI agents via Claude Code's Task tool for objective assessment.

## Process
1. **Dual evaluation**: Separate AI instances report unclear points, compensated assumptions, and requirement fulfillment against predefined checklists
2. **Structured iteration**: Fixed scenarios (median + edge cases) remain constant; modifications target one issue per cycle
3. **Fresh evaluation each cycle**: Never reuse the same AI instance to avoid learning bias
4. **Hold-out testing**: Reserve scenarios to detect overfitting

## Key Insights
- Writers unconsciously fill gaps when reviewing their own work → structural problem requiring external judgment
- Track `tool_uses`, execution time, and checklist completion mechanically
- Stop after two consecutive cycles showing <3pt improvement and <15% duration variance

## Meta-application
The article itself underwent seven iterations, climbing from 6/20 to 16/20 reproducibility score.
