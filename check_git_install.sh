#!/bin/bash

if [[ ! $(git status --porcelain) ]]; then
  echo "git is clean so pulling and installing"
  git pull
  ./install.sh
else
  >&2 echo "git isn't clean"
  exit 1
fi
