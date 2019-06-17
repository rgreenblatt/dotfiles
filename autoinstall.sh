#!/bin/bash

#needed to ensure nvim is in the path
if [ -z "$PROFILE_SOURCED" ]; then
  source ~/.profile
fi

if [[ -f target ]]; then
  echo "target is defined - installing"
  ./install.sh $(cat target)
  ./run_update.sh
else
  >&2 echo "target isn't defined"
  exit 1
fi
