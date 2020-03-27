docker build -t afiqon/multi-client:latest -t afiqon/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t afiqon/multi-server:latest -t afiqon/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t afiqon/multi-worker:latest -t afiqon/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push afiqon/multi-client:latest
docker push afiqon/multi-server:latest
docker push afiqon/multi-worker:latest

docker push afiqon/multi-client:$SHA
docker push afiqon/multi-server:$SHA
docker push afiqon/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=afiqon/multi-server:$SHA
kubectl set image deployments/client-deployment client=afiqon/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=afiqon/multi-worker:$SHA