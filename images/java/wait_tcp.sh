#!/usr/bin/env bash
HOST=${1:-localhost}
PORT=${2:-5432}
for i in `seq 1 10`;
do
  nc -z ${1:-localhost} ${2:-5432} && echo Success && exit 0
  echo -n .
  sleep 1
done
echo Failed waiting for ${HOST}:${PORT} && exit 1
