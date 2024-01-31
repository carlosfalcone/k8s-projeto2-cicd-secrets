echo "Realizando os deployments..."
kubectl apply -f ./load-balancer.yml --record
kubectl apply -f ./secrets.yml

echo "Verificaçao da url gerada pelo serviço"
minikube service app1-service --url