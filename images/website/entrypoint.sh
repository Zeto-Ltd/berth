#!/usr/bin/env bash

export PATH="/root/.nvm/versions/node/v6.11.3/bin:$PATH"

# so we can run tests:
# browsers (even headless ones) needs a display to run hence the virtual display
export DISPLAY=':99'
Xvfb ${DISPLAY} -screen 0 1280x1024x24 &

exec "$@"
