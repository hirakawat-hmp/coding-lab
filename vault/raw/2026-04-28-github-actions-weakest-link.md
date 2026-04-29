# GitHub Actions is the weakest link

- Source: https://nesbitt.io/2026/04/28/github-actions-is-the-weakest-link.html
- Published: 2026-04-28
- Author: Andrew Nesbitt

## Summary

Analysis of GitHub Actions security vulnerabilities enabling supply chain attacks.

**Key vulnerabilities:**
1. `pull_request_target` trigger executes with full secrets + write tokens
2. Mutable action references (tags instead of SHAs)
3. Cache poisoning crossing trust boundaries
4. Write-scoped GITHUB_TOKEN defaults (pre-Feb 2023 repos)
5. Template injection via PR titles/comments

**8 major incidents:** Ultralytics, tj-actions, nx, Trivy, elementary-data, axios, Bitwarden (Nov 2024–Apr 2026)

**Recommendations:** zizmor linter, pin all action SHAs, explicit permissions blocks, treat PR metadata as malicious
