# Experiment 11 – Containerise, Build and Serve a Static Website with Docker

**Tool:** Docker  **CO:** CO3

## Files
* `index.html` – the static page
* `Dockerfile` – `nginx:alpine` serving it

## Procedure
```bash
cd exp-11-docker-static-website
docker build -t static-site:1.0 .            # 3. build the image
docker images static-site                    #    verify
docker run -d --name static-site -p 8080:80 static-site:1.0   # 4. run the container
docker ps                                    #    container is Up
curl -s http://localhost:8080 | head         # 5. or open http://localhost:8080 in a browser
docker logs static-site                      #    see the access log line
docker stop static-site && docker rm static-site
```

## Expected output
Browser shows **“Hello from Docker + Nginx 🐳”**.

## Viva points
Image vs container, layers, `EXPOSE` vs `-p`, why Nginx (production-grade static server), `-d` detached mode.
