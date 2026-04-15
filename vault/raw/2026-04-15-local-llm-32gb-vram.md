# Raw: Building a 32GB VRAM Local LLM Environment (Cost-Effective)

Source: https://zenn.dev/playree/articles/2376eee1d9d24d
Fetched: 2026-04-15
Author: playree
Published: April 14, 2026

## Hardware Configuration

**GPU: Dual RTX 5060 Ti 16GB**
- Cost: ~200,000 yen total (vs RTX 5090 ~600,000 yen)
- Combined 32GB VRAM
- Power: 360W total (vs 575W for RTX 5090)
- PCIe 5.0 x8 compatibility

## Critical Motherboard Issue

**CPU-Direct x8/x8 is required:**
Most motherboards default to x16/x4 configuration, causing one GPU to bottleneck at PCIe x4 bandwidth.

Recommended motherboards supporting x8/x8:
- MSI MPG Z890 CARBON WIFI
- ASUS ProArt Z890-CREATOR WIFI

Physical issue: second GPU blocks PCIe auxiliary power connector → solved with right-angle adapter.

## Performance Results

Gemma4 26B via Ollama: ~12GB VRAM usage per GPU, efficient inference.

## Other Recommendations

- 1000W PSU
- Robust airflow for dual GPU thermals
- Ubuntu 25.10+ for driver support

Zenn: https://zenn.dev/playree/articles/2376eee1d9d24d
