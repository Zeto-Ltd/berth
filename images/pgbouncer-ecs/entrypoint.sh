#!/bin/sh

PG_RUN=/var/run/pgbouncer/
PG_LOG=/var/log/containers/pgbouncer/
PG_CONFIG=/etc/pgbouncer/pgbouncer.ini
PG_USER=postgres

if [ ! -z "${CONFIG_FILE}" ]
then
    aws s3 cp ${CONFIG_FILE} ${PG_CONFIG}
fi

mkdir -p ${PG_RUN}
mkdir -p ${PG_LOG}
chown ${PG_USER}:${PG_USER} ${PG_LOG}
chown ${PG_USER}:${PG_USER} ${PG_RUN}

echo "Starting pgbouncer..."
exec pgbouncer -q -u ${PG_USER} ${PG_CONFIG}
