#!/bin/sh
set -e

php artisan migrate:fresh --seed --force

chown -R www-data:www-data /app /app/vendor /app/storage
chmod -R 775 /app /app/vendor /app/storage

exec php-fpm