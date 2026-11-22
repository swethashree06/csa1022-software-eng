# Experiment 13 – CI/CD with Jenkins for a Containerised Application

**Tool:** Docker (+ Jenkins)  **CO:** CO4

## Pipeline
`Checkout → Test (pytest) → Build Docker image → Push to Docker Hub → Deploy to Kubernetes (cloud)`

## Files
`Jenkinsfile` · `app/` (Flask app, tests, **Dockerfile**) · `k8s/deployment.yaml` · `docker-compose.jenkins.yml`

## Procedure
1. **Set up Jenkins** – `docker compose -f docker-compose.jenkins.yml up -d`, open http://localhost:8081, unlock with
   `docker exec <container> cat /var/jenkins_home/secrets/initialAdminPassword`, install suggested plugins + *Docker Pipeline*, *Git*, *GitHub*.
   In the Jenkins container install `docker` CLI, `python3-venv` and `kubectl` (or use an agent that has them).
2. **Dockerfile** – see `app/Dockerfile`.
3. **Jenkinsfile** – at repo root path used by the job (*Script Path* = `exp-13-jenkins-ci-cd/Jenkinsfile`).
4. **Credentials** – *Manage Jenkins → Credentials*: `dockerhub-creds` (username/password), `kubeconfig` (secret file for AWS EKS / GKE / AKS).
5. **Create job** – *New Item → Multibranch Pipeline* (or Pipeline) → Git repo URL → *Script Path* above.
6. **Trigger on commits / PRs**
   * GitHub repo → *Settings → Webhooks → Add* `http://<jenkins-host>:8081/github-webhook/` (content type `application/json`, events: *push*, *pull requests*).
   * Jenkins job → *Build Triggers → GitHub hook trigger for GITScm polling* (the `triggers { githubPush() }` line in the Jenkinsfile does this).
   * No public Jenkins? use `ngrok http 8081` or *Poll SCM* `H/2 * * * *`.
7. Push a commit and watch the stage view turn green. Screenshot stages + the webhook delivery.

## Local test without Jenkins
```bash
cd app && pip install -r requirements.txt pytest && pytest -q && docker build -t jenkins-demo .
```
