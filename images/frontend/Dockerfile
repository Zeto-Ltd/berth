FROM node:8.12.0-alpine

USER root

RUN apk add --update --no-cache git bash chromium py-pip && \
    pip install --no-cache-dir awscli==1.11.184 && \
    npm install -g npm@v6.4.1
COPY chrome-headless.sh /usr/bin/chrome-headless
COPY env.sh /etc/profile.d/env.sh

CMD ["/bin/sh", "-l"]
