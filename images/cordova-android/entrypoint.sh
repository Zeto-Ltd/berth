#!/usr/bin/env bash

export ANDROID_HOME=/root/android-sdk-linux
export PATH="/root/.nvm/versions/node/v6.11.3/bin:/root/gradle/bin:/root/android-sdk-linux/tools/bin:/root/android-sdk-linux/tools:/root/android-sdk-linux/platform-tools:$PATH"

# so we can run tests:
# browsers (even headless ones) needs a display to run hence the virtual display
export DISPLAY=':99'
Xvfb ${DISPLAY} -screen 0 1280x1024x24 &

exec "$@"
