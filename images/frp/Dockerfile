FROM golang:1.10-alpine

RUN apk update && \
    apk --no-cache add git make py-pip && \
    pip --no-cache-dir install awscli==1.15.81

RUN git clone https://github.com/fatedier/frp.git src/github.com/fatedier/frp && \
    cd src/github.com/fatedier/frp && \
    make && \
    cp bin/frps bin/frpc /usr/bin/ && \
    mkdir -p /etc/frp && \
    cp conf/frps.ini /etc/frp/frps.ini && \
    cp conf/frpc.ini /etc/frp/frpc.ini

ADD entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
CMD ["-c", "/etc/frp/frps.ini"]
EXPOSE 7500
EXPOSE 7000
