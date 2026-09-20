FROM node:20-alpine AS build
WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . .
RUN npm run build

FROM nginx:alpine
COPY --from=build /app/dist/bundle.js /usr/share/nginx/html/bundle.js
COPY public/index.html /usr/share/nginx/html/index.html
EXPOSE 80
