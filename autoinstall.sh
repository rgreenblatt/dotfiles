#!/bin/bash

#needed to ensure nvim is in the path
if [ -z "$PROFILE_SOURCED" ]; then
  source ~/.profile
fi

if [[ -f target ]]; then
  echo "target is defined - installing"
  ./install.sh $(cat target)
  nvim +PlugInstall +qa > /dev/null
  nvim +PlugUpdate +qa > /dev/null
  nvim +PlugUpgrade +qa > /dev/null
  zsh -c "mkdir -p ~/.cache && bat cache --build" > /dev/null
  zsh -c "cd ~/.fzf && ./install --all" > /dev/null
  zsh -c "source ~/.zshrc && zgen update;  zgen_make_save" > /dev/null
else 
  >&2 echo "target isn't defined"
  exit 1
fi
