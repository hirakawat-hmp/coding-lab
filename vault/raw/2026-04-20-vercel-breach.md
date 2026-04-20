# Vercel April 2026 Security Incident (Raw)

Source: https://www.bleepingcomputer.com/news/security/vercel-confirms-breach-as-hackers-claim-to-be-selling-stolen-data/
Also: https://vercel.com/kb/bulletin/vercel-april-2026-security-incident
Fetched: 2026-04-20

## Summary

Cloud development platform Vercel confirmed a security incident involving unauthorized access to internal systems. The breach originated from a compromised employee's Google Workspace account at third-party AI tool Context.ai, which attackers leveraged to escalate access into Vercel environments.

## Data Affected
- Environment variables not marked as "sensitive" (stored unencrypted)
- Employee information: 580 records (names, Vercel email addresses, account status, timestamps)
- Access keys, source code, database credentials
- API keys including NPM tokens and GitHub tokens

Vercel clarified that "Vercel stores all customer environment variables fully encrypted at rest," but non-sensitive variables were exposed through enumeration.

## Timeline
- April 19, 2026: Vercel publicly disclosed the incident
- Threat actor claiming "ShinyHunters" posted on hacking forums
- Attacker allegedly discussed $2 million ransom demand via Telegram

## Impact
- Limited subset of customers affected
- Core services and Next.js/Turbopack uncompromised

## Remediation
- Review environment variables, enable sensitive variable encryption, rotate secrets
- Engaged incident response experts, notified law enforcement

OGP Image: https://www.bleepstatic.com/content/hl-images/2026/04/19/vercel-header-lg.jpg
