FROM circleci/python:3.6

# combining Python + Node with AWS and Heroku CLIs

USER root

# Install dependencies + AWS CLI for distribution
RUN apt-get update && \
    apt-get install -yq \
    git libpython-dev build-essential apt-transport-https ca-certificates \
    gnupg2 software-properties-common python-setuptools python3-pip \
    libxss1 xvfb libxtst-dev libgtkextra-dev libgconf2-dev libnss3 libasound2 && \
    wget -qO- https://cli-assets.heroku.com/install-ubuntu.sh | sh && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists /var/cache/apt && \
    pip install awscli==1.11.184

ENV NODE_VERSION=v6.11.3 \
    NVM_DIR=/root/.nvm

# install node using NVM
# must manually install links to executables to workaround entrypoint overwrite
RUN curl https://raw.githubusercontent.com/creationix/nvm/v0.33.1/install.sh | bash && \
    . ~/.nvm/nvm.sh && \
    nvm install $NODE_VERSION && \
    nvm alias default $NODE_VERSION && \
    ln -s $NVM_DIR/versions/node/$NODE_VERSION/bin/npm /usr/local/bin/npm && \
    ln -s $NVM_DIR/versions/node/$NODE_VERSION/bin/node /usr/local/bin/node

# ensure that the CircleCI build agent doesn't override the entrypoint
LABEL com.circleci.preserve-entrypoint=true
COPY entrypoint.sh /docker-entrypoint.sh
COPY setup-heroku.sh /setup-heroku.sh
ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["/bin/sh"]
