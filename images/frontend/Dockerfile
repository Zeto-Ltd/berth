FROM node:8.12.0-alpine

USER root

RUN apk add --update --no-cache bash xvfb py-pip && \
    pip install --no-cache-dir awscli==1.11.184 && \
    npm install -g npm@v5.6.0

# ensure that the CircleCI build agent doesn't override the entrypoint
LABEL com.circleci.preserve-entrypoint=true
COPY entrypoint.sh /docker-entrypoint.sh
ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["/bin/sh"]
