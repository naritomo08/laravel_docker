FROM php:7.3.28-apache

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
RUN pecl install xdebug && docker-php-ext-enable xdebug

RUN adduser --disabled-password --gecos '' trick \
    && adduser trick sudo \
    && adduser trick www-data \
    && echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

RUN sed -ri -e 's!/var/www/html!/home/trick/project/public!g' /etc/apache2/sites-available/*.conf \
    && sed -ri -e 's!/var/www/!/home/trick/project/public!g' /etc/apache2/apache2.conf /etc/apache2/conf-available/*.conf

RUN a2enmod rewrite headers

COPY ./infra/docker/php/php.ini-xdebug "$PHP_INI_DIR/php.ini-xdebug"
RUN cat "$PHP_INI_DIR/php.ini-development" "$PHP_INI_DIR/php.ini-xdebug" > "$PHP_INI_DIR/php.ini"

COPY --from=composer:2.0.13 /usr/bin/composer /usr/bin/composer

WORKDIR /home/trick

COPY ./infra/docker/boot.sh ./
RUN chown -R trick:trick ./ && chmod +x boot.sh

USER trick

EXPOSE 80
ENTRYPOINT ["./boot.sh"]
