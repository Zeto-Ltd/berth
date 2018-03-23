#!/usr/bin/env bash

export ANDROID_HOME=/root/android-sdk-linux
export PATH="/root/gradle/bin:/root/android-sdk-linux/tools/bin:/root/android-sdk-linux/tools:/root/android-sdk-linux/platform-tools:$PATH"

exec "$@"
