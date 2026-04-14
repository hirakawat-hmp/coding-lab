---
type: how-to
status: [draft]
tags:
  - infra/k8s
sources:
  - "https://zenn.dev/mitene/articles/202604-ingress-nginx-to-envoy-gateway"
  - "https://kubernetes.io/blog/2025/11/11/ingress-nginx-retirement/"
  - "https://kubernetes.io/blog/2026/03/20/ingress2gateway-1-0-release/"
created: 2026-04-14
updated: 2026-04-14
---

# Ingress NGINX → Gateway API + Envoy Gateway 移行

Kubernetes公式のIngress NGINXが2026年3月にretirementを迎えた。本ページは、Gateway API（+ Envoy Gateway実装）への移行手順をまとめる。

## 背景

Kubernetes SIG Networkは2025年11月にIngress NGINXのretirementを発表。2026年3月以降は新規リリース・バグ修正・セキュリティアップデートなし。

**即刻移行を推奨**（公式Kubernetesブログより）。

## なぜGateway APIか

| 比較軸 | Ingress API | Gateway API |
|--------|------------|-------------|
| 拡張性 | annotation依存 | 構造化リソース |
| 認証・ポリシー | 非標準 | 明示的に管理可能 |
| 将来性 | メンテナンス終了 | Kubernetes標準 |
| 責務分離 | 混在 | Route/Gateway/Policyで分離 |

## なぜEnvoy Gatewayか

NGINX Gateway Fabric、Traefik、kGatewayと比較して：
- **Gateway API標準への忠実さ**：仕様との乖離が最小
- **OIDC連携**：外部認証との統合がシンプル
- **CNCFグレード**：プロジェクトガバナンスが安定
- **L7制御の表現力**：複雑なルーティングも対応

## 移行手順

### 1. 既存依存の可視化

```bash
# 使用中のannotationを全て列挙
kubectl get ingress -A -o yaml | grep "nginx.ingress.kubernetes.io"
```

これにより移行先に求める要件を網羅的に洗い出す。

### 2. 移行先の要件確認

よく使われるannotationの対応表（ingress2gateway CLIでも変換可能）：

| NGINX annotation | Gateway API相当 |
|------|------|
| `nginx.ingress.kubernetes.io/auth-url` | `SecurityPolicy`（OIDC） |
| `nginx.ingress.kubernetes.io/rewrite-target` | `HTTPRoute`のフィルター |
| `nginx.ingress.kubernetes.io/proxy-body-size` | `BackendPolicy` |

### 3. Envoy Gatewayのインストール

```bash
helm install eg oci://docker.io/envoyproxy/gateway-helm \
  --version v1.0.0 -n envoy-gateway-system --create-namespace
```

### 4. リソース作成

```yaml
# GatewayClass（Envoy Gateway実装を指定）
apiVersion: gateway.networking.k8s.io/v1
kind: GatewayClass
metadata:
  name: eg
spec:
  controllerName: gateway.envoyproxy.io/gatewayclass-controller
---
# Gateway（エントリポイント）
apiVersion: gateway.networking.k8s.io/v1
kind: Gateway
metadata:
  name: eg
  namespace: default
spec:
  gatewayClassName: eg
  listeners:
  - name: http
    port: 80
    protocol: HTTP
---
# HTTPRoute（ルーティング定義）
apiVersion: gateway.networking.k8s.io/v1
kind: HTTPRoute
metadata:
  name: myapp
spec:
  parentRefs:
  - name: eg
  rules:
  - matches:
    - path:
        type: PathPrefix
        value: /api
    backendRefs:
    - name: myapp-service
      port: 8080
```

### 5. 段階的切り替え戦略

ALBのリスナールールで新旧を共存させ段階移行：

```
優先ルール: ?debug=true → Envoy Gateway（検証用）
既定ルール: → ingress-nginx（既存）
```

検証OKになったら既定ルールをEnvoy Gatewayに切り替える。

## 移行ツール

**ingress2gateway 1.0**（2026年3月リリース）：
```bash
# IngressリソースをGateway APIリソースに自動変換
ingress2gateway print --namespace default
```

30以上のcommon annotationに対応（CORS、バックエンドTLS、正規表現マッチング等）。

## 注意事項

- **annotationの単純置き換えは不十分**：責務を「ルーティング・認証・ポリシー」に分解し直す設計が必要
- **認証要件が最も複雑**：OIDC連携先（Cognito等）との設計を先に整理する
- **テスト環境での先行検証**：本番切り替え前に十分な検証期間を設ける

## 関連ページ

- [[wiki/platform-engineering]] — Platform Engineering文脈でのネットワーク標準化
- [[wiki/aws-frontier-agents]] — インフラ自動化のAIエージェント活用
