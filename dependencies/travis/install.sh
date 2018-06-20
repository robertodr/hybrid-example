#!/usr/bin/env bash

set -eu -o pipefail

if [[ "$TRAVIS_OS_NAME" == "osx" ]]; then
  brew update &> /dev/null
  brew cask uninstall --force oclint
  brew install gcc
  brew install mpich
fi
