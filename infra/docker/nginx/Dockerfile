FROM nginx:1.20-alpine
LABEL maintainer="ucan-lab <yes@u-can.pro>"
SHELL ["/bin/ash", "-oeux", "pipefail", "-c"]

ENV TZ=UTC

# 必要なライブラリをインストール
RUN apk update && \
  apk add --no-cache libstdc++ libc6-compat nodejs npm yarn

# nginx の設定ファイルをコピー
COPY ./infra/docker/nginx/default.conf /etc/nginx/templates/default.conf.template
COPY ./infra/docker/nginx/nginx.conf /etc/nginx/nginx.conf

# 公開ディレクトリをコピー
COPY --chown=www-data:www-data ./backend /work/backend

WORKDIR /work/backend

# フロントエンド依存関係を lockfile ベースで再現し、ビルド後にキャッシュを片付ける
RUN npm ci --no-audit --no-fund && \
    npm run prod && \
    npm cache clean --force
