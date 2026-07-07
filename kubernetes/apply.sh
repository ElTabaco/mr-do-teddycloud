#!/bin/bash
# Apply mr-do-teddycloud via its ArgoCD Application. ArgoCD will reconcile
# to the Git state automatically. Run from anywhere — the script self-locates.
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "$SCRIPT_DIR/../.." && pwd)"

kubectl apply -f "$REPO_ROOT/kubernetes/app.yaml"

# ── Verification (non-fatal) ──
echo ""
echo "=== Pods ==="
kubectl get pods -n mr-do-teddycloud -o wide || true

echo ""
echo "=== Service ==="
kubectl get svc -n mr-do-teddycloud || true

echo ""
echo "=== Ingress (if any) ==="
kubectl get ingress -n mr-do-teddycloud || true

echo ""
echo "=== PVC ==="
kubectl describe pvc mr-do-teddycloud-pvc-data -n mr-do-teddycloud || true

echo ""
echo "=== PV ==="
kubectl describe pv mr-do-teddycloud-pv-data || true

echo ""
echo "=== ArgoCD Application ==="
kubectl get application mr-do-teddycloud -n argocd || true
