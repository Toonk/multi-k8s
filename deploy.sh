docker build -t toonk/multi-client:latest -t toonk/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t toonk/multi-server:latest -t toonk/multi-server:$SHA -f ./server/Dockerfile ./server
docker duild -t toonk/multi-worker:latest -t toonk/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push toonk/multi-client:latest
docker push toonk/multi-server:latest
docker push toonk/multi-worker:latest

docker push toonk/multi-client:$SHA
docker push toonk/multi-server:$SHA
docker push toonk/multi-worker:$SHA

kubectl apply -f k8s

kubectl set image deployments/client-deployment client=toonk/multi-client:$SHA
kubectl set image deployments/server-deployment server=toonk/multi-server:$SHA
kubectl set image deployments/worker-deployment worker=toonk/multi-worker:$SHA
