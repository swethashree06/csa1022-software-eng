# Experiment 18 – Multi-Container Application on Kubernetes

**Tools:** Docker, Kubernetes  **CO:** CO3

## Architecture
```
Browser ──▶ frontend (Nginx, NodePort 30090) ──/api──▶ backend (Flask, ClusterIP) ──▶ database (PostgreSQL + PVC)
```

## Files
`frontend/` · `backend/` · `docker-compose.yml` (local) · `k8s/` (Secret, DB Deployment+PVC+Service, backend, frontend+HPA)

## Procedure
```bash
# 0. optional: run locally
docker compose up --build            # http://localhost:8080

# 1. build & push images
docker build -t YOUR_DOCKERHUB_USER/guestbook-backend:1.0  backend  && docker push YOUR_DOCKERHUB_USER/guestbook-backend:1.0
docker build -t YOUR_DOCKERHUB_USER/guestbook-frontend:1.0 frontend && docker push YOUR_DOCKERHUB_USER/guestbook-frontend:1.0
sed -i 's/YOUR_DOCKERHUB_USER/<your-user>/' k8s/*.yaml

# 2. deploy
kubectl apply -f k8s/
kubectl get pods,svc,pvc -w           # 3. monitor until all Running/Ready
kubectl logs deploy/backend
minikube service frontend --url       # open the app (Docker Desktop: http://localhost:30090)

# 4. scale the frontend
kubectl scale deployment frontend --replicas=5
kubectl get pods -l app=frontend
kubectl top pods                      # needs metrics-server (minikube addons enable metrics-server)

# 5. dashboard
minikube dashboard                    # screenshot workloads, pods, services

kubectl delete -f k8s/                # clean up
```

Submit: the YAML files in `k8s/` and screenshots of the Kubernetes dashboard / `kubectl get` output.
