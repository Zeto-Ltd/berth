#!/usr/bin/env bash

docker login

docker build -t zetoltd/circleci-clojure:1.0.1 ./images/clojure/
docker push zetoltd/circleci-clojure:1.0.1

docker build -t zetoltd/circleci-python:1.0.1 ./images/python/
docker push zetoltd/circleci-python:1.0.1

docker build -t zetoltd/circleci-python3:1.0.0 ./images/python3/
docker push zetoltd/circleci-python3:1.0.0

docker build -t zetoltd/circleci-dynamodblocal:1.0.0 ./images/dynamodb/
docker push zetoltd/circleci-dynamodblocal:1.0.0

docker build -t zetoltd/circleci-android-sdk:1.0.0 ./images/android-sdk/
docker push zetoltd/circleci-android-sdk:1.0.0

docker build -t zetoltd/circleci-cordova-android:1.0.0 ./images/cordova-android/
docker push zetoltd/circleci-cordova-android:1.0.0

docker build -t zetoltd/circleci-website:1.0.0 ./images/website/
docker push zetoltd/circleci-website:1.0.0
