# -----------------------------------------------------------------
# Stage 1 — "builder": install ALL deps and prepare the app
# -----------------------------------------------------------------
FROM node:20-alpine AS builder
WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . .

# -----------------------------------------------------------------
# Stage 2 — "runner": only the production deps + the app code.
# The build tooling / dev deps from stage 1 are thrown away, so the
# final image stays small.
# -----------------------------------------------------------------
FROM node:20-alpine AS runner
WORKDIR /app
ENV NODE_ENV=production
COPY --from=builder /app/package*.json ./
RUN npm install --omit=dev
COPY --from=builder /app/server.js ./

EXPOSE 8080
CMD ["node", "server.js"]
