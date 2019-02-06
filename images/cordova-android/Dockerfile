FROM zetoltd/circleci-android-sdk:1.1.0

# based on https://github.com/iliyan-trifonov/node-nvm

USER root

# Install dependencies, Chrome for testing + AWS CLI for distribution
RUN apt-get update && \
    apt-get install -yq \
    gnupg2 git python build-essential apt-transport-https ca-certificates \
    software-properties-common python-setuptools python-pip \
    libxss1 xvfb chromium && \
    pip --no-cache-dir install awscli==1.11.184 && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists /var/cache/apt

COPY entrypoint.sh /docker-entrypoint.sh

ENV NODE_VERSION=v10.15.0 \
    CORDOVA_VERSION=8.1.2 \
    CHROME_BIN=/usr/bin/chromium

USER ${USERNAME}
WORKDIR ${USER_HOME}

# install node using NVM + Cordova (disabling telemetry)
ENV NVM_DIR=${USER_HOME}/.nvm
RUN curl https://raw.githubusercontent.com/creationix/nvm/v0.33.1/install.sh | bash && \
    . ${NVM_DIR}/nvm.sh && \
    nvm install $NODE_VERSION && \
    nvm alias default $NODE_VERSION && \
    npm install -g cordova@$CORDOVA_VERSION && \
    cordova telemetry off

USER root
# must manually install links to executables to workaround entrypoint overwrite
RUN ln -s $NVM_DIR/versions/node/$NODE_VERSION/bin/npm /usr/local/bin/npm && \
    ln -s $NVM_DIR/versions/node/$NODE_VERSION/bin/node /usr/local/bin/node && \
    ln -s $NVM_DIR/versions/node/$NODE_VERSION/bin/npx /usr/local/bin/npx && \
    ln -s $NVM_DIR/versions/node/$NODE_VERSION/bin/cordova /usr/local/bin/cordova
USER ${USERNAME}
