FROM node:4.4.4

# using node v4.4.4 and npm v2.15.1 with AWS CLI

USER root

# Install dependencies + AWS CLI for distribution
RUN apt-get update && \
    apt-get install -yq \
    git libssl-dev libpython-dev build-essential apt-transport-https ca-certificates \
    software-properties-common python-setuptools python-pip && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists /var/cache/apt && \
    pip install awscli==1.11.184 && npm install -g npm@v2.15.1


# ensure that the CircleCI build agent doesn't override the entrypoint
LABEL com.circleci.preserve-entrypoint=true
COPY entrypoint.sh /docker-entrypoint.sh
ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["/bin/sh"]
