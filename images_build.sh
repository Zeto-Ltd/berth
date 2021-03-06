#!/usr/bin/env bash

docker login

docker build -t zetoltd/circleci-clojure:1.0.2 ./images/clojure/
docker push zetoltd/circleci-clojure:1.0.2

docker build -t zetoltd/circleci-python:1.0.1 ./images/python/
docker push zetoltd/circleci-python:1.0.1

docker build -t zetoltd/circleci-python3:1.0.0 ./images/python3/
docker push zetoltd/circleci-python3:1.0.0

docker build -t zetoltd/circleci-dynamodblocal:1.0.2 ./images/dynamodb/
docker push zetoltd/circleci-dynamodblocal:1.0.2

docker build -t zetoltd/circleci-postgres:1.0.0 ./images/postgres/
docker push zetoltd/circleci-postgres:1.0.0

docker build -t zetoltd/circleci-android-sdk:1.1.0 ./images/android-sdk/
docker push zetoltd/circleci-android-sdk:1.1.0

docker build -t zetoltd/circleci-cordova-android:1.1.0 ./images/cordova-android/
docker push zetoltd/circleci-cordova-android:1.1.0

docker build -t zetoltd/circleci-website:1.1.0 ./images/website/
docker push zetoltd/circleci-website:1.1.0

docker build -t zetoltd/circleci-java:1.0.1 ./images/java/
docker push zetoltd/circleci-java:1.0.1

# Lifted from doc.ai fork of original docker image from Sendgridlabs
docker build -t zetoltd/loggly:1.0.0 ./images/loggly/
docker build -t zetoltd/loggly:latest ./images/loggly/
docker push zetoltd/loggly:1.0.0
docker push zetoltd/loggly:latest

docker build -t zetoltd/circleci-frontend:1.1.0 ./images/frontend/
docker push zetoltd/circleci-frontend:1.1.0

docker build -t zetoltd/nginx-elb:1.0.0 ./images/nginx-elb/
docker push zetoltd/nginx-elb:1.0.0

docker build -t zetoltd/pgbouncer-ecs:1.0.0 ./images/pgbouncer-ecs/
docker push zetoltd/pgbouncer-ecs:1.0.0

docker build -t zetoltd/frp:1.0.0 ./images/frp/
docker push zetoltd/frp:1.0.0

docker build -t zetoltd/chronos:1.0.0 ./images/chronos/
docker push zetoltd/chronos:1.0.0

docker build -t zetoltd/keycloak:1.0.1 ./images/keycloak/
docker push zetoltd/keycloak:1.0.1

docker build -t zetoltd/devbox:1.0.1 ./images/devbox/
docker push zetoltd/devbox:1.0.1
