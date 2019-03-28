#!/bin/bash

git submodule init
git submodule update --recursive --remote
mkdir -p ~/.config/

ln -s $PWD/nvim ~/.config/
ln -s $PWD/bat ~/.config/
ln -s $PWD/scripts ~/
ln -s $PWD/.profile ~/

if [[ "$1" != "-c" ]]; then
    ln -s $PWD/i3 ~/.config/
    ln -s $PWD/i3status ~/.config/
    ln -s $PWD/keyboard ~/
    ln -s $PWD/qutebrowser ~/.config/
    ln -s $PWD/st ~/.config/
    ln -s $PWD/zathura ~/.config/
    touch ~/.vim_machine_specific.vim
else
    echo "let g:headless = 1" > ~/.vim_machine_specific.vim
fi


if ! type "$zsh" &> /dev/null; then
    ln -s $PWD/.zimrc ~/
    ln -s $PWD/.zshrc ~/
    ./zimfw/install.sh
fi
