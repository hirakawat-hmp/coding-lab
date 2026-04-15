# Raw: Introspective Diffusion Language Models (I-DLM)

Source: https://introspective-diffusion.github.io/
Paper: https://arxiv.org/abs/2604.11035
Fetched: 2026-04-15

## Overview

I-DLM bridges the gap between diffusion language models (DLMs) and autoregressive (AR) models. Key insight: "AR models agree with what they generate, whereas DLMs often do not."

## Key Contributions

1. **Introspective Consistency Framework**: dedicated training to simultaneously generate AND validate tokens
2. **Introspective Strided Decoding (ISD)**: generates N tokens per forward pass while verifying prior tokens
3. **AR-Compatible Architecture**: uses strict causal attention → drop-in for SGLang etc.

## How It Works

Training: converts pretrained AR models via causal attention masking, logit shift and all-masked objectives, 4.5B tokens on 8 H100 GPUs.

Inference: MASK positions propose new tokens; clean positions verify prior tokens; min(1, p(x)/q(x)) acceptance.

## Results (I-DLM-8B)

- AIME-24: 69.6 (vs LLaDA-2.1-mini: 43.3)
- LiveCodeBench-v6: 45.7 (vs LLaDA-2.1-mini: 30.4)
- Throughput: 2.9-4.1× improvement
- Acceptance rate: 0.984 vs SDAR's 0.699

Authors: Together AI, UIUC, Princeton, Stanford, UT Austin

HN discussion: 220 pts, 42 comments
