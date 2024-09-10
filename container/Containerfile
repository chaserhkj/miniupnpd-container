FROM alpine:latest

COPY entrypoint.sh /

RUN apk add miniupnpd

ENTRYPOINT ["/entrypoint.sh"]