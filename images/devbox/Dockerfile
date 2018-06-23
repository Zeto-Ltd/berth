FROM ubuntu:18.04

# Developer image that supports compiling, testing and running
# Clojure, Node, Python, Mono, Go projects

# use bash as docker build shell so we get additional bash capabilities
SHELL ["/bin/bash", "-c"]

# install leiningen and other apt packages
RUN apt update && apt install -y \
    leiningen \
    golang \
    libpq-dev \
    curl \
    bash \
    git \
    build-essential \
    apt-transport-https \
    ca-certificates \
    gnupg2 \
    software-properties-common \
    sudo \
    bison \
    libssl-dev \
    libsqlite3-dev \
    libbz2-dev \
    zlib1g-dev \
    libreadline-dev \
    libxss1 \
    xvfb && \
    apt clean

COPY bashrc /home/dev/.bashrc
COPY profile /home/dev/.profile
# adding user 'dev' that matches host gid/uid with password of 'dev'
RUN addgroup --gid ${USER_GID:-1000} dev && \
    useradd -d /home/dev -s /bin/bash \
        -p sjFK4jJmFgl1M \
        -u ${USER_UID:-1000} -g ${USER_GID:-1000} -G sudo dev && \
    chown -R dev:dev /home/dev
WORKDIR /home/dev
ENV HOME /home/dev
USER dev
# TODO: enable passwordless sudo

# TODO: virtualenv, virtualenvwrapper, mono

# install NVM for all node LTS versions
ENV NVM_DIR=/home/dev/.nvm
RUN mkdir -p $NVM_DIR && \
    curl https://raw.githubusercontent.com/creationix/nvm/v0.33.11/install.sh | bash && \
    . $NVM_DIR/nvm.sh && \
    nvm install v8.11.3 && nvm install v6.14.3 && nvm install v4.9.1 && \
    nvm alias default v8.11.3

# install PyEnv for all python versions, defaulting to v3
ENV PYENV_BIN $HOME/.pyenv/bin/pyenv
RUN git clone git://github.com/pyenv/pyenv.git ~/.pyenv && \
    $PYENV_BIN install 2.7.15 && $PYENV_BIN install 3.6.5 && \
    $PYENV_BIN global 3.6.5

COPY entrypoint.sh /docker-entrypoint.sh
ENTRYPOINT ["/bin/bash", "/docker-entrypoint.sh"]
