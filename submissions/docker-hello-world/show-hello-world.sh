#!/usr/bin/env bash
# Shows the built Hello World images, the running containers and a live check
# of every page's response.
set -u
hline() { printf '=%.0s' {1..78}; echo; }

hline; echo "BUILT IMAGES"; hline
docker images --format 'table {{.Repository}}\t{{.Tag}}\t{{.Size}}' | grep -E 'REPOSITORY|^hw-'

echo
hline; echo "RUNNING CONTAINERS"; hline
docker ps --format 'table {{.Names}}\t{{.Image}}\t{{.Ports}}\t{{.Status}}' | grep -E 'NAMES|^hw-'

echo
hline; echo "HTTP CHECK (curl)"; hline
declare -A P=( [nodejs]=3001 [python]=5001 [java]=8081 [apache]=8082 [react]=8083 [nginx]=8084 )
for name in nodejs python java apache react nginx; do
  port=${P[$name]}
  body=$(curl -s --max-time 8 "http://127.0.0.1:$port/")
  title=$(printf '%s' "$body" | grep -io 'Hello World from [A-Za-z.]*' | head -1)
  printf 'localhost:%-5s -> %s\n' "$port" "${title:-<client-side rendered>}"
done

echo
echo "### DOCKER-HW-DONE ###"
