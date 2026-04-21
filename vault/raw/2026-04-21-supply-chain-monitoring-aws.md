# サプライチェーン攻撃対策ネットワーク監視 (AWS) — Raw Source

Source: https://zenn.dev/aeyesec/articles/32fb05ddd1c3f7
Author: はるぷ, AI Security Lab
Fetched: 2026-04-21
Published: April 20, 2026

## Architecture

Detection model: post-compromise C&C communication detection via unintended outbound comms.

### AWS Components

- Route 53 Resolver Query Logs (DNS capture)
- VPC Flow Logs (network traffic)
- Athena (SQL log analysis, no migration needed)
- DynamoDB (approved communications whitelist)
- Lambda (orchestration + alert)
- EventBridge (scheduled trigger)

### Flow

1. Correlate DNS-resolved IPs with VPC traffic
2. Filter against DynamoDB whitelist
3. Alert via Slack on unrecognized communications

## Design Principles

- 80% detection sustainably >> 100% perfection that breaks operations
- Initial tuning: several hours to establish clean baseline
- Daily ops: < 10 minutes (review Slack + update whitelist)
- Cost: "near zero" (charges only during analysis)

## Limitations

- Cannot detect attacks using approved domains
- Bypassing Route 53 resolver → surfaces as unresolved IP (still detectable)
