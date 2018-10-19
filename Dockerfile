
FROM gymnae/webserverbase
MAINTAINER Gunnar Falk <docker@grundstil.de>

RUN set -e; \
    apk add --no-cache ca-certificates git go@community gcc musl-dev; \
    GOPATH=/tmp/go GOBIN=/ go get -v -ldflags '-s' github.com/m13253/dns-over-https/doh-server; \
    rm -rf /tmp/go

#RUN apk del git go@community gcc musl-dev
RUN apk del php7-openssl@community \
	php7-curl@community \
	php7-fpm@community \
	php7-gd@community \
	php7-redis@community \
	php7-pdo_mysql@community \
	php7-pgsql@community \
	libmaxminddb \
    php7-fpm@community \
	php7-sqlite3@community 

COPY doh-server.conf /doh-server.conf
COPY nginx.conf /etc/nginx/nginx.conf

# prepare init script for start
ADD docker-entrypoint.sh /docker-entrypoint.sh
RUN chmod +x /docker-entrypoint.sh

ENTRYPOINT ["sh ./docker-entrypoint.sh"]
