FROM ubuntu:18.04

# Developer image that supports compiling, testing and running
# Clojure, Node, Python, Mono, Go projects

# use bash as docker build shell so we get additional bash capabilities
SHELL ["/bin/bash", "-c"]

# install mono, leiningen and other apt packages for compiling
ENV MONO_VERSION=4.6 \
    DEV_HOME=/home/dev
RUN apt update && apt install -y \
    leiningen \
    golang \
    libpq-dev \
    curl \
    bash \
    git \
    gettext \
    autoconf \
    libtool \
    openssh-server \
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
    emacs-nox \
    tmux \
    vim \
    maven \
    postgresql-client-10 \
    xvfb && \
    apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 3FA7E0328081BFF6A14DA29AA6A19B38D3D831EF && \
    echo "deb http://download.mono-project.com/repo/debian wheezy/snapshots/${MONO_VERSION} main" > /etc/apt/sources.list.d/mono-xamarin.list && \
    apt update && \
    apt install -y mono-devel && \
    wget https://nuget.org/nuget.exe -O /usr/bin/nuget.exe && \
    echo -e "#!/bin/bash\nmono /usr/bin/nuget.exe $*" > /usr/bin/nuget && \
    chmod 755 /usr/bin/nuget && \
    apt clean

COPY bashrc ${DEV_HOME}/.bashrc
COPY profile ${DEV_HOME}/.profile
# adding user 'dev' that matches host gid/uid with password of 'dev'
# + sane tmux configuration
ENV TMUX_MODIFIER C-q
RUN addgroup --gid ${USER_GID:-1000} dev && \
    useradd -d ${DEV_HOME} -s /bin/bash \
        -p sjFK4jJmFgl1M \
        -u ${USER_UID:-1000} -g ${USER_GID:-1000} -G sudo dev && \
    echo -e "unbind C-b\nset -g prefix ${TMUX_MODIFIER}\nbind ${TMUX_MODIFIER} send-prefix" > ${DEV_HOME}/.tmux.conf && \
    chown -R dev:dev ${DEV_HOME}

WORKDIR ${DEV_HOME}
USER dev

# install NVM for all node LTS versions
ENV NVM_DIR=${DEV_HOME}/.nvm
RUN mkdir -p $NVM_DIR && \
    curl https://raw.githubusercontent.com/creationix/nvm/v0.33.11/install.sh | bash && \
    . $NVM_DIR/nvm.sh && \
    nvm install v8.11.3 && nvm install v6.14.3 && nvm install v4.9.1 && \
    nvm alias default v8.11.3

# install PyEnv for all python versions, defaulting to v3
ENV PYENV_BIN ${DEV_HOME}/.pyenv/bin/pyenv
RUN git clone git://github.com/pyenv/pyenv.git ~/.pyenv && \
    $PYENV_BIN install 2.7.15 && $PYENV_BIN install 3.6.5 && \
    curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py && \
    $PYENV_BIN global 2.7.15 && $($PYENV_BIN which python) get-pip.py && \
    $($PYENV_BIN which pip) --no-cache-dir install \
    virtualenv==16.0.0 \
    virtualenvwrapper==4.8.2 \
    awscli==1.15.49 && \
    $PYENV_BIN global 3.6.5 && $($PYENV_BIN which python) get-pip.py && \
    $($PYENV_BIN which pip) --no-cache-dir install \
    virtualenv==16.0.0 \
    virtualenvwrapper==4.8.2 \
    awscli==1.15.49 && \
    rm get-pip.py

# liquibase DB migration tool
ENV LIQUIBASE_VERSION=3.6.1 \
    SLF4J_VERSION=1.7.25
RUN wget https://github.com/liquibase/liquibase/releases/download/liquibase-parent-${LIQUIBASE_VERSION}/liquibase-${LIQUIBASE_VERSION}-bin.tar.gz -O ${DEV_HOME}/liquibase.tar.gz && \
    mkdir -p ${DEV_HOME}/liquibase ${DEV_HOME}/bin && \
    tar -xzf ${DEV_HOME}/liquibase.tar.gz -C ${DEV_HOME}/liquibase && \
    wget https://jdbc.postgresql.org/download/postgresql-42.2.2.jar -O ${DEV_HOME}/liquibase/lib/postgresql.jar && \
    wget https://www.slf4j.org/dist/slf4j-${SLF4J_VERSION}.tar.gz && \
    tar -xzf ${DEV_HOME}/slf4j-${SLF4J_VERSION}.tar.gz && \
    cp ${DEV_HOME}/slf4j-${SLF4J_VERSION}/slf4j-api-${SLF4J_VERSION}.jar ${DEV_HOME}/liquibase/lib/slf4j-api.jar && \
    rm -rf ${DEV_HOME}/slf4j-${SLF4J_VERSION}* ${DEV_HOME}/liquibase.tar.gz

COPY entrypoint.sh /docker-entrypoint.sh
ENTRYPOINT ["/bin/bash", "/docker-entrypoint.sh"]
CMD ["bash"]
