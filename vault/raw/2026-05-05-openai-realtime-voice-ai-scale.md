# How OpenAI delivers low-latency voice AI at scale

Source: https://openai.com/index/delivering-low-latency-voice-ai-at-scale/
Fetched: 2026-05-05

## Overview

OpenAI published a technical blog post explaining how they deliver low-latency voice AI at scale for their Realtime API and voice features in ChatGPT.

## Key Technical Points

- Optimized infrastructure for sub-200ms latency voice processing
- Uses a streaming pipeline from speech-to-text through LLM to text-to-speech
- Custom model serving infrastructure designed for real-time audio
- Global edge network deployment to reduce latency by geographic proximity
- Techniques for efficient batching of audio segments

## Significance

OpenAI's Realtime API enables developers to build voice AI applications with human-like response speeds. The post details the engineering challenges of maintaining low latency while scaling to millions of concurrent users.
