#!/bin/sh

docker-compose exec -T php sh <<EOF
cd project

sudo find . -type f -exec chmod 664 {} \;
sudo find . -type d -exec chmod 775 {} \;

sudo chgrp -R www-data storage bootstrap/cache
sudo chmod -R ug+rwx storage bootstrap/cache
EOF
