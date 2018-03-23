FROM circleci/clojure:lein-2.8.1

USER root

RUN apt-get update && apt-get install -y --no-install-recommends \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg2 \
    software-properties-common \
    python-setuptools \
    python-pip \
    postgresql-client

RUN pip install awscli==1.11.184
RUN curl -fsSL https://download.docker.com/linux/$(. /etc/os-release; echo "$ID")/gpg | \
    apt-key add - && \
    add-apt-repository \
       "deb [arch=amd64] https://download.docker.com/linux/$(. /etc/os-release; echo "$ID") \
       $(lsb_release -cs) \
       stable" && \
    apt-get update && apt-get install -y --no-install-recommends \
    docker-ce
