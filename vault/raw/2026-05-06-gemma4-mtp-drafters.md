# Accelerating Gemma 4: faster inference with multi-token prediction drafters

Source: https://blog.google/innovation-and-ai/technology/developers-tools/multi-token-prediction-gemma-4/
Retrieved: 2026-05-06
OGP Image: https://storage.googleapis.com/gweb-uniblog-publish-prod/images/Hero_Visual.width-200.format-webp.webp

## Summary

Google released Multi-Token Prediction (MTP) drafters for Gemma 4 models, enabling up to 3x inference speedup through speculative decoding without compromising output quality.

## Technical Details

**Architecture:** Speculative decoding with lightweight drafter model
- Drafter predicts multiple future tokens simultaneously
- Target model verifies in parallel
- Shared KV cache between drafter and target model (eliminates redundant calculations)

**Performance:**
- Up to 3x speedup in tokens-per-second
- ~2.2x speedup on Apple Silicon (batch sizes 4-8)
- Similar gains on Nvidia A100
- "Zero quality degradation" (target model retains final verification)

**Platforms:** LiteRT-LM, MLX, Hugging Face Transformers, vLLM

**License:** Apache 2.0

**Available:** Hugging Face, Kaggle

## Why It Matters

Memory-bandwidth is the bottleneck in standard LLM inference. By predicting and verifying multiple tokens in parallel, MTP drafters achieve significant throughput gains on both edge devices (Apple Silicon) and datacenter GPUs (A100).
