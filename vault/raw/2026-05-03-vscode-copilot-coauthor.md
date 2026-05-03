# VS Code Co-Authored-by Copilot Controversy (2026-05-03)

Source: https://github.com/microsoft/vscode/pull/310226

PR #310226 "Enabling ai co author by default" changed git.addAICoAuthor config default from "off" to "all".

Impact: Commits received "Co-authored-by: Copilot" tags even when:
- AI was never used for the commit
- AI features were disabled via "chat.disableAIFeatures": true

Community reaction: 372 downvote reactions. Concerns:
1. Consent & attribution: silently injecting metadata without user knowledge
2. Legal/ethical: co-authorship carries licensing implications
3. Technical bug: schema and runtime fallback were misaligned

Resolution: Contributor acknowledged regression on May 2, 2026; committed to fixing to respect disableAIFeatures settings, prevent false attribution, and improve test coverage.
