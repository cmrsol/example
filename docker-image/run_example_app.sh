#!/bin/bash

echo "Starting uwsgi"
/usr/local/bin/uwsgi --enable-threads --lazy --ini /app/example.ini 2>&1 | tee -a /var/log/nginx/example.log &

echo "Starting nginx"
/usr/sbin/nginx -g 'daemon off;'
