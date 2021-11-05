docker build -t racheleyg12/multi-client:lastest -t racheleyg12/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t racheleyg12/multi-server:lastest -t racheleyg12/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t racheleyg12/multi-worker:lastest -t racheleyg12/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push racheleyg12/multi-client:lastest
docker push racheleyg12/multi-server:lastest
docker push racheleyg12/multi-worker:lastest

docker push racheleyg12/multi-client:$SHA
docker push racheleyg12/multi-server:$SHA
docker push racheleyg12/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=racheleyg12/multi-server:$SHA
kubectl set image deployments/client-deployment client=racheleyg12/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=racheleyg12/multi-worker:$SHA