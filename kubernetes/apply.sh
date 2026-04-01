kubectl create namespace mr-do-teddycloud
kubectl apply -f mr-do-teddycloud-pv.yml
kubectl apply -f mr-do-teddycloud-pvc.yml
kubectl apply -f mr-do-teddycloud-service.yml
kubectl apply -f mr-do-teddycloud-deployment.yml
#kubectl apply -f mr-do-teddycloud-ingress.yml

kubectl describe pod mr-do-teddycloud -n mr-do-teddycloud
kubectl get pods -n mr-do-teddycloud -o wide
kubectl get pods --all-namespaces -o wide

#kubectl get ingress --all-namespaces -o wide
#kubectl describe ingress -n mr-do-teddycloud

kubectl get pv --all-namespaces -o wide
kubectl get pvc --all-namespaces -o wide
kubectl describe pv mr-do-teddycloud-pv-data -n mr-do-teddycloud
kubectl describe pvc mr-do-teddycloud-pvc-data -n mr-do-teddycloud

kubectl get configmap --all-namespaces -o wide

kubectl get svc --all-namespaces
kubectl get services  -n mr-do-teddycloud -o wide
kubectl describe services mr-do-teddycloud-service -n mr-do-teddycloud

kubectl get all -n mr-do-teddycloud

