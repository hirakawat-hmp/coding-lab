---
type: how-to
status: []
tags:
  - infra/gcp
  - dev/python
  - infra/docker
sources:
  - "/Users/hdymacuser/Desktop/main/2026年/1月/sql-agent/.serena/memories/docker_deployment_plan.md"
  - "/Users/hdymacuser/Desktop/tele-digi-cvsimulator/.serena/memories/infrastructure_and_deployment.md"
created: 2026-04-06
updated: 2026-04-06
---

# Cloud Run + FastAPI デプロイパターン

Cloud Run に FastAPI アプリをデプロイする際の汎用パターン。Docker イメージ構築、認証、ストレージ、DB 接続を網羅する。

## Dockerfile テンプレート（uv ベース）

```dockerfile
FROM ghcr.io/astral-sh/uv:python3.12-bookworm-slim

WORKDIR /app

# 依存関係（キャッシュ活用）
COPY pyproject.toml uv.lock ./
RUN uv sync --frozen --no-dev

# アプリケーションコード
COPY . .

# 非 root ユーザー（セキュリティ）
RUN adduser --disabled-password --gecos "" appuser && \
    chown -R appuser:appuser /app
USER appuser

EXPOSE 8000
CMD ["sh", "-c", "uv run uvicorn main:app --host 0.0.0.0 --port ${PORT:-8000}"]
```

ポイント:
- `uv sync --frozen --no-dev` で依存関係レイヤーをキャッシュ
- 非 root ユーザーで実行
- `PORT` 環境変数で Cloud Run のポート注入に対応

## GCP 認証の優先順位

1. `GOOGLE_SA_CREDENTIALS_JSON` 環境変数（JSON 文字列直書き、ローカル Docker 用）
2. `GOOGLE_APPLICATION_CREDENTIALS` 環境変数（ファイルパス）
3. ADC / Workload Identity（Cloud Run 本番、推奨）

```python
def get_credentials():
    sa_json = os.environ.get("GOOGLE_SA_CREDENTIALS_JSON")
    if sa_json:
        return service_account.Credentials.from_service_account_info(
            json.loads(sa_json), scopes=[...])
    import google.auth
    credentials, _ = google.auth.default(scopes=[...])
    return credentials
```

## アーキテクチャ構成パターン

### 1コンテナ構成（シンプル）

```
1コンテナ (start.sh で両方起動)
├── Next.js (port 8080) ← 外部ポート
│   └── rewrites で /api/* を FastAPI にプロキシ
└── FastAPI (port 8000) ← 内部のみ
```

### 2サービス構成（推奨）

```
Cloud Run
├── Frontend Service (Next.js)
│   └── /api/* → Backend Service
└── Backend Service (FastAPI)
    ├── Cloud SQL (PostgreSQL)
    └── GCS (gcsfs / gcsfuse)
```

## データベース接続

- **ORM**: SQLModel（FastAPI 作者製、Pydantic 統合）
- **ドライバ**: asyncpg（非同期）
- **接続**: Cloud SQL Auth Proxy 経由（`--add-cloudsql-instances`）
- **Secret 管理**: Secret Manager で DATABASE_URL を管理

## ストレージ

- **GCS FUSE**: Cloud Run Gen2 でファイルシステムとしてマウント
- **環境変数**: `STORAGE_BASE` で全環境のパスを統一（[[wiki/firestore-unified-storage]] 参照）

## バックグラウンドタスク

- `asyncio.create_task()` + DB ポーリング
- 進捗: 0-100%、フロントエンドで 3 秒間隔ポーリング
- タイムアウト: 30 分以上 running のタスクを failed に更新

## Cloud Run デプロイコマンド

```bash
# サービスアカウント作成（初回）
gcloud iam service-accounts create <sa-name> \
  --display-name="Service Account"

# 権限付与
gcloud projects add-iam-policy-binding <project> \
  --member="serviceAccount:<sa>@<project>.iam.gserviceaccount.com" \
  --role="roles/bigquery.dataViewer"

# デプロイ
gcloud run deploy <service> \
  --source . \
  --service-account=<sa>@<project>.iam.gserviceaccount.com \
  --region=asia-northeast1 \
  --set-env-vars="KEY=VALUE"
```

## .dockerignore

```
.venv/
.git/
__pycache__/
*.pyc
.env
.serena/
.claude/
```

## セキュリティ

| 対象 | 方式 |
|------|------|
| クライアント UI | なし or IP 制限（Cloud Armor / Next.js middleware） |
| 管理者 API | 環境変数認証（ADMIN_USERNAME / ADMIN_PASSWORD）|
| Secret | Secret Manager |
| DB | Cloud SQL Auth Proxy + IAM |

## コスト目安（月額、小規模）

| カテゴリ | 月額 |
|----------|------|
| Cloud SQL (db-f1-micro) | ~$13 |
| Cloud Run | ~$2 |
| GCS | ~$0.01 |
| Secret Manager | ~$0.24 |
| **合計** | **~$15** |

## 関連ページ

- [[wiki/firestore-unified-storage]] -- ストレージパスの統一設計
- [[wiki/rag-mcp-sidecar]] -- Cloud Run サイドカー構成の応用例
