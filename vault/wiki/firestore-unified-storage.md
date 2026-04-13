---
type: concept
status: []
tags:
  - infra/gcp
  - dev/typescript
  - dev/python
  - project/aaas-ai-planner
sources:
  - "/Users/hdymacuser/Desktop/tele-digi-cvsimulator/.serena/memories/unified_storage_architecture.md"
  - "/Users/hdymacuser/Desktop/tele-digi-cvsimulator/.serena/memories/firestore_unification_plan.md"
created: 2026-04-06
updated: 2026-04-06
---

# Firestore 統一ストレージアーキテクチャ

ローカル開発と Cloud Run 本番環境でストレージパスを統一し、Firestore を Single Source of Truth とするアーキテクチャパターン。

## 背景・課題

1. **パス不一致**: ローカルでは `./data/` マウント、本番では GCS FUSE `/gcs/` と構造が異なる
2. **設定ファイル永続化の欠如**: コンテナ再起動でクライアント設定が消失
3. **環境差異によるバグリスク**: ローカルで動いても本番で動かない

## 統一ディレクトリ設計

環境変数 `STORAGE_BASE` で全環境のルートパスを統一する:

```
STORAGE_BASE/
├── configs/
│   └── clients/
│       └── {client_name}.yaml
└── data/
    └── {client_name}/
        ├── raw/
        └── v2/
            ├── processed/data.pkl
            └── models/models.pkl
```

| 環境 | STORAGE_BASE | 実パス |
|------|-------------|--------|
| ローカル (Docker) | `/app/storage` | ホスト `./storage/` マウント |
| 本番 (Cloud Run) | `/gcs` | GCS FUSE マウント |
| ローカル (直接起動) | `./storage` | カレントディレクトリ配下 |

## パスヘルパー設計

Python の `paths.py` モジュールで一元管理:

```python
@lru_cache(maxsize=1)
def get_storage_base() -> Path:
    # 1. STORAGE_BASE 環境変数（優先）
    # 2. GCS_MOUNT_PATH 環境変数（後方互換）
    # 3. デフォルト: ./storage
```

`get_client_config_path()` / `get_client_data_dir()` / `get_client_processed_dir()` 等の専用ヘルパーを提供し、パス構築ロジックをサービス層から排除する。

## Firestore 統合

Firestore を Single Source of Truth とし、ローカルファイルはフォールバックとして維持:

### 書き込み (save_meta)
1. Firestore に書き込み（必須）
2. ローカル JSON にも保存（バックアップ）

### 読み込み (list_clients)
1. Firestore から取得を試みる
2. Firestore が空またはエラーの場合のみローカル YAML をスキャン

### リアルタイム化
REST API ポーリングから Firestore `onSnapshot` リスナーへ移行:

```typescript
// useClientsSubscription hook
onSnapshot(collection(db, COLLECTION.CLIENTS), (snapshot) => {
  useClientsStore.getState().setClients(docs);
});
```

これにより、他端末やバックエンドでのデータ変更が即座に UI に反映される。

## Docker Compose 設定

```yaml
volumes:
  - ./storage:/app/storage    # 統一ストレージ
environment:
  STORAGE_BASE: /app/storage
```

## 検証済みの動作

- クライアント作成 → `storage/configs/clients/` に YAML 保存
- 前処理/モデル学習 → `storage/data/` 配下に pkl 生成
- コンテナ再起動後もデータ保持

## 設計上の注意点

- `GCS_MOUNT_PATH` は後方互換性のために引き続きサポート
- ディレクトリが存在しない場合は自動作成
- `get_storage_base()` は `lru_cache` でキャッシュ
- テスト時は `STORAGE_BASE` を一時ディレクトリに設定

## 関連ページ

- [[wiki/cloud-run-fastapi-deploy]] -- Cloud Run + GCS FUSE のデプロイパターン
