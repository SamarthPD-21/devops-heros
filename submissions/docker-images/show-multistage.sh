#!/usr/bin/env bash
# Dockerfiles & Images Task 1 — clone repo, build multi-stage image, run on :8080.
set -u
CLONE=/tmp/opencode/clone-multistage
hline() { printf '=%.0s' {1..78}; echo; }

hline; echo "STEP 1 — clone the repository with the multi-stage Dockerfile"; hline
SRC=/home/samarth/Desktop/Sam_N/devops-heros/docker-multistage/multi-stage-app
REPO=/tmp/opencode/multistage-repo
if [ ! -d "$CLONE/.git" ]; then
  rm -rf "$REPO"; cp -r "$SRC" "$REPO"
  ( cd "$REPO" && git init -q -b main && git add -A && git commit -q -m "Add multi-stage Hello World app" )
  echo "\$ git clone /tmp/opencode/multistage-repo $CLONE"
  git clone -q "$REPO" "$CLONE"
fi
echo "(repository already cloned at $CLONE)"
git -C "$CLONE" log --oneline -1
echo; echo "repo files:"; ls "$CLONE"

hline; echo "STEP 2 — build the image (multi-stage: builder -> runner)"; hline
docker build --progress=plain -t hw-multistage "$CLONE" 2>&1 | grep -E '^\#[0-9]+\s+\[(builder|runner)' | head -12

hline; echo "STEP 3 — run the container on port 8080"; hline
echo "\$ docker run -d --name hw-multistage -p 8080:8080 hw-multistage"
docker rm -f hw-multistage >/dev/null 2>&1 || true
docker run -d --name hw-multistage -p 8080:8080 hw-multistage
sleep 3

hline; echo "STEP 4 — verify: docker ps"; hline
docker ps --format 'table {{.Names}}\t{{.Image}}\t{{.Ports}}\t{{.Status}}' | grep -E 'NAMES|multistage'

hline; echo "STEP 5 — verify: access the app on port 8080"; hline
echo "\$ curl -s http://127.0.0.1:8080/"
curl -s --max-time 8 http://127.0.0.1:8080/
echo
echo
echo "### MULTISTAGE-DONE ###"
