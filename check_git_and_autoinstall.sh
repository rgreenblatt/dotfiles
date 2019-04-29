#!/bin/bash

if [[ ! $(git status --porcelain) ]]; then
  echo "git is clean - pulling"
  git pull
  ./autoinstall.sh
else
  >&2 echo "git isn't clean"
  exit 1
fi
