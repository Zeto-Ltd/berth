FROM zetoltd/circleci-android-sdk:1.0.0

# based on https://github.com/iliyan-trifonov/node-nvm

# Install dependencies + AWS CLI for distribution
RUN apt-get update && \
    apt-get install -yq \
    git python build-essential apt-transport-https ca-certificates \
    gnupg2 software-properties-common python-setuptools python-pip \
    libxss1 xvfb && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists /var/cache/apt && \
    pip install awscli==1.11.184

ENV NODE_VERSION=v6.11.3 \
    NVM_DIR=/root/.nvm \
    CORDOVA_VERSION=7.1.0

# install node using NVM + Cordova (disabling telemetry)
# must manually install links to executables to workaround entrypoint overwrite
RUN curl https://raw.githubusercontent.com/creationix/nvm/v0.33.1/install.sh | bash && \
    . ~/.nvm/nvm.sh && \
    nvm install $NODE_VERSION && \
    nvm alias default $NODE_VERSION && \
    npm install -g cordova@$CORDOVA_VERSION && \
    cordova telemetry off && \
    ln -s $NVM_DIR/versions/node/$NODE_VERSION/bin/npm /usr/local/bin/npm && \
    ln -s $NVM_DIR/versions/node/$NODE_VERSION/bin/node /usr/local/bin/node && \
    ln -s $NVM_DIR/versions/node/$NODE_VERSION/bin/cordova /usr/local/bin/cordova

COPY entrypoint.sh /docker-entrypoint.sh
