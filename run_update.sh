#!/bin/bash

nvim +PlugInstall +qa
nvim +PlugUpdate +qa
nvim +PlugUpgrade +qa
zsh -c "mkdir -p ~/.cache && bat cache --build" > /dev/null
zsh -c "cd ~/.fzf && ./install --all" > /dev/null
zsh -c "source ~/.zshrc && zgen update;  zgen_make_save" > /dev/null
zsh -i -c "compinit && compinit -c" > /dev/null
