FROM nginx:latest

RUN rm -rf /etc/nginx/conf.d/default.conf

COPY ./nginx/conf.d /etc/nginx/conf.d
COPY ./app/public /app/public
