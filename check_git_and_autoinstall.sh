#!/bin/bash

if [[ ! $(git status --porcelain) ]]; then
  if [[ -f target ]]; then
    echo "git is clean and target is defined so pulling and installing"
    git pull
    ./install.sh $(cat target)
    nvim +PlugInstall +qa
  else 
    >&2 echo "target isn't defined"
    exit 1
  fi
else
  >&2 echo "git isn't clean"
  exit 1
fi
