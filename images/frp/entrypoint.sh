#!/bin/sh

if [ ! -z "${CONFIG_FILE}" ]
then
    BIND_ADDRESS=$(ip -o -4 addr list ${BIND_INTERFACE} | head -n1 | awk '{print $4}' | cut -d/ -f1)
    aws s3 cp ${CONFIG_FILE} /etc/frp/frps.ini
    # Since CLI args don't override config file settings, must override bind address in file
    sed -i -e "s/bind_addr = 0.0.0.0/bind_addr = ${BIND_ADDRESS}/g" /etc/frp/frps.ini
fi

exec /usr/bin/frps $*
