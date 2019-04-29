#!/bin/bash

#needed to ensure nvim is in the path
if [ -z "$PROFILE_SOURCED" ]; then
  source ~/.profile
fi

if [[ ! $(git status --porcelain) ]]; then
  if [[ -f target ]]; then
    echo "git is clean and target is defined so pulling and installing"
    git pull
    ./install.sh $(cat target)
    nvim +PlugInstall +qa > /dev/null
    nvim +PlugUpdate +qa > /dev/null
    zsh -c "source ~/.zshrc && (zplug install;  zplug update)" > /dev/null
  else 
    >&2 echo "target isn't defined"
    exit 1
  fi
else
  >&2 echo "git isn't clean"
  exit 1
fi
