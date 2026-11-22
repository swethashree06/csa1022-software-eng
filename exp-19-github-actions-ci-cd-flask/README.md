# Experiment 19 – CI/CD Pipeline with GitHub Actions (Flask + Docker)

**Tools:** GitHub Actions, Docker  **CO:** CO3

## Workflow: `.github/workflows/exp19-ci-cd-flask.yml`
| Job | What it does |
|---|---|
| `test` | Install deps, run `pytest` (runs on every PR and push) |
| `docker` | Build the image with Buildx; **push to Docker Hub** when `DOCKERHUB_*` secrets exist |
| `deploy-heroku` | Build/release the container on Heroku and smoke-test `/health` (on `main` when `HEROKU_APP_NAME` is set) |

## Setup
1. Create the repo and push (`app.py`, `Dockerfile`, tests are in this folder).
2. *Settings → Secrets and variables → Actions*:
   * Secrets: `DOCKERHUB_USERNAME`, `DOCKERHUB_TOKEN` (Docker Hub access token), `HEROKU_API_KEY` (`heroku authorizations:create`)
   * Variable: `HEROKU_APP_NAME` (create the app first: `heroku create <name> --stack container`)
3. Push to `main`; open *Actions* → the three jobs run in order.
4. Deployment link: `https://<HEROKU_APP_NAME>.herokuapp.com/` (AWS alternative: push the image to ECR and update an ECS service with `aws-actions/amazon-ecs-deploy-task-definition`).

Submit the workflow file and the deployment link. Without secrets the pipeline still tests and builds, so it is safe on a fork.

## Local check
```bash
pip install -r requirements.txt pytest && pytest -q && docker build -t flask-cicd .
```
