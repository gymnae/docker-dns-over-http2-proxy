#!/bin/sh

mkdir -p /dev/shm/cache/
mkdir -p /tmp/nginx/
echo "[ INFO ] Starting nginx & doh-server"
bash -c '/usr/sbin/nginx -g "daemon on;"'
bash -c './doh-server -verbose'