# AG-UI Protocol / StrandsAgents (Raw)

Source: https://qiita.com/Takenoko4594/items/2e9e171d60854d77652f
Fetched: 2026-04-20

## What is AG-UI?
An event-based standard protocol connecting frontends with AI agents. Specifies "which events to flow" rather than transport mechanisms (WebSockets, SSE, etc.).

## Protocol Structure
- 28 event types across 7 categories:
  1. Lifecycle
  2. Text messaging
  3. Tool calls
  4. State management
  5. Activities
  6. Reasoning
  7. Custom functions

## StrandsAgents Implementation (AWS)
Requires adapter to convert streaming format to AG-UI compliance:
ConverseStream API (Bedrock) → StrandsAgents events → AG-UI events

## Key Technical Elements
- Thread management for multi-turn conversations
- Tool synchronization using proxy tools for frontend-defined capabilities
- ToolBehavior configuration for tool execution behavior
- New message IDs for tool results
- Omit role info to prevent duplicate conversation history

## Significance
AG-UI enables a unified standard for AI agent-frontend communication, similar to how HTTP standardized web communication.
