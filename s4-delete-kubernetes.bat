echo "Deletando os servicos..."
kubectl delete service mysql-connection

echo "Deletando os deployments..."
kubectl delete deploy mysql
kubectl delete deploy app1

echo "Deletando os volumes..."
kubectl delete pvc local
kubectl delete pv local

echo "Verificacao"
kubectl get deploy
kubectl get pods
kubectl get services
kubectl get pv
kubectl get pvc