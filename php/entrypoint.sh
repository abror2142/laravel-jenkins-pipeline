#!/bin/sh
set -e

mkdir -p database
touch ./database/database.sqlite

php artisan key:generate
php artisan migrate:fresh

chown -R www-data:www-data /app /app/vendor /app/storage
chmod -R 775 /app /app/vendor /app/storage

exec php-fpm