# DESIGN.md Research Notes (2026-04-07)

## Source
- Repository: https://github.com/VoltAgent/awesome-design-md
- Stars: 23.5k+, Forks: 2.9k+ (as of 2026-04-07)
- License: MIT

## What is DESIGN.md?

A plain-text design system document that AI agents read to generate consistent UI.
Introduced by Google Stitch. Requires no special tooling — just a markdown file placed
in a project root that LLMs can parse naturally.

## 9-Section Structure

1. **Visual Theme & Atmosphere** — mood, density, design philosophy
2. **Color Palette & Roles** — semantic names, hex values, functional purposes
3. **Typography Rules** — font families and complete hierarchy tables
4. **Component Stylings** — buttons, cards, inputs, navigation with various states
5. **Layout Principles** — spacing scales, grid systems, whitespace philosophy
6. **Depth & Elevation** — shadow systems and surface hierarchies
7. **Do's and Don'ts** — design guardrails and anti-patterns
8. **Responsive Behavior** — breakpoints, touch targets, collapsing strategies
9. **Agent Prompt Guide** — quick color references and ready-to-use prompts

## Repository Contents

Each entry includes:
- DESIGN.md file
- preview.html (component catalog)
- preview-dark.html (dark mode variant)

## 58 Included Design Systems

**AI & ML:** Claude, Cohere, ElevenLabs, Minimax, Mistral AI, Ollama, OpenCode AI, Replicate, RunwayML, Together AI, VoltAgent, xAI

**Developer Tools:** Cursor, Expo, Linear, Lovable, Mintlify, PostHog, Raycast, Resend, Sentry, Supabase, Superhuman, Vercel, Warp, Zapier

**Infrastructure & Cloud:** ClickHouse, Composio, HashiCorp, MongoDB, Sanity, Stripe

**Design & Productivity:** Airtable, Cal.com, Clay, Figma, Framer, Intercom, Miro, Notion, Pinterest, Webflow

**Fintech & Crypto:** Coinbase, Kraken, Revolut, Wise

**Enterprise & Consumer:** Airbnb, Apple, IBM, NVIDIA, SpaceX, Spotify, Uber

**Automotive:** BMW, Ferrari, Lamborghini, Renault, Tesla

## Stripe DESIGN.md Example Structure

### Typography Rules
- Custom `sohne-var` variable font with OpenType `"ss01"` stylistic set
- 20+ typographic roles (Display Hero through Nano) with size, weight, line-height, letter-spacing

### Color Palette
- Primary: purple, navy, white
- Brand & Dark: deep indigo
- Accent Colors: ruby, magenta
- Interactive states, Neutral Scale, Surface & Borders, Shadow Colors
- Each color includes hex value and CSS variable name

### Component Stylings
- Button variants (Primary Purple, Ghost, Transparent Info)
- Card treatments, badges, input styling, navigation patterns
- Specific color and padding values

### Layout Principles
- 8px base unit spacing system
- 1080px max width grid
- Border-radius scale (1px-8px)

### Depth & Elevation
- 5-level shadow hierarchy
- "Chromatic depth" approach — primary shadow color echoes brand's navy palette

## Google Stitch

Google Stitch introduced the DESIGN.md concept and format. It is a tool that generates
UI from design system specifications in markdown format. The Stitch DESIGN.md format
has become the de facto standard that the awesome-design-md repository follows.

## Usage with AI Tools

1. Copy a site's DESIGN.md into your project root
2. Tell your AI agent to use it (e.g., "follow DESIGN.md for styling")
3. Works with Claude Code, Cursor, v0, and other AI coding tools
4. Markdown is the format LLMs read best — no special parsing needed

## Notes

- Extracted from publicly visible CSS values
- No ownership claims over original brand identities
- MIT licensed — free to use in any project
