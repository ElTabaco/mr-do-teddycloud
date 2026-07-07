#!/bin/bash
# Delete mr-do-teddycloud resources (Deployment, Service, Ingress, PVC, ArgoCD Application).
# PV has Retain policy — your data on NFS is safe; delete manually if needed.
set -euo pipefail

echo "WARNING: This will DELETE mr-do-teddycloud resources in namespace mr-do-teddycloud"
echo "         (Deployment, Service, Ingress, PVC, ArgoCD Application)"
echo ""
echo "         NOTE: PV reclaim policy is 'Retain' — your data on NFS is safe."
echo ""
read -r -p "Type 'yes' to confirm deletion: " CONFIRM

if [ "$CONFIRM" != "yes" ]; then
    echo "Aborted."
    exit 1
fi

echo "Deleting ArgoCD Application..."
kubectl patch application mr-do-teddycloud -n argocd --type=merge -p '{"operation": null}' || true
kubectl patch application mr-do-teddycloud -n argocd --type=merge -p '{"metadata":{"finalizers":[]}}' || true
kubectl delete application mr-do-teddycloud -n argocd --ignore-not-found || true

echo "Deleting Deployment, Service, and Ingress..."
kubectl delete deployment mr-do-teddycloud -n mr-do-teddycloud --ignore-not-found || true
kubectl delete service mr-do-teddycloud-service -n mr-do-teddycloud --ignore-not-found || true
kubectl delete ingress -n mr-do-teddycloud --all --ignore-not-found || true

echo "Deleting PVC (PV has Retain policy, will survive)..."
kubectl delete pvc mr-do-teddycloud-pvc-data -n mr-do-teddycloud --ignore-not-found || true

echo ""
echo "To delete the PV too, run manually:"
echo "  kubectl delete pv mr-do-teddycloud-pv-data"

echo "Done."
