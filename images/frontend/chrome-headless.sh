#!/bin/sh
# Flags taken from: https://github.com/westy92/headless-chrome-alpine/blob/master/Dockerfile

/usr/lib/chromium/chrome \
    --headless \
    --no-sandbox \
    --disable-background-networking \
    --disable-default-apps \
    --disable-extensions \
    --disable-gpu \
    --disable-sync \
    --disable-translate \
    --hide-scrollbars \
    --metrics-recording-only \
    --mute-audio \
    --no-first-run \
    --safebrowsing-disable-auto-update \
    "$@"
