#!/bin/bash

git submodule update --recursive --remote
mkdir -p ~/.config/

if [ $1 -ne "-c" ]; then
   ln -s i3 ~/.config/
   ln -s i3status ~/.config/
   ln -s keyboard ~/.config/
   ln -s qutebrowser ~/.config/
   ln -s st ~/.config/
   ln -s zathura ~/.config/
fi

ln -s nvim ~/.config/nvim  
if ! type "$zsh" &> /dev/null; then
    ./zimfw/install.sh
fi
