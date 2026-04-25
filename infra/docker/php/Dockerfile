FROM php:8.2-fpm-bullseye
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

COPY --from=composer:2.2 /usr/bin/composer /usr/bin/composer

RUN apt-get update && \
  savedAptMark="$(apt-mark showmanual)" && \
  apt-get -y install --no-install-recommends git libicu-dev libonig-dev libpq-dev libzip-dev unzip locales && \  
  locale-gen en_US.UTF-8 && \
  localedef -f UTF-8 -i en_US en_US.UTF-8 && \
  mkdir /var/run/php-fpm && \
  docker-php-ext-install intl pdo_pgsql zip bcmath && \
  pecl install redis-5.3.4 && \
  docker-php-ext-enable redis && \
  runDeps="$( \
    find /usr/local -type f -executable -exec ldd '{}' ';' \
      | awk '/=>/ { print $(NF-1) }' \
      | sort -u \
      | xargs -r dpkg-query --search \
      | cut -d: -f1 \
      | sort -u \
  )" && \
  apt-mark auto '.*' > /dev/null && \
  apt-mark manual ${savedAptMark} git unzip locales ${runDeps} && \
  apt-get purge -y --auto-remove -o APT::AutoRemove::RecommendsImportant=false && \
  apt-get clean && \
  rm -rf /var/lib/apt/lists/* /tmp/pear ~/.pearrc && \
  composer config -g process-timeout 3600 && \
  composer config -g repos.packagist composer https://packagist.org

COPY ./infra/docker/php/php-fpm.d/zzz-www.conf /usr/local/etc/php-fpm.d/zzz-www.conf
COPY ./infra/docker/php/php.ini /usr/local/etc/php/php.ini

# ECRへアップするための設定追加
COPY --chown=www-data:www-data ./backend /work/backend

WORKDIR /work/backend

# Laravel の依存関係をインストール
RUN composer install --optimize-autoloader && \
  composer clear-cache
