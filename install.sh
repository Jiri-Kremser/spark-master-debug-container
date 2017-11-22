#!/bin/bash

if [[ $# != 1 ]]; then
  echo "Usage: ./install.sh <fspath-of-spark-repository>" && exit
fi

_DIR=$(dirname "$0")

cp $_DIR/{Dockerfile,.dockerignore,entrypoint.sh} $1
