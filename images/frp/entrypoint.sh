#!/bin/sh

BIND_ADDRESS=$(ip -o -4 addr list ${BIND_INTERFACE} | head -n1 | awk '{print $4}' | cut -d/ -f1)
if [ ! -z "${AWS_ENVIRONMENT}" ] && [ ! -z "${CONFIG_FILE}" ]
then
    aws s3 cp ${CONFIG_FILE} /etc/frp/frps.ini
fi

exec /usr/bin/frps --bind_addr ${BIND_ADDRESS} $*
