#!/usr/bin/env bash

export ANDROID_HOME=$HOME/android-sdk-linux
export PATH="$HOME/.nvm/versions/node/$NODE_VERSION/bin:$HOME/gradle/bin:$HOME/android-sdk-linux/tools/bin:$HOME/android-sdk-linux/tools:$HOME/android-sdk-linux/platform-tools:$PATH"

. $HOME/.nvm/nvm.sh

exec "$@"
