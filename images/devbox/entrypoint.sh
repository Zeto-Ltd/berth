#!/usr/bin/env bash

# so we can run tests:
# browsers (even headless ones) needs a display to run hence the virtual display
export DISPLAY=':99'
if [ ! -f "/tmp/.X99-lock" ]
then
    Xvfb ${DISPLAY} -screen 0 1280x1024x24 &
fi

exec "$@"
