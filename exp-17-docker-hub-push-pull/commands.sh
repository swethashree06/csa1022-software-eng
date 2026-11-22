#!/usr/bin/env bash
# Replace DOCKERHUB_USER, then run step by step (not meant to be run blindly end-to-end on one machine).
set -euo pipefail
DOCKERHUB_USER="${DOCKERHUB_USER:?export DOCKERHUB_USER=<your docker hub username>}"
IMAGE=static-web

# --- Machine A: build, tag, push ---
docker build -t $IMAGE:latest .
docker tag $IMAGE:latest "$DOCKERHUB_USER/$IMAGE:1.0"
docker tag $IMAGE:latest "$DOCKERHUB_USER/$IMAGE:latest"
docker login
docker push "$DOCKERHUB_USER/$IMAGE:1.0"
docker push "$DOCKERHUB_USER/$IMAGE:latest"

# --- Machine B (another machine): pull and run ---
# docker pull $DOCKERHUB_USER/$IMAGE:1.0
# docker run -d -p 8080:80 --name web $DOCKERHUB_USER/$IMAGE:1.0
# curl localhost:8080
