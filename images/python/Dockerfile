FROM circleci/python:2.7

USER root

RUN apt-get update && apt-get install -y --no-install-recommends \
    libpython-dev

RUN pip install awscli

USER circleci
