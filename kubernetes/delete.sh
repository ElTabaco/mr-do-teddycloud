kubectl get applications -n argocd
kubectl get applicationsets -n argocd

kubectl patch application mr-do-teddycloud -n argocd --type=merge -p '{"operation": null}' || true
kubectl patch application mr-do-teddycloud -n argocd --type=merge -p '{"metadata":{"finalizers":[]}}' || true
kubectl delete application mr-do-teddycloud -n argocd --ignore-not-found

kubectl delete all --all -n mr-do-teddycloud --wait=false || true
kubectl delete pvc --all -n mr-do-teddycloud --wait=false || true
kubectl delete pod --all -n mr-do-teddycloud --grace-period=0 --force --wait=false || true

kubectl delete ns mr-do-teddycloud --ignore-not-found --wait=false || true
kubectl patch namespace mr-do-teddycloud -p '{"spec":{"finalizers":[]}}' --type=merge || true
kubectl delete pv mr-do-teddycloud-pv-data
