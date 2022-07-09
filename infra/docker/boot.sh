#!/bin/sh

cd project

[ ! -d "node_modules" ] && npm install
[ ! -d "vendor" ] && composer install

grep -q '^APP_KEY=$' .env && php artisan key:generate

php artisan migrate
php artisan config:cache

sudo apache2ctl -D FOREGROUND
