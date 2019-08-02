#!/usr/bin/env bash

if [ -z "$PROFILE_SOURCED" ]; then
  source ~/.profile
fi

git pull >/dev/null
git submodule update --init --recursive --remote >/dev/null

./autoinstall.sh
./run_update.sh
