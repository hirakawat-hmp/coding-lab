# ChatGPT Turnstile Bot Detection Reverse-Engineered (2026-05-03)

Source: https://gigazine.net/news/20260502-chatgpt-cloudflare/
OGP: https://i.gzn.jp/img/2026/05/02/chatgpt-cloudflare/00_m.png

Security researchers (Buchodi) reverse-engineered Cloudflare Turnstile used by ChatGPT.

Architecture:
- Examines ~55 properties across 3 layers: browser characteristics, Cloudflare network data, ChatGPT application state
- Checks include WebGL, screen resolution, hardware specs, font measurements, DOM operations
- Encrypted bytecode with two-stage decryption: XOR with tokens, then 19KB encrypted program using floating-point values in VM instructions

Supporting detection methods:
- Signal Orchestrator: behavioral biometrics (keystroke timing, mouse velocity)
- Proof of Work: SHA-256 hashing + fingerprinting

Analysis of 377 programs showed consistent properties. Obfuscation hides fingerprinting details and prevents replay attacks.
