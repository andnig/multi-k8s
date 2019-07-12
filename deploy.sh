docker build -t andnig/multi-client:latest -t andnig/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t andnig/multi-server:latest -t andnig/multi-server:$SHA -f ./client/Dockerfile ./server
docker build -t andnig/multi-worker:latest -t andnig/multi-worker:$SHA -f ./client/Dockerfile ./worker
docker push andnig/multi-client:latest
docker push andnig/multi-server:latest
docker push andnig/multi-worker:latest
docker push andnig/multi-client:$SHA
docker push andnig/multi-server:$SHA
docker push andnig/multi-worker:$SHA
kubectl apply -f k8s
# below line: the last section tells: container "server" should take image xxx
kubectl set image deployments/server-deployment server=andnig/multi-server:$SHA
kubectl set image deployments/client-deployment client=andnig/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=andnig/multi-worker:$SHA