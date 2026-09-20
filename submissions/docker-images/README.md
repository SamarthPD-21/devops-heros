# Dockerfiles & Images — Multi-Stage Build Homework

## Task 1 — Run a multi-stage Dockerfile

**What "multi-stage" means:** one `Dockerfile` with several `FROM` stages. The first stage
(`builder`) has all the build tooling and dev dependencies; the final stage (`runner`) starts from a
clean base and copies **only the artifacts it needs** with `COPY --from=builder`. Build tools never
ship in the final image, so it stays small and has a smaller attack surface.

### The repository

[`multi-stage-app/`](multi-stage-app/) is a small Node.js/Express app whose page says
**"Hello World from Docker multi-stage build"**.

```dockerfile
# Stage 1 — builder
FROM node:20-alpine AS builder
WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . .

# Stage 2 — runner (only production deps + app code)
FROM node:20-alpine AS runner
WORKDIR /app
ENV NODE_ENV=production
COPY --from=builder /app/package*.json ./
RUN npm install --omit=dev
COPY --from=builder /app/server.js ./
EXPOSE 8080
CMD ["node", "server.js"]
```

### Steps performed

```bash
# 1) clone the repository
git clone <repo-url> /tmp/opencode/clone-multistage

# 2) build the multi-stage image
docker build -t hw-multistage /tmp/opencode/clone-multistage

# 3) run a container, mapping host 8080 -> container 8080
docker run -d --name hw-multistage -p 8080:8080 hw-multistage

# 4) & 5) verify
docker ps                                   # running on 0.0.0.0:8080->8080/tcp
curl -s http://127.0.0.1:8080/              # Hello World from Docker multi-stage build
```

### Evidence

The build log clearly shows the two stages — `[builder n/5]` and `[runner n/5]`:

![clone, multi-stage build, run on 8080](screenshots/multistage-build-run.png)

The application as seen in the browser on port 8080:

![Multi-stage app webpage](screenshots/multistage-webpage.png)

`docker ps` confirms the container is up with `0.0.0.0:8080->8080/tcp`, and `curl` on port **8080**
prints **Hello World from Docker multi-stage build**.

---

## Task 2 — Documentation

The required Markdown file is **[`SUBMISSION.md`](SUBMISSION.md)** (name, enrollment number, the two
screenshots above).

---

## Task 3 — Deploy at least 3 different application types

**Node.js**, **Python** and **Java** were each built into an image and run as a container
(the same apps as in the [Docker Hello World](../docker-fundamentals/) task):

| App | Image | Host port | Response |
|---|---|---|---|
| Node.js | `hw-nodejs` | 3001 | Hello World from Node.js |
| Python | `hw-python` | 5001 | Hello World from Python |
| Java | `hw-java` | 8081 | Hello World from Java |

![3 app types deployed](screenshots/three-apps-deployed.png)

Script: [`show-three-apps.sh`](show-three-apps.sh) · [`show-multistage.sh`](show-multistage.sh)
