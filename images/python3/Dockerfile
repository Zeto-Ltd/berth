FROM circleci/python:3.6

USER root

RUN apt-get update && apt-get install -y --no-install-recommends \
    libpython3-dev

RUN pip install awscli==1.14.62

USER circleci
