FROM maven:3.5.3-jdk-8

RUN apt-get update && apt-get install -y \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg2 \
    git \
    netcat \
    postgresql-client \
    software-properties-common \
    python-setuptools \
    python-pip

RUN pip install awscli==1.15.10
RUN curl -fsSL https://download.docker.com/linux/$(. /etc/os-release; echo "$ID")/gpg | \
    apt-key add - && \
    add-apt-repository \
       "deb [arch=amd64] https://download.docker.com/linux/$(. /etc/os-release; echo "$ID") \
       $(lsb_release -cs) \
       stable" && \
    apt-get update && apt-get install -y --no-install-recommends \
    docker-ce

COPY wait_tcp.sh /usr/bin/wait_tcp
