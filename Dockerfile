
FROM gymnae/webserverbase
MAINTAINER Gunnar Falk <docker@grundstil.de>

# install what we actually need
RUN set -e; \
    apk add --no-cache ca-certificates git go@community gcc musl-dev; \
    GOPATH=/tmp/go GOBIN=/ go get -v -ldflags '-s' github.com/m13253/dns-over-https/doh-server; \
    rm -rf /tmp/go

# remove clutter from the origin 
RUN rm -rf /var/cache/apk/* && \
    rm -rf /tmp/* \
    && apk update \
    && apk del git gcc musl-dev \
    php7-openssl \
	php7-curl \
	php7-fpm \
	php7-gd \
	php7-redis \
	php7-pdo_mysql \
	php7-pgsql \
    libmaxminddb \
    php7-fpm \
	php7-sqlite3

COPY doh-server.conf /doh-server.conf
COPY nginx.conf /etc/nginx/nginx.conf

# prepare init script for start
ADD docker-entrypoint.sh /docker-entrypoint.sh
RUN chmod +x /docker-entrypoint.sh

ENTRYPOINT ["./docker-entrypoint.sh"]
