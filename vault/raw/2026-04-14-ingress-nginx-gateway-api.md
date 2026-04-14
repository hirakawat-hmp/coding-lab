# Ingress NGINX → Gateway API + Envoy Gateway移行 — Raw Source

Source: https://zenn.dev/mitene/articles/202604-ingress-nginx-to-envoy-gateway
Fetched: 2026-04-14
Feed: Zenn Trending

## 移行の背景

Kubernetesのingress-nginxは2026年3月にretirementを迎え、すでに公開アーカイブされている。みてねは内部向けルーティングでこれを活用していたため、移行が必要になった。

## 実施した手順

1. **既存要件の整理**：利用中のannotationを一覧化して移行先に求める要件を洗い出した
   ```bash
   kubectl get ingress -A -o yaml | grep "nginx.ingress.kubernetes.io"
   ```

2. **移行先の選定**：Gateway APIへの移行を選択した理由：
   - 中長期の拡張性を重視
   - 認証やポリシーを明示的に管理できる
   - 将来的なさらなる移行を避けられる

3. **Envoy Gatewayの採択**：NGINX Gateway FabricやTraefikと比較し優位：
   - Gateway APIへの素直さ
   - OIDC連携による認証構成の単純化
   - L7制御の表現力

## 実装上の課題

**annotationの単純な置き換えは不十分**：ルーティング、認証、ポリシーに責務を分解し、各リソースへ配置する必要があった。

## 切り替え戦略

新旧経路を共存させ、ALBのリスナールールで段階的に移行：
- 優先ルール：`debug=true`クエリ → Envoy Gateway
- 既定ルール：→ ingress-nginx

この方式により検証と切り戻しが容易になった。
