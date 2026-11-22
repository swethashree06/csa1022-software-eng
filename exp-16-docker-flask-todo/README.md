# Experiment 16 – Containerise a Flask To-Do Application with Docker

**Tools:** Docker, Flask  **CO:** CO3

## Files
`app.py` (UI at `/`, REST API `/todos`) · `test_app.py` · `Dockerfile` · `requirements.txt`

## Procedure
```bash
pip install -r requirements.txt pytest && pytest -q            # unit tests (host)
docker build -t YOUR_DOCKERHUB_USER/todo-app:1.0 .             # build
docker run -d --name todo -p 5000:5000 YOUR_DOCKERHUB_USER/todo-app:1.0   # run locally

# test inside the container
curl -s -X POST -H 'Content-Type: application/json' -d '{"title":"Learn Docker"}' localhost:5000/todos
curl -s localhost:5000/todos
curl -s -X PUT  -H 'Content-Type: application/json' -d '{"toggle":true}' localhost:5000/todos/1
curl -s -X DELETE -o /dev/null -w '%{http_code}\n' localhost:5000/todos/1      # 204
docker exec todo python -c "import flask;print(flask.__version__)"
docker logs todo

docker login && docker push YOUR_DOCKERHUB_USER/todo-app:1.0   # push
```
Open http://localhost:5000 for the web UI.

## Submission
Dockerfile + screenshots of: `docker run`, curl test outputs, the repository on Docker Hub.

Note: data is stored in memory, so it is lost when the container restarts (a volume/database is the natural next step).
