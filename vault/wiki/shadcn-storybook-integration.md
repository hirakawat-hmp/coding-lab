---
type: concept
status: []
tags:
  - ui/components
  - dev/typescript
sources:
  - "/Users/hdymacuser/Desktop/prompt-management-system/.serena/memories/shadcn_storybook_integration.md"
  - "/Users/hdymacuser/Desktop/prompt-management-system/.serena/memories/storybook_setup.md"
created: 2026-04-06
updated: 2026-04-06
---

# shadcn/ui + Storybook 統合

shadcn/ui と Storybook を組み合わせた UI コンポーネント開発環境の構築パターン。

## なぜこの組み合わせが有効か

1. **同一技術スタック**: TypeScript + Tailwind CSS + React
2. **コード所有権**: shadcn/ui はコピー方式なので完全にカスタマイズ可能
3. **分離開発**: Storybook でコンポーネントを隔離して開発・テスト
4. **ライブドキュメント**: Storybook が自動生成する対話的ドキュメント

## 推奨構成

- **Storybook**: v10 + `@storybook/nextjs-vite` フレームワーク
- **shadcn/ui**: New York スタイル / Neutral カラー / CSS Variables 有効
- **テスト**: `@storybook/addon-vitest` + `@storybook/addon-a11y`

## ディレクトリ構成

```
src/
  components/
    ui/               # shadcn/ui コンポーネント
      button.tsx
      button.stories.tsx   # Stories はコンポーネント横に配置
  lib/
    utils.ts          # cn() ユーティリティ
```

## Story テンプレート

```typescript
import type { Meta, StoryObj } from '@storybook/nextjs-vite';
import { ComponentName } from './component-name';

const meta = {
  title: 'shadcn/ui/ComponentName',
  component: ComponentName,
  parameters: {
    layout: 'centered',
    nextjs: { appDirectory: true },
  },
  tags: ['autodocs'],
} satisfies Meta<typeof ComponentName>;

export default meta;
type Story = StoryObj<typeof meta>;

export const Default: Story = { args: {} };
```

## Story のベストプラクティス

- `shadcn/ui/` プレフィックスでグルーピング
- 全バリアント・サイズ・状態の Story を作成
- コンポーネント組み合わせの Story を含める（例: Input + Label）
- `argTypes` でプロパティを文書化
- `tags: ['autodocs']` で自動ドキュメント生成

## Storybook 設定のポイント

- `.storybook/preview.ts` で `globals.css` をインポート（Tailwind CSS の反映に必須）
- `nextjs.appDirectory: true` で App Router サポートを有効化
- A11y アドオンを `'todo'` モードで設定（UI 表示のみ、ビルド非ブロック）

## テスト統合

Vitest + Playwright によるコンポーネントテスト:

```typescript
import { composeStories } from '@storybook/react';
import * as stories from './Button.stories';

const { Primary } = composeStories(stories);

test('renders primary button', () => {
  const { getByText } = render(<Primary />);
  expect(getByText('Click me')).toBeInTheDocument();
});
```

## トラブルシューティング

| 症状 | 原因 | 対策 |
|------|------|------|
| スタイル未反映 | globals.css 未インポート | `.storybook/preview.ts` に追加 |
| Image コンポーネントエラー | public/ に画像なし | 静的アセットのパス確認 |
| TypeScript エラー | パスエイリアス不整合 | `tsconfig.json` の `@/*` 設定確認 |

## cn() ユーティリティ

shadcn/ui 全コンポーネントで使用される Tailwind クラス結合関数:

```typescript
import { cn } from '@/lib/utils';
<div className={cn('base-classes', condition && 'conditional-classes', className)}>
```

## 開発ワークフロー

1. `npx shadcn@latest add <component>` でコンポーネント追加
2. `*.stories.tsx` を作成
3. `npm run storybook` で確認
4. アプリケーションで使用

## 関連ページ

- [[wiki/tdd-parallel-workflow]] -- フロントエンド実装で shadcn/ui + Storybook を活用するワークフロー
