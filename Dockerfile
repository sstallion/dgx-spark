FROM node:lts-alpine AS build

WORKDIR /app

RUN apk add --no-cache git
RUN corepack enable
RUN corepack prepare pnpm@latest-10 --activate

RUN git clone https://github.com/sstallion/spark-home.git /app
RUN pnpm install
RUN pnpm build

FROM caddy:2-alpine

RUN apk add --no-cache gettext

COPY --from=build /app/dist /srv/
RUN rm -rf /srv/assets/*.dist

COPY ./Caddyfile ./cert.pem ./key.pem /etc/caddy/
COPY ./public /srv/
COPY ./run.sh /

ENTRYPOINT ["/run.sh"]
CMD ["caddy", "run", "--config", "/etc/caddy/Caddyfile", "--adapter", "caddyfile"]
