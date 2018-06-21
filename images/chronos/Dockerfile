FROM ubuntu:14.04
MAINTAINER Shane Breatnach <shane@zeto.ie>

RUN locale-gen en_IE.UTF-8
ENV LANG en_IE.UTF-8
ENV LANGUAGE en_IE:en
ENV LC_ALL en_IE.UTF-8

# Install custom Clearwater SNMP daemon, MIBs and client
RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y curl && \
    echo deb http://repo.cw-ngv.com/stable binary/ > \
        /etc/apt/sources.list.d/clearwater.list && \
    curl -L http://repo.cw-ngv.com/repo_key | apt-key add -

RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install \
    -y --force-yes clearwater-snmp-handler-chronos snmp

# Compile and install specific version of Chronos
RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y curl git debhelper devscripts \
        build-essential libboost-program-options-dev libcurl4-openssl-dev libevent-dev \
        libboost-regex-dev libboost-filesystem-dev libtool automake make cmake \
        libzmq3-dev libsnmp-dev

ENV CHRONOS_VERSION release-117
ENV CHRONOS_REPO_DIR /chronos
RUN git config --global url."https://github.com/".insteadOf git@github.com: && \
    git clone --branch ${CHRONOS_VERSION} --recursive git@github.com:Metaswitch/chronos.git ${CHRONOS_REPO_DIR} && \
    cd ${CHRONOS_REPO_DIR} && make

RUN mkdir -p /usr/share/chronos/lib && \
    cp ${CHRONOS_REPO_DIR}/debian/chronos.init.d /etc/init.d/chronos && \
    cp ${CHRONOS_REPO_DIR}/usr/lib/*.so /usr/share/chronos/lib && \
    cp ${CHRONOS_REPO_DIR}/usr/lib/*.so.* /usr/share/chronos/lib && \
    cp ${CHRONOS_REPO_DIR}/build/bin/chronos /usr/bin/chronos && \
    useradd --system -M -d /nonexistent -s /bin/false chronos && \
    mkdir -p /var/log/chronos && chown chronos /var/log/chronos && \
    chmod 755 /etc/init.d/chronos

COPY entrypoint.sh /docker-entrypoint.sh
ENTRYPOINT ["bash", "/docker-entrypoint.sh"]
