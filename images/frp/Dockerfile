FROM golang:1.10-alpine

RUN apk update && \
    apk --no-cache add git make

ENV FRP_VERSION v0.21.0
RUN git clone https://github.com/fatedier/frp.git src/github.com/fatedier/frp && \
    cd src/github.com/fatedier/frp && \
    git checkout ${FRP_VERSION} && \
    make && \
    cp bin/frps bin/frpc /usr/bin/ && \
    mkdir -p /etc/frp && \
    cp conf/frps.ini /etc/frp/frps.ini && \
    cp conf/frpc.ini /etc/frp/frpc.ini && \
    cd /go && \
    rm -rf src/github.com/fatedier/frp

ADD entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
CMD ["-c", "/etc/frp/frps.ini"]
EXPOSE 7500
EXPOSE 7000
EXPOSE 2222
EXPOSE 8443
EXPOSE 60000/udp
