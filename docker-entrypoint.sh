mkdir -p /dev/shm/cache/
echo "[ INFO ] Starting nginx & doh-server"
bash -c '/usr/sbin/nginx -g "daemon on;"'
bash -c './doh-server -verbose'