FROM alpine:3.8

RUN apk --no-cache --update add \
        pgbouncer \
        python \
        py-pip \
    && \
    pip install awscli==1.15.63 && \
    apk -v --purge del py-pip

ADD pgbouncer.ini rds-combined-ca-bundle.pem /etc/pgbouncer/
ADD entrypoint.sh /

EXPOSE 6432
ENTRYPOINT  ["/entrypoint.sh"]
