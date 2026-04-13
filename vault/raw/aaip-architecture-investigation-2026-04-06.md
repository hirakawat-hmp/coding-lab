# AAIP (AaaS AI Planner) Architecture Deep Dive

> **Context**: This document provides a comprehensive architecture investigation of the AAIP project,
> an AI-driven marketing strategy planning and presentation generation system. It builds on and
> complements the existing docs: `AGENTS.md` (development guide), `docs/infrastructure.md` (GCP infra),
> `docs/feedback-export.md` (data export). This investigation focuses on code-level architecture,
> data flows, and component relationships not covered in those documents.

---

## Scale Summary

| Subsystem | Files | Code Lines | Language |
|-----------|-------|-----------|----------|
| nextjs-server/src | ~322 | ~33,500 | TypeScript/TSX |
| fastapi-server | ~20 | ~2,000 | Python |
| agents/ | ~27 | ~2,000 | Python |
| rag-server | ~15 | ~2,500 | TypeScript |
| **Total** | **~407** | **~41,800** | |

---

## 1. Next.js Application (nextjs-server/)

### 1.1 Directory Structure

```
src/
  app/                     # Next.js 15 App Router
    api/                   # API routes (all under /api/v4/*)
      auth/                # NextAuth.js endpoints
      v4/                  # Main API namespace
        brief/             # Brief upload & analysis
        cards/             # Card CRUD & reorder
        chat/              # Planner chat (SSE streaming)
        charts/            # Chart image proxy
        feedback/          # User feedback
        presentations/     # Presentation management
        projects/          # Project CRUD
        reference/         # RAG reference file management
        slides/            # Individual slide operations
        tags/              # Tag management
        session/           # Session management
    auth/signin/           # Login page
    slide-viewer/          # Slide preview page
  cards/                   # 27 card type UI components
  components/
    workflow/              # Main workspace (chat, cards, stepper)
    presentation/          # Slide viewer & editor
    project/               # Project management UI
    layout/                # Sidebar, header
    ui/                    # Shared UI primitives
  mastra/                  # Mastra AI integration
    agents/                # Agent definitions
    config/                # Model configuration
    mcp/                   # MCP client setup
    processors/            # Message processors
  lib/
    a2a/                   # A2A protocol client
    db/drizzle/            # DB schema & connection
    db/repositories/       # Data access layer
    rag/                   # RAG server client
    reference/             # Reference file search
    pptx/                  # PPTX export helpers
  store/                   # Jotai state management
    atoms/                 # Atom definitions
    hooks/                 # Custom hooks
  types/project/           # Card type definitions (26 types)
  presentation-templates/  # Slide template components
```

### 1.2 Authentication (NextAuth.js v5)

**File**: `src/auth.ts`

- **Provider**: Credentials only (email + bcrypt password)
- **Strategy**: JWT (stateless, no session DB)
- **DB**: Separate `aaip_auth` database with `auth.users` table
- **Connection**: Dedicated `authPool` in `src/lib/db/drizzle/pool.ts`

```typescript
// src/auth.ts - Key structure
export const { handlers, auth, signIn, signOut } = NextAuth({
  providers: [Credentials({ ... })],
  callbacks: {
    jwt({ token, user }) { token.uid = user.id; ... },
    session({ session, token }) { session.user.id = token.sub; ... },
  },
  session: { strategy: "jwt" },
});
```

**Auth pattern in API routes**: Every API route calls `auth()` to get the session, extracts `userId`,
and verifies resource ownership before proceeding.

### 1.3 Database Layer (Drizzle ORM)

**3-Database Architecture**:

| Database | Schema | Purpose | Pool |
|----------|--------|---------|------|
| `aaip_auth` | `auth` | User authentication | `authPool` |
| `aaip_dev` | `app`, `mastra` | Main app data + Mastra Memory | `pool` |
| `aaip_rag` | `public` | RAG vector store + job queue | RAG Server internal |

**Schema definitions**: `src/lib/db/drizzle/schema/`

- `app.ts` - 11 tables using `pgSchema('app')`:
  - `projects` - User projects with brief content
  - `briefFields` - Structured brief key-value pairs
  - `cards` - Planning cards (type, status, input/output JSON)
  - `presentations` - Presentation metadata
  - `slides` - Individual slides (outline, layout, content JSON)
  - `tags` / `userTags` - Access control tags for reference files
  - `referenceFiles` - Uploaded reference document metadata
  - `solutionThreads` - Chat thread tracking (maps to Mastra threads)
  - `solutionClips` - User-clipped chat messages
  - `feedbacks` - User feedback submissions
- `auth.ts` - 1 table using `pgSchema('auth')`:
  - `users` - User accounts with bcrypt passwords

**Key design**: `pgSchema()` explicitly prefixes SQL with schema names, avoiding `search_path` issues.

**Connection pooling**: `src/lib/db/drizzle/pool.ts` creates singleton `pg.Pool` instances with
Cloud SQL-optimized settings (`keepAlive: true`, `idleTimeoutMillis: 30000`). The pool is shared
between Drizzle ORM, Mastra PostgresStore, and auth operations.

**Repository pattern**: `src/lib/db/repositories/` provides typed data access:
- `project.ts` - findById, findByUserId, create, update, delete
- `card.ts` - CRUD + reorder operations
- `presentation.ts` - Presentation + slide management
- `solution.ts` - Thread + clip management
- `reference.ts` - Reference file metadata
- `tag.ts` - Tag + user-tag associations
- `feedback.ts` - Feedback submission

### 1.4 Mastra AI Integration

**Entry point**: `src/mastra/index.ts`

```typescript
export const mastra = new Mastra({
  observability,  // DefaultExporter + ArizeExporter (Phoenix)
  storage: new PostgresStore({ pool, schemaName: 'mastra' }),
});
```

#### Agent Network Architecture

**Planner Agent** (`src/mastra/agents/planner/planner-agent.ts`) is the central routing agent:

```
User Message
    |
    v
[Planner Agent] (gemini-3-flash)
    |-- Memory: Mastra Memory (PostgresStore + PgVector)
    |-- MCP Tools: RAG search_reference (via rag-server MCP)
    |-- Input Processors: FilterNetworkMessages, TokenLimiter(120k)
    |
    |-- routes to --> marketing-expert (local Mastra Agent)
    |-- routes to --> tdasim-proxy (A2A proxy)
    |-- routes to --> scv-norm-proxy (A2A proxy)
    |-- routes to --> querida-proxy (A2A proxy)
    |-- routes to --> chart-proxy (A2A proxy)
    |-- routes to --> cvsim-proxy (A2A proxy)
```

**Proxy Agent Pattern**: Each external service has a proxy agent that wraps an A2A tool call:

```typescript
// src/mastra/agents/planner/tdasim-proxy-agent.ts
const tdaSimExecuteTool = createTool({
  id: 'tdasim-execute',
  execute: async (inputData) => {
    return { result: await sendA2AMessage({ baseUrl: TDASIM_AGENT_URL, message: inputData.prompt }) };
  },
});
```

**Card Agents** (`src/mastra/agents/v4/card-agent-factory.ts`) - Factory pattern creates agents
per card type using definitions from the card registry:

```typescript
export function getCardAgent(cardType: CardType): Agent {
  const definition = cardDefinitions[cardType];
  return new Agent({
    id: `v4-card-${cardType}`,
    instructions: definition.systemPrompt,
    model: gemini3Flash,
  });
}
```

**Presentation Pipeline** (`src/mastra/agents/presentation/`) - 3-step sequential process:
1. `step01-generate-outline.ts` - Generate page outlines from planning data
2. `step02-select-layout.ts` - Select slide layout for each page
3. `step03-generate-content.ts` - Generate detailed slide content (uses GPT-5)

#### Model Configuration

**File**: `src/mastra/config/model.ts`

| Model | Provider | Use Case |
|-------|----------|----------|
| `gemini-3-flash-preview` | Google AI | Default for all agents (planning, chat, cards) |
| `gemini-3-pro-preview` | Google AI | Available but rarely used |
| `gpt-5-mini` | Azure OpenAI | Slide content generation |
| `gpt-5` / `gpt-5-pro` | Azure OpenAI | Available for complex tasks |

### 1.5 State Management (Jotai)

**Atom families** in `src/store/atoms/`:

- `project.ts` - `projectAtomFamily`, `selectedProjectAtom`
- `planner-chat.ts` - `plannerChatAtomFamily` (keyed by `projectId` or `projectId:card:cardId`)
  - Manages: messages, streaming status, clips, agent execution events
  - SSE event types: `text-delta`, `inner-agent-text-delta`, `routing-reasoning`,
    `agent-execution-start/end`, `tool-call`, `tool-result`, `done`, `error`
- `projects-list.ts` - Project list state
- `reference-files.ts` - Reference file upload state

**Custom hooks** in `src/store/hooks/`:
- `usePlannerChat` - SSE streaming chat with abort support
- `useProjectStore` - Project CRUD operations
- `useProjectsList` - Paginated project listing
- `useReferenceFilesStore` - File upload and management

### 1.6 Card System (26 Types)

**Registry**: `src/types/project/card-definitions/registry.ts`

4 categories, 26 card types:

| Category | Cards |
|----------|-------|
| Analysis & Insight (5) | market-analysis, competitor-analysis, self-analysis, media-output-analysis, timeline-analysis |
| Strategy (10) | requirements, toc, business-challenges, kpi-setting, target-analysis, touchpoint-analysis, target-journey, media-contact, media-issues, media-strategy |
| Tactics & Media (7) | media-selection, budget-allocation, flight, tv-tactics, digital-tactics, odm-tactics, simulation |
| Management (4) | schedule, budget-management, pdca, summary |
| Special (1) | free |

Each card definition contains:
- `type`, `name`, `shortLabel`, `description`
- `icon`, `color`, `bgColor` (UI rendering)
- `systemPrompt` (AI agent instructions)
- `outputSchema` (Zod validation schema for structured JSON output)
- `contextPrefix` (for chain-of-thought context injection)

**Card UI components**: `src/cards/` has one directory per card type, each rendering structured output.

### 1.7 Chat SSE Streaming Flow

**Endpoint**: `POST /api/v4/chat`

```
Client (ChatPanel.tsx)
  |-- POST { projectId, message, cardId? }
  |
  v
API Route (src/app/api/v4/chat/route.ts)
  |-- Auth check
  |-- Load project + cards + brief context
  |-- Get/create Mastra thread
  |-- Inject context: <brief_context>, <project_context>, <card_focus>, <rag_access_context>
  |-- Call planner.network() with SSE stream
  |
  v
SSE Stream (phase state machine)
  |-- Phase: routing-pre    -> emit 'routing-reasoning'
  |-- Phase: agent-executing -> emit 'inner-agent-text-delta', 'tool-call', 'tool-result'
  |-- Phase: routing-post   -> emit 'text-delta' (final answer)
  |-- Filter out '#### Completion Check' artifacts
  |-- On complete: emit 'done' with threadId + messageId
  |
  v
Client (usePlannerChat hook)
  |-- Parse SSE events
  |-- Update Jotai atoms
  |-- Render in ChatMessageList.tsx
```

**Key gotcha**: Mastra Agent Network chunks are double-nested: `chunk.payload.payload.text`.
The route handler explicitly unwraps both levels.

---

## 2. FastAPI Server (fastapi-server/)

### 2.1 Endpoints

| Method | Path | Purpose |
|--------|------|---------|
| POST | `/api/generate-pptx` | Generate PPTX from slide data JSON |
| POST | `/api/summary-pptx/analyze` | Upload PPTX/PDF for AI analysis |
| GET | `/api/summary-pptx/result/{id}` | Get analysis results |
| GET | `/api/summary-pptx/status/{id}` | Check analysis status |
| GET | `/api/summary-pptx/report/{id}` | Download analysis report (MD/JSON) |
| DELETE | `/api/summary-pptx/analysis/{id}` | Delete analysis |
| GET | `/api/summary-pptx/analyses` | List analyses |

### 2.2 PPTX Generation Pipeline

**File**: `fastapi-server/generate_pptx/`

```
JSON Request (name, slides[])
    |
    v
PptxPresentationModel (Pydantic validation)
    |
    v
PptxPresentationCreator
    |-- create_ppt() - processes slides, shapes, text, images
    |-- save() - writes to temp file
    |
    v
StreamingResponse (application/vnd.openxmlformats-officedocument...)
```

### 2.3 Document Analysis Pipeline

**File**: `fastapi-server/summary_pptx/`

3-phase background analysis:
1. **Phase 1**: Content extraction (text, tables, charts, embedded Excel) from PPTX/PDF
2. **Phase 2**: Logical structure analysis (chapter organization using Gemini AI)
3. **Phase 3**: Report generation (strategic summary in Markdown)

**Gotcha**: Analysis results are stored in **in-memory dict** (`analysis_storage`).
This means results are lost on container restart. The code has a comment acknowledging
this: "In production, use Redis/database".

---

## 3. External Agents (agents/)

### 3.1 Agent Overview

| Agent | Tech Stack | Purpose | Model | External Data |
|-------|-----------|---------|-------|---------------|
| tda-sim-agent | Google ADK + A2A + MCP | Ad effect simulation | Azure GPT-5-mini | TDASim MCP Server |
| tda-scv-norm-agent | Google ADK + A2A + BigQuery | SCV norm data analysis | Gemini 2.5 Flash | BigQuery `po_scv_norm` |
| querida-sql-agent | Google ADK + A2A + BigQuery | Querida segment analysis | Gemini 2.5 Flash | BigQuery (Querida data) |
| chart-agent | Google ADK + A2A | Data visualization | Gemini 2.5 Flash | GCS (chart uploads) |
| marketing-demo-agents | Google ADK + A2A | 5 demo agents (HABIT, ACR, Atma, Querida, Tedema) | Gemini | Internal data |

### 3.2 A2A Protocol Implementation

**Server side (agents)**: Each agent uses Google ADK's built-in A2A server (`adk web` or custom server).
The A2A endpoint exposes:
- `GET /.well-known/agent-card.json` - Agent capability discovery
- `POST /` - JSON-RPC `message/send` for synchronous request/response

**Client side (Next.js)**: `src/lib/a2a/client.ts`

```typescript
// JSON-RPC request
{
  jsonrpc: '2.0',
  method: 'message/send',
  params: {
    message: { role: 'user', parts: [{ kind: 'text', text: '...' }] }
  }
}

// Response extraction: artifacts[].parts[] -> text
```

**IAM authentication**: `fetchWithIAM()` from `src/lib/gcloud/iam-client.ts` adds Google ID tokens
for Cloud Run service-to-service auth. Localhost URLs skip IAM.

### 3.3 Chart Agent (Hybrid Rendering)

**File**: `agents/chart-agent/chart_agent/agent.py`

3 rendering engines:
1. **Vega-Lite**: Standard statistical charts (bar, line, scatter, pie, heatmap)
   - Tools: `save_chart_data` -> `render_and_upload_chart`
   - Node.js SSR for rendering
2. **ECharts**: Rich charts (radar, gauge, sankey, treemap, funnel)
   - Tools: `save_chart_data` -> `render_echarts_chart`
   - Node.js SSR with `@resvg/resvg-js`
3. **Code Execution**: Custom visualizations (matplotlib/seaborn/scipy)
   - Uses `UnsafeLocalCodeExecutor` (ADK) - detects Python code blocks in LLM output
   - Tool: `upload_generated_chart` to upload to GCS

**Font**: Zen Maru Gothic (pre-downloaded, bundled in Docker image).

---

## 4. RAG Server (rag-server/)

### 4.1 Architecture

Standalone Node.js service with dual interfaces:
- **HTTP API**: `/api/ingest`, `/api/search`, `/api/documents/{id}` (used by Next.js directly)
- **MCP Server**: `/mcp` (used by Planner Agent via Mastra MCP Client)

### 4.2 RAG Pipeline

```
File Upload (Next.js)
    |
    v
/api/ingest -> Job Queue (aaip_rag.ingest_jobs)
    |
    v
Worker (polling every 5s, FOR UPDATE SKIP LOCKED)
    |
    v
Parser (src/parser/)
    |-- extract.ts: PPTX/PDF/TXT/CSV content extraction
    |-- gemini.ts: Gemini AI for structure analysis
    |
    v
Chunker (src/rag/chunk.ts)
    |-- Max 1500 chars, 200 overlap
    |
    v
Embedder (src/rag/embed.ts)
    |-- Model: gemini-embedding-001
    |-- Dimensions: 768
    |
    v
Store (src/rag/store.ts)
    |-- PgVector storage
    |
    v
BM25 Index (src/rag/bm25.ts)
    |-- Full-text search index
```

### 4.3 Search Pipeline

```
Query -> Hybrid Search
    |
    |-- Vector search (gemini-embedding-001, top_k * 3)
    |-- BM25 full-text search
    |
    v
RRF Fusion (src/rag/fusion.ts, k=60)
    |
    v
Top-K results with metadata (tagId, fileId, fileName)
```

**Access control**: Search requires `tagIds` parameter. Users can only search documents
tagged with tags they have access to (via `user_tags` join table).

---

## 5. Data Flow: End-to-End

### 5.1 Project Creation & Planning

```
1. User creates project (POST /api/v4/projects)
2. User uploads brief (POST /api/v4/brief/upload)
   -> FastAPI analyzes -> brief fields extracted
3. User adds cards to workflow (POST /api/v4/cards)
4. Card execution: POST /api/v4/cards/{cardId}
   -> getCardAgent(cardType) generates structured JSON output
   -> Output stored in cards.output (JSONB)
5. Cards build on each other: each card sees previous cards' output as context
```

### 5.2 Chat Conversation

```
1. User sends message in ChatPanel
2. POST /api/v4/chat
   -> Project context injected (brief, completed cards, RAG access tags)
   -> Planner Agent routes to appropriate sub-agent
   -> SSE stream back to client
3. Messages stored in Mastra Memory (mastra schema)
4. User can "clip" messages (solution_clips table)
```

### 5.3 Presentation Generation

```
1. User triggers presentation generation
2. Step 1: Generate outline from planning cards
   -> presentationStep01Agent creates page titles + content
3. Step 2: Select layout for each page
   -> presentationStep02Agent matches content to template
4. Step 3: Generate detailed slide content
   -> presentationStep03Agent (GPT-5) fills in data
5. User previews in slide-viewer
6. Export: POST /api/v4/presentations/{projectId}/export
   -> Calls FastAPI /api/generate-pptx -> PPTX file download
```

### 5.4 Reference File RAG

```
1. User uploads reference file (POST /api/v4/reference/upload)
   -> File stored, metadata in app.reference_files
   -> ragClient.ingest() sends to RAG Server
   -> Async job queued in aaip_rag.ingest_jobs
2. RAG Worker processes: parse -> chunk -> embed -> store
3. In chat: Planner Agent uses search_reference MCP tool
   -> RAG Server performs hybrid search
   -> Results injected into agent context
```

---

## 6. Component Relationship Diagram

```
                                 [Browser]
                                    |
                              [Next.js App]
                         (Cloud Run: aaip-dev-nextjs)
                                    |
                    +-----------+---+---+-----------+
                    |           |       |           |
              [Auth DB]   [App DB]  [Mastra]   [RAG Server]
              aaip_auth   aaip_dev   schema     (sidecar)
                 |           |     'mastra'        |
              auth.users  app.*      |         [RAG DB]
                          schema   Memory      aaip_rag
                                   Store
                                    |
                    +-------+-------+-------+-------+-------+
                    |       |       |       |       |       |
              [marketing] [tdasim] [scvnorm] [querida] [chart] [cvsim]
               expert     proxy    proxy     proxy    proxy   proxy
               (local)    (A2A)    (A2A)     (A2A)    (A2A)   (A2A)
                            |        |         |        |
                            v        v         v        v
                       [TDASim   [SCV Norm  [Querida [Chart
                        Agent]    Agent]     Agent]   Agent]
                       (ADK+MCP) (ADK+BQ)  (ADK+BQ) (ADK+GCS)
                            |        |         |
                            v        v         v
                       [TDASim   [BigQuery] [BigQuery]
                        MCP Svr]

                    [FastAPI Server]
                 (Cloud Run: aaip-dev-fastapi)
                    |            |
              [PPTX Gen]  [Doc Analysis]

                    [Arize Phoenix]
                 (Cloud Run: aaip-phoenix)
                    <- OTLP traces from all services
```

---

## 7. Tradeoffs & Limits Summary

### What's Handled Well

1. **Agent Network abstraction**: The Planner -> Proxy Agent -> A2A pattern cleanly separates
   concerns. Adding a new external agent requires only a new proxy agent file and A2A URL config.

2. **Tag-based RAG access control**: The tag system (`tags` + `user_tags` + `reference_files`)
   provides granular document access control without complex RBAC. Users can share document
   collections via shared tags.

3. **Database schema isolation**: Using `pgSchema()` in Drizzle avoids `search_path` ambiguity.
   The 3-database split (auth/app/rag) provides clean separation of concerns.

4. **Cloud SQL connection handling**: `keepAlive: true` + `idleTimeoutMillis: 30000` in pool
   config prevents Cloud SQL's silent TCP connection drops (documented in commit c42a69c).

5. **Observability**: Full tracing pipeline with Arize Phoenix across all services (Mastra +
   ADK agents). VPC-internal communication for trace collection.

### What's Not Handled / Degraded

1. **FastAPI analysis storage is in-memory**: `analysis_storage: Dict[str, Dict[str, Any]] = {}`
   in `summary_pptx/router.py` means analysis results are lost on container restart.
   File: `fastapi-server/summary_pptx/router.py:44`

2. **No test coverage**: No test files found in the codebase. The `tokei` output shows 0 test files.

3. **Presentation persona images**: Multiple TODOs for persona image generation:
   `src/presentation-templates/japanese/020-target-persona.tsx:81`

4. **Product tour not implemented**: Sidebar has placeholder:
   `src/components/layout/Sidebar.tsx:157` -> `onClick={() => {/* TODO: プロダクトツアー起動 */}}`

5. **Deprecated model exports still in use**: `src/mastra/config/model.ts` has 7 deprecated
   aliases marked for removal but still exported.

6. **SSE Completion Check filtering is fragile**: The route handler accumulates `fullText` and
   scans for `'#### Completion Check'` substring in streamed tokens. If the marker spans
   across chunks differently, it could leak through.
   File: `src/app/api/v4/chat/route.ts:277`

### Architecture Decisions

1. **Mastra Memory over custom DB**: Chat messages are stored in Mastra's `PostgresStore`
   (mastra schema) rather than custom tables. Thread tracking is done via `solution_threads`
   table which maps `projectId` -> Mastra `threadId`. This avoids duplicating message storage
   but creates a dependency on Mastra's internal schema.

2. **A2A over direct API calls**: External agents use the A2A protocol (JSON-RPC) rather than
   direct REST APIs. This provides agent-card discovery and a standardized message format, but
   adds latency (card fetch + RPC overhead) for every call.

3. **RAG as sidecar with MCP**: The RAG server runs as a separate service but is accessed via
   MCP protocol from the Planner Agent. This allows the RAG search tool to appear as a native
   agent tool, but means the RAG server must be deployed alongside Next.js.

4. **26-card registry pattern**: All card types are defined in a single registry file with
   Zod schemas for output validation. This centralizes card definitions but the file is ~800
   lines and growing. Each card type has a dedicated UI component in `src/cards/`.

5. **Dual model strategy**: Gemini 3 Flash for fast operations (chat, planning, cards),
   GPT-5 for high-quality content generation (slide content). This optimizes cost/quality
   but introduces Azure OpenAI as an additional dependency.

---

## 8. Migration / Reuse Considerations

### Reusable as-is
- A2A client library (`src/lib/a2a/client.ts`) - generic JSON-RPC + IAM auth
- DB pool configuration with Cloud SQL optimizations (`src/lib/db/drizzle/pool.ts`)
- Card definition registry pattern (`src/types/project/card-definitions/`)
- SSE streaming pattern for agent networks (`src/app/api/v4/chat/route.ts`)

### Needs adaptation
- Card type definitions are domain-specific (marketing strategy)
- Presentation templates are tightly coupled to the card output schemas
- RAG server assumes specific metadata fields (tagId, fileId, fileName)

### Would need rebuild
- Mastra Memory integration is version-locked to specific `@mastra/core` versions
- Agent prompt engineering is domain-specific and iteratively tuned
- GCP infrastructure (Cloud Run, Cloud SQL, Secret Manager) would need reconfiguration for different cloud providers
