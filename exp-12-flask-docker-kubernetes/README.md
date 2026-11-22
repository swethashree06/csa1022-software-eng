# Experiment 12 – Flask API → Docker → Docker Hub → Kubernetes

**Tools:** Docker & Kubernetes  **CO:** CO3

## Files
`app.py` (API: `/`, `/health`, `GET/POST /items`) · `test_app.py` · `Dockerfile` · `k8s/deployment.yaml` · `k8s/service.yaml`

## Procedure
```bash
# 1. run & test locally
pip install -r requirements.txt pytest && pytest -q && python app.py

# 2-3. containerise and build
docker build -t YOUR_DOCKERHUB_USER/flask-api:1.0 .
docker run --rm -p 5000:5000 YOUR_DOCKERHUB_USER/flask-api:1.0     # curl localhost:5000/health

# 4. push to Docker Hub
docker login
docker push YOUR_DOCKERHUB_USER/flask-api:1.0

# 5-6. deploy (Minikube / Docker Desktop / kind)
sed -i 's/YOUR_DOCKERHUB_USER/<your-user>/' k8s/deployment.yaml
kubectl apply -f k8s/
kubectl get deployments,pods,svc
curl http://$(minikube ip):30080/          # Minikube
# Docker Desktop: curl http://localhost:30080/   ·   kind: kubectl port-forward svc/flask-api-service 30080:5000
curl -X POST -H 'Content-Type: application/json' -d '{"name":"ruler"}' http://<node-ip>:30080/items

# clean up
kubectl delete -f k8s/
```

## Expected output
`{"message":"Hello from Flask on Kubernetes!","pod":"flask-api-xxxxx"}` – the `pod` value changes between requests (load balancing across 2 replicas).
