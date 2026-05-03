# Claude Codeにオレたち流のコードを書かせる（前編）(2026-05-03)

Source: https://qiita.com/hiropon122/items/80e76424effeeb5431c2
Published: 2026-05-02

Article by Masato Hirokami from Sonic Garden. Describes an agent skill that automatically extracts project-specific coding conventions from Claude Code projects.

Three operating modes:
- /extract-rules: Initial batch extraction from codebase
- --from-conversation: Captures modifications during pair programming
- --from-pr: Analyzes code review comments across PRs for patterns

Design philosophy: "Extract only what Claude doesn't already know" - distinguish team-specific practices from general best practices.

Output: Rules divided into "Principles" (portable) and "Project-specific patterns" (local conventions). Examples stored separately for token optimization.

Repository: hiroro-work/claude-plugins
