# Raw: WriteBack-RAG

Source: https://zenn.dev/knowledgesense/articles/5a50d06fce072d
Fetched: 2026-04-15
Published: April 14, 2026
Hatena Bookmark: 55 users

## What It Is

WriteBack-RAG automatically rewrites and organizes the knowledge base itself using AI. Rather than discarding insights after each RAG query, it captures and stores them as refined knowledge.

## Key Problem

Large enterprises: scattered information across documents. Traditional RAG cannot efficiently handle fragmentation. Agentic RAG results are lost once response is generated.

## How It Works

Four phases:
1. **Sample Selection**: Identify past queries where search genuinely improved answer quality
2. **Document Identification**: Extract specific documents that contributed to improvements
3. **Distillation**: Consolidate multiple documents into one compact AI-rewritten document
4. **Write-Back**: Store refined document in separate database alongside original knowledge base

Query time: search both original and write-back databases simultaneously.

## Results (48 configurations)

- Average: +2.14% improvement
- FEVER task: +4.79%
- NQ (open-domain QA): +3.01%
- Write-back documents average 72-93 tokens (2-7× compression)

Zenn: https://zenn.dev/knowledgesense/articles/5a50d06fce072d
