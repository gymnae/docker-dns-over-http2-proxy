
FROM gymnae/webserverbase
MAINTAINER Gunnar Falk <docker@grundstil.de>

RUN set -e; \
    apk add --no-cache ca-certificates git go@community gcc musl-dev; \
    GOPATH=/tmp/go GOBIN=/ go get -v -ldflags '-s' github.com/m13253/dns-over-https/doh-server; \
    rm -rf /tmp/go

#RUN apk del git go@community gcc musl-dev

COPY doh-server.conf /doh-server.conf
COPY nginx.conf /etc/nginx/nginx.conf

# prepare init script for start
ADD docker-entrypoint.sh /docker-entrypoint.sh
RUN chmod +x /docker-entrypoint.sh

CMD ["sh ./docker-entrypoint.sh"]
