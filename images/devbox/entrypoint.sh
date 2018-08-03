#!/usr/bin/env bash

# so we can run tests:
# browsers (even headless ones) needs a display to run hence the virtual display
export DISPLAY=':99'
if [ ! -f "/tmp/.X99-lock" ]
then
    Xvfb ${DISPLAY} -screen 0 1280x1024x24 &
fi
/etc/init.d/ssh start

if [ ! -z "${DEVBOX_USER_UID}" ]
then
    usermod -u ${DEVBOX_USER_UID} dev
fi
if [ ! -z "${DEVBOX_USER_GID}" ]
then
    groupmod -g ${DEVBOX_USER_GID} dev
fi
chown -R dev:dev /home/dev
exec su -c "$@" dev
