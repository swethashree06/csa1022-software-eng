# Experiment 17 – Push and Pull Docker Images Using Docker Hub

**Tools:** Docker Hub, Docker CLI  **CO:** CO3

## Steps
| # | Task | Command |
|---|---|---|
| 1 | Image for static site | `docker build -t static-web:latest .` |
| 2 | Tag | `docker tag static-web:latest <user>/static-web:1.0` |
| 3 | Login | `docker login` (use an access token: Docker Hub → Account Settings → Security) |
| 4 | Push | `docker push <user>/static-web:1.0` |
| 5 | Verify | Docker Hub → Repositories → `static-web` → Tags |
| 6 | Pull on another machine | `docker pull <user>/static-web:1.0` |
| 7 | Run | `docker run -d -p 8080:80 <user>/static-web:1.0` → http://localhost:8080 |
| 8 | Clean up | `docker rm -f <container>` · `docker rmi <user>/static-web:1.0` |

Screenshots to submit: each command's output, Docker Hub tag page, browser on the second machine.

Helper: `commands.sh` (`export DOCKERHUB_USER=...`).
