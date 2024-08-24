FROM node:16-alpine AS builder

WORKDIR /usr/src/taumc_website

COPY package*.json ./
RUN npm install

COPY . .

ENV ELEVENTY_ENV=production
ENV BASE_URL="https://www.taumc.org/"

RUN npm run build

FROM nginx:alpine

COPY --from=builder /usr/src/taumc_website/_site /usr/share/nginx/html

EXPOSE 80
