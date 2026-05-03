# S3 Vectors vs OpenSearch: RAGのベクトルストア比較 (2026-05-03)

Source: https://qiita.com/yakumo_09/items/c1118838c20107db54a9
Published: 2026-05-02
OGP: https://qiita-user-contents.imgix.net/...

Amazon S3 Vectors (newly released) vs Amazon OpenSearch Service for RAG.

S3 Vectors:
- Storage-centric, pay-as-you-go
- Up to 2 billion vectors per index
- Latency: ~100ms to 1 second
- Cost for 1M vectors: ~$1.70/month
- Ideal for cost-sensitive, infrequent access

OpenSearch Serverless:
- Compute-based, minimum fixed costs (~$173/month non-redundant, ~$346 production)
- Ultra-low latency (milliseconds)
- Native hybrid search (vector + keyword)
- High concurrent throughput
- Better Japanese language support (morphological analysis)
- Complex filtering support

Recommendation: Start with S3 Vectors → migrate to OpenSearch when performance demands increase.
