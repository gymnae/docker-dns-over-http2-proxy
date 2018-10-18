
FROM gymnae/webserverbase
MAINTAINER Gunnar Falk <docker@grundstil.de>

RUN set -e;                                                                                   \
    apk add --no-cache ca-certificates git go@community gcc musl-dev;                                   \
    GOPATH=/tmp/go GOBIN=/ go get -v -ldflags '-s' github.com/m13253/dns-over-https/doh-server; \
    apk del git go gcc musl-dev;                                                              \
    rm -rf /tmp/go

COPY doh-server.conf /doh-server.conf
COPY nginx.conf /etc/nginx/nginx.conf

ENTRYPOINT ["/dns-over-https-proxy"]
