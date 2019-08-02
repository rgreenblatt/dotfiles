#!/bin/bash

if [ -z "$PROFILE_SOURCED" ]; then
  source ~/.profile
fi

if [[ -f target ]]; then
  echo "target is defined - installing"
  git pull >/dev/null
  git submodule init >/dev/null
  git submodule update --recursive --remote >/dev/null
  ./install.sh $(cat target)
else
  echo >&2 "target isn't defined"
  exit 1
fi
