FROM golang:1.11 as frpBuild

COPY . /go/src/github.com/fatedier/frp

ENV CGO_ENABLED=0

RUN cd /go/src/github.com/fatedier/frp \
 && make

FROM alpine:3.6

COPY --from=frpBuild /go/src/github.com/fatedier/frp/bin/frpc /
COPY --from=frpBuild /go/src/github.com/fatedier/frp/conf/frpc.ini /
COPY --from=frpBuild /go/src/github.com/fatedier/frp/bin/frps /
COPY --from=frpBuild /go/src/github.com/fatedier/frp/conf/frps.ini /

WORKDIR /

CMD ["/frps","-c","frps.ini"]
