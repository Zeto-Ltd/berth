#!/usr/bin/env bash

service snmpd start
exec /usr/bin/chronos $*
