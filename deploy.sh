docker build -t nguyenvohoangduy/multi-client:latest -t nguyenvohoangduy/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t nguyenvohoangduy/multi-server:latest -t nguyenvohoangduy/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t nguyenvohoangduy/multi-worker:latest -t nguyenvohoangduy/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push nguyenvohoangduy/multi-client:latest
docker push nguyenvohoangduy/multi-server:latest
docker push nguyenvohoangduy/multi-worker:latest

docker push nguyenvohoangduy/multi-client:$SHA
docker push nguyenvohoangduy/multi-server:$SHA
docker push nguyenvohoangduy/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=nguyenvohoangduy/multi-server:$SHA
kubectl set image deployments/client-deployment client=nguyenvohoangduy/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=nguyenvohoangduy/multi-worker:$SHA