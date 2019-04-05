#!/usr/bin/env bash

# so we can run tests:
# browsers (even headless ones) needs a display to run hence the virtual display
export DISPLAY=':99'
if [ ! -f "/tmp/.X99-lock" ]
then
    Xvfb ${DISPLAY} -screen 0 1280x1024x24 &
fi
# SSH server for easy integration with Intellij IDEA
/etc/init.d/ssh start

FORCING_PERMISSIONS=${FORCE_PERMISSIONS:-true}

if [ "${FORCING_PERMISSIONS}" == "true" ]
then
    echo "Checking existing permissions."
    # Ensure the user ID + group ID match the host UID + GID, otherwise file
    # permission errors will occur
    EXPECTED_UID=${DEVBOX_USER_UID:-1000}
    EXPECTED_GID=${DEVBOX_USER_GID:-1000}
    ACTUAL_UID=`id -u dev`
    ACTUAL_GID=`id -g dev`
    HOME_UID=`stat --printf %u .`
    HOME_GID=`stat --printf %g .`
    if [ "${EXPECTED_UID}" != "${ACTUAL_UID}" ]
    then
        usermod -u ${EXPECTED_UID} dev
    fi
    if [ "${EXPECTED_GID}" != "${ACTUAL_GID}" ]
    then
        groupmod -g ${EXPECTED_GID} dev
    fi
    if [ "${EXPECTED_UID}" != "${ACTUAL_UID}" ] || \
           [ "${EXPECTED_GID}" != "${ACTUAL_GID}" ] || \
           [ "${EXPECTED_UID}" != "${HOME_UID}" ] || \
           [ "${EXPECTED_GID}" != "${HOME_GID}" ]
    then
        echo "Converting permissions for relevant directories, please wait..."
        chown -R dev:dev /home/dev
        chown -R dev:dev /var/log/containers
    fi
fi

exec su -c "$@" dev
