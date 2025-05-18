#!/bin/sh
set -e

php artisan key:generate

mkdir -p database
touch ./database/database.sqlite

php artisan migrate:fresh

chown -R www-data:www-data /app /app/vendor /app/storage
chmod -R 775 /app /app/vendor /app/storage

exec php-fpm