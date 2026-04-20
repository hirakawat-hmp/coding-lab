# Changes in Claude Opus 4.6 and 4.7 System Prompt (Raw)

Source: https://simonwillison.net/2026/Apr/18/opus-system-prompt/
Fetched: 2026-04-20

## Key Changes

### Safety & Behavior
- Child safety instructions now wrapped in critical tags with stricter conversation guidelines
- New disordered eating guidance: prevents specific nutrition/exercise numbers
- Guards against "yes/no" attacks on controversial topics

### Tool Capabilities
- Added Claude in PowerPoint (slides agent) alongside Chrome and Excel agents
- Introduced `tool_search` mechanism to check for available tools before claiming inability
- New mechanism to resolve ambiguities using tools rather than asking users

### User Experience
- Reduced pushiness: respects users' requests to end conversations
- More conciseness emphasis: "keeps responses focused and concise"
- Prefers acting on requests with reasonable assumptions rather than asking clarifying questions

### Removed
- Outdated instruction about avoiding emotes/asterisks
- Specific language clarifying Trump's 2025 presidency (knowledge cutoff updated to January 2026)

## Why It Matters
Changes reflect Anthropic's philosophy of transparency and iterative safety improvements. Evolution toward more autonomous, efficient assistance while maintaining stronger safeguards around vulnerable users.
