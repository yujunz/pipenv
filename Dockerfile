FROM heroku/heroku:18-build

ENV DEBIAN_FRONTEND noninteractive
ENV LC_ALL C.UTF-8
ENV LANG C.UTF-8

# -- Install Pipenv:
RUN apt update && apt upgrade -y && apt install python2.7-dev -y
RUN curl --silent https://bootstrap.pypa.io/get-pip.py | python2.7

# Backwards compatility.
RUN rm -fr /usr/bin/python2 && ln /usr/bin/python2.7 /usr/bin/python2

RUN pip install pipenv

# -- Install Application into container:
RUN set -ex && mkdir /app

WORKDIR /app

# -- Adding Pipfiles
ONBUILD COPY Pipfile Pipfile
ONBUILD COPY Pipfile.lock Pipfile.lock

# -- Install dependencies:
ONBUILD RUN set -ex && pipenv install --deploy --system

# --------------------
# - Using This File: -
# --------------------

# FROM yujunz/pipenv:python2

# COPY . /app

# -- Replace with the correct path to your app's main executable
# CMD python2 main.py
