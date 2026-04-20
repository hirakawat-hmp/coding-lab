# Let's Encryptの短期証明書とARI (Raw)

Source: https://zenn.dev/catatsuy/articles/2ac24bccb4b7d1
Fetched: 2026-04-20

## Problem
Let's Encrypt's 160-hour short-term certificates (vs traditional 90-day) create significant operational challenges.

## Rate Limiting Challenges
- "5 certificates per 7 days for identical domain combinations"
- Short-term certs need renewal every ~3 days → quota fills quickly
- Recovery: only 1 certificate slot regenerates every 34 hours
- RSA + ECDSA doubles certificate needs

## What is ARI?
ACME Renewal Information (ARI): a protocol mechanism where Certificate Authorities signal optimal renewal timing to ACME clients. Updates via ARI are excluded from all rate restrictions.

## Supported Clients
- **lego**: well-suited, supports `shortlived` profile and ARI implementation

## Key Takeaways
1. Test configurations in staging first
2. Use ARI-compatible clients for short-term certificates
3. Production viability uncertain; monitoring fatigue and frequent breakage are real challenges
