FROM node:22-bookworm-slim AS frontend-builder

WORKDIR /work/backend

COPY ./backend/package*.json ./
RUN npm ci --no-audit --no-fund

COPY ./backend ./
RUN npm run prod

FROM php:8.4-fpm-bookworm
LABEL maintainer="ucan-lab <yes@u-can.pro>"
SHELL ["/bin/bash", "-oeux", "pipefail", "-c"]

# timezone environment
ENV TZ=UTC \
  # locale
  LANG=en_US.UTF-8 \
  LANGUAGE=en_US:en \
  LC_ALL=en_US.UTF-8 \
  # composer environment
  COMPOSER_ALLOW_SUPERUSER=1 \
  COMPOSER_HOME=/composer

COPY --from=composer:2 /usr/bin/composer /usr/bin/composer

RUN apt-get update && \
  savedAptMark="$(apt-mark showmanual)" && \
  apt-get -y install --no-install-recommends git libicu-dev libonig-dev libzip-dev unzip locales && \
  locale-gen en_US.UTF-8 && \
  localedef -f UTF-8 -i en_US en_US.UTF-8 && \
  mkdir /var/run/php-fpm && \
  docker-php-ext-install intl pdo_mysql zip bcmath && \
  pecl install redis && \
  docker-php-ext-enable redis && \
  runDeps="$( \
    find /usr/local -type f -executable -exec ldd '{}' ';' \
      | awk '/=>/ { print $(NF-1) }' \
      | sort -u \
      | xargs -r dpkg-query --search 2>/dev/null \
      | cut -d: -f1 \
      | sort -u || true \
  )" && \
  apt-mark auto '.*' > /dev/null && \
  apt-mark manual ${savedAptMark} git unzip locales libzip4 ${runDeps} && \
  apt-get purge -y --auto-remove -o APT::AutoRemove::RecommendsImportant=false && \
  apt-get clean && \
  rm -rf /var/lib/apt/lists/* /tmp/pear ~/.pearrc && \
  composer config -g process-timeout 3600 && \
  composer config -g repos.packagist composer https://packagist.org

COPY ./infra/docker/php/php-fpm.d/zzz-www.conf /usr/local/etc/php-fpm.d/zzz-www.conf
COPY ./infra/docker/php/php.ini /usr/local/etc/php/php.ini

COPY --chown=www-data:www-data ./backend /work/backend
COPY --from=frontend-builder --chown=www-data:www-data /work/backend/public/build /work/backend/public/build

WORKDIR /work/backend

RUN rm -f public/storage && \
  ln -s ../storage/app/public public/storage

# Laravel の依存関係をインストール
RUN composer install --optimize-autoloader && \
  composer clear-cache
