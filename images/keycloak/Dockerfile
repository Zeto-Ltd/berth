FROM openjdk:8-jre-alpine
# variant of Dockerfile available at
# https://github.com/jboss-dockerfiles/keycloak/blob/master/server/Dockerfile
# supports AWS ECS integration

RUN apk --no-cache --update add \
    curl py-pip bash file autoconf automake libtool gettext gettext-dev make g++ texinfo && \
    pip install --no-cache-dir awscli==1.11.51

ENV KEYCLOAK_VERSION 3.4.3.Final
RUN curl -L https://downloads.jboss.org/keycloak/${KEYCLOAK_VERSION}/keycloak-${KEYCLOAK_VERSION}.tar.gz | tar zx && \
    mv /keycloak-${KEYCLOAK_VERSION} /keycloak
ADD modules /keycloak/modules
RUN wget https://jdbc.postgresql.org/download/postgresql-42.2.2.jar -O /keycloak/modules/org/postgresql/main/postgresql-jdbc.jar

# install fswatch to support dynamic reloading for custom modules/themes
ADD bin /custom/bin
ENV FSWATCH_VERSION 1.12.0
RUN wget https://github.com/emcrisostomo/fswatch/releases/download/${FSWATCH_VERSION}/fswatch-${FSWATCH_VERSION}.tar.gz \
        -O /tmp/fswatch.tar.gz && \
    cd /tmp && tar -xzf fswatch.tar.gz && \
    cd fswatch-${FSWATCH_VERSION} && \
    sh configure && make && make install

COPY docker-entrypoint.sh /docker-entrypoint.sh
EXPOSE 8080
EXPOSE 7600
EXPOSE 57600

ENTRYPOINT [ "sh", "/docker-entrypoint.sh" ]
