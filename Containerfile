FROM alpine:latest as builder

COPY /build /build

RUN cd /build && ./build.sh

FROM alpine:latest

COPY entrypoint.sh /

COPY --from=builder /bin/miniupnpd /bin/miniupnpd

RUN apk add libnftnl libmnl

ENTRYPOINT ["/entrypoint.sh"]