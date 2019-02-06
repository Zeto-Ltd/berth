#!/usr/bin/env bash

export ANDROID_HOME=$HOME/android-sdk-linux
export PATH="$HOME/gradle/bin:$HOME/android-sdk-linux/tools/bin:$HOME/android-sdk-linux/tools:$HOME/android-sdk-linux/platform-tools:$PATH"

exec "$@"
