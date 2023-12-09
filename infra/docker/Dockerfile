FROM php:8.1.3-apache

RUN apt-get update \
    && apt-get install --no-install-recommends -y \
        curl \
        libpng-dev \
        libzip-dev \
        npm \
        locales \
        sudo \
        unzip \
        vim \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* \
    && echo "ja_JP.UTF-8 UTF-8" >/etc/locale.gen \
    && locale-gen

RUN docker-php-ext-install bcmath gd mysqli pdo pdo_mysql zip
RUN pecl install xdebug && docker-php-ext-enable xdebug && pecl install redis-5.3.4 && \
    docker-php-ext-enable redis

RUN adduser --disabled-password --gecos '' laravel \
    && adduser laravel sudo \
    && adduser laravel www-data \
    && echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

RUN sed -ri -e 's!/var/www/html!/home/laravel/project/public!g' /etc/apache2/sites-available/*.conf \
    && sed -ri -e 's!/var/www/!/home/laravel/project/public!g' /etc/apache2/apache2.conf /etc/apache2/conf-available/*.conf

RUN a2enmod rewrite headers

COPY ./infra/docker/php/php.ini-xdebug "$PHP_INI_DIR/php.ini-xdebug"
RUN cat "$PHP_INI_DIR/php.ini-development" "$PHP_INI_DIR/php.ini-xdebug" > "$PHP_INI_DIR/php.ini"

COPY --from=composer:2.0.13 /usr/bin/composer /usr/bin/composer

WORKDIR /home/laravel

COPY ./infra/docker/boot.sh ./
RUN chown -R laravel:laravel ./ && chmod +x boot.sh

RUN sudo npm install -g n
RUN sudo n stable

USER laravel

EXPOSE 80
ENTRYPOINT ["./boot.sh"]
