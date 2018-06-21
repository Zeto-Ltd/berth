#!/usr/bin/env bash

service snmpd start
exec /usr/local/bin/chronos $*
