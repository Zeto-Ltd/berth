FROM openjdk:8-jre-alpine
# variant of Dockerfile available at
# https://github.com/jboss-dockerfiles/keycloak/blob/master/server/Dockerfile
# supports AWS ECS integration

RUN apk update && apk add curl py-pip && pip install awscli==1.11.51

ENV KEYCLOAK_VERSION 3.4.3.Final
RUN curl -L https://downloads.jboss.org/keycloak/${KEYCLOAK_VERSION}/keycloak-${KEYCLOAK_VERSION}.tar.gz | tar zx && \
    mv /keycloak-${KEYCLOAK_VERSION} /keycloak
ADD modules /keycloak/modules
RUN wget https://jdbc.postgresql.org/download/postgresql-42.2.2.jar -O /keycloak/modules/org/postgresql/main/postgresql-jdbc.jar

COPY docker-entrypoint.sh /docker-entrypoint.sh
EXPOSE 8080
EXPOSE 7600
EXPOSE 57600

ENTRYPOINT [ "sh", "/docker-entrypoint.sh" ]
