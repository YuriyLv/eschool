FROM node:8.11.2-alpine as build
WORKDIR /usr/src/app
COPY package*.json ./
RUN npm i
COPY . .
ARG base_url
RUN sed -i 's|http://localhost:8080|'${base_url}'|g' /usr/src/app/src/app/services/token-interceptor.service.ts

RUN npm run build

FROM nginx:1.17.1-alpine
WORKDIR /usr/share/nginx/html
COPY --from=build /usr/src/app/dist/eSchool .