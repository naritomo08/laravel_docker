FROM node:22-bookworm-slim AS frontend-builder

WORKDIR /work/backend

COPY ./backend/package*.json ./
RUN npm ci --no-audit --no-fund

COPY ./backend ./
RUN npm run prod

FROM nginx:stable-alpine
LABEL maintainer="ucan-lab <yes@u-can.pro>"
SHELL ["/bin/ash", "-oeux", "pipefail", "-c"]

ENV TZ=Asia/Tokyo

RUN apk add --no-cache tzdata && \
  ln -snf /usr/share/zoneinfo/${TZ} /etc/localtime && \
  echo ${TZ} > /etc/timezone

# nginx の設定ファイルをコピー
COPY ./infra/docker/nginx/default.conf /etc/nginx/templates/default.conf.template
COPY ./infra/docker/nginx/nginx.conf /etc/nginx/nginx.conf

COPY --chown=www-data:www-data ./backend /work/backend
COPY --from=frontend-builder --chown=www-data:www-data /work/backend/public/build /work/backend/public/build

WORKDIR /work/backend

RUN rm -f public/storage && \
  ln -s ../storage/app/public public/storage
