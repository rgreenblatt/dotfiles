#!/usr/bin/env bash

if [[ -f target ]]; then
  echo "target is defined - installing"
  ./install.sh $(cat target)
else
  echo >&2 "target isn't defined"
  exit 1
fi
