# Formatting an entire 25 million line codebase overnight: the rubyfmt story

Source: https://stripe.dev/blog/formatting-an-entire-25-million-line-codebase-overnight-the-rubyfmt-story
Fetched: 2026-05-05
Published: 2026-04-28

## Overview

Stripe's Developer Productivity team deployed rubyfmt, a Rust-based code formatter, across their massive 25 million line Ruby codebase in a single overnight operation.

## Key Technical Details

- **Codebase Size:** 25 million lines of Ruby code (world's largest Ruby codebase)
- **Tool Used:** rubyfmt – a Rust-based zero-config formatter
- **Key Features:** Zero-config operation and ultra-fast performance
- **Execution:** Completed overnight as a single deployment
- **Team:** Stripe's Developer Productivity team (Fable Tales and Anna Mason)

## Significance

This demonstrates how tooling automation can dramatically reduce friction in developer workflows. The choice of Rust for rubyfmt ensures the formatter is fast enough to handle massive codebases in a single run.
