# Experiment 14 – Continuous Deployment with GitHub Actions

**Tools:** GitHub Actions, Docker  **CO:** CO3

## Pipeline (`.github/workflows/exp14-continuous-deployment.yml`)
`push to main → test → build Docker image → push to GitHub Container Registry (ghcr.io) → deploy to Kubernetes`

## Procedure
1. Push this repo to GitHub (the Dockerised app is in `app/`).
2. The workflow authenticates to **GHCR** with the built-in `GITHUB_TOKEN` (no extra secret needed). To use Docker Hub instead replace the
   login step with `username: ${{ secrets.DOCKERHUB_USERNAME }}` / `password: ${{ secrets.DOCKERHUB_TOKEN }}`.
3. **Cloud deployment** (AWS EKS / Azure AKS / Google GKE / any cluster):
   * `base64 -w0 ~/.kube/config` → add as repository secret **`KUBE_CONFIG`**
   * add repository variable **`DEPLOY_ENABLED = true`** (*Settings → Secrets and variables → Actions → Variables*)
   * make the package public or add an image-pull secret
4. **Test the pipeline**: change the message in `app/app.py`, commit and push to `main` → *Actions* tab → watch *build-and-push* and *deploy*
   → `kubectl get svc cd-demo` → open the external IP and see the new message.

## Local check
```bash
cd app && pip install -r requirements.txt pytest && pytest -q && docker build -t cd-demo .
```
