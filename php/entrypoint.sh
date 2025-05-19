#!/bin/sh
set -e

php artisan key:generate

mkdir -p database
touch ./database/database.sqlite

php artisan migrate:fresh

npm install
npm run build

chown -R www-data:www-data /app /app/vendor /app/storage /app/public
chmod -R 775 /app /app/vendor /app/storage /app/public

exec php-fpm