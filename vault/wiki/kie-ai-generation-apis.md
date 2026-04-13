---
type: entity
status: []
tags:
  - ai/llm
  - dev/typescript
sources:
  - "ai_generation_apis_overview.md"
created: 2026-04-06
updated: 2026-04-06
---

# Kie.ai AI 生成 API

Kie.ai (`https://api.kie.ai`) 経由で利用できる AI コンテンツ生成 API 群。Bearer Token 認証で統一されたインターフェースを提供する。

## 共通仕様

- **認証**: `Authorization: Bearer YOUR_API_KEY`
- **基本フロー**: タスク作成（POST）-> taskId 取得 -> ポーリングまたはコールバックで結果取得
- **コールバック方式推奨**: `callBackUrl` を指定して完了通知を受け取る

## Veo 3.1（Google）

高品質動画生成 API。8秒動画が標準、処理時間は2-5分。

| 項目 | 内容 |
|------|------|
| モデル | `veo3`（高品質）, `veo3_fast`（高速） |
| 生成モード | TEXT_2_VIDEO, FIRST_AND_LAST_FRAMES_2_VIDEO, REFERENCE_2_VIDEO |
| アスペクト比 | 16:9, 9:16, Auto |
| 1080P HD | 16:9 のみ対応、追加処理時間が必要 |
| エンドポイント | `/api/v1/veo/generate`, `/api/v1/veo/record-info`, `/api/v1/veo/get-1080p-video` |

REFERENCE_2_VIDEO は参照画像1-3枚を使用（veo3_fast + 16:9 のみ）。`seeds` パラメータ（10000-99999）で再現性を確保できる。

## Sora 2（OpenAI）

高品質動画生成 API。10秒または15秒の動画を生成。

| 項目 | 内容 |
|------|------|
| モデル | `sora-2-text-to-video`, `sora-2-pro-text-to-video`, `sora-2-image-to-video`, `sora-2-pro-image-to-video` |
| 動画の長さ | 10秒 / 15秒 |
| 品質 | Pro 版で `size: "high"` 指定可能 |
| ウォーターマーク | 除去機能あり（デフォルト: true） |
| エンドポイント | `/api/v1/jobs/createTask`, `/api/v1/jobs/recordInfo` |

## Midjourney

高品質画像生成 API。動画生成にも対応。

| 項目 | 内容 |
|------|------|
| タスクタイプ | `mj_txt2img`, `mj_img2img`, `mj_style_reference`, `mj_omni_reference`, `mj_video`, `mj_video_hd` |
| モデルバージョン | 7, 6.1, 6, niji6 |
| 速度 | relaxed（低速・無料）, fast（標準）, turbo（最速・プレミアム） |
| アップスケール | `/api/v1/mj/upscale` で高解像度化 |
| バリエーション | `/api/v1/mj/vary` で既存画像のバリエーション生成 |
| ファイル保持 | **15日間**（早めにダウンロード必要） |

## API 機能比較

| 機能 | Veo 3.1 | Sora 2 | Midjourney |
|------|---------|--------|------------|
| Text-to-Video | o | o | x |
| Image-to-Video | o | o | o |
| Text-to-Image | x | x | o |
| Image-to-Image | x | x | o |
| HD 対応 | o (1080P) | o | o (HD video) |
| 動画の長さ | 8秒 | 10秒/15秒 | - |
| ウォーターマーク除去 | x | o | x |

## 実装上の推奨事項

- コールバック方式を優先し、ポーリングは fallback として実装
- Midjourney の15日間ファイル保持制限に注意し、生成後すぐにダウンロード・保存
- レート制限対策として適切なバックオフ戦略を実装
- クレジット使用量を監視し、速度オプションでコスト調整
