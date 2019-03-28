#!/bin/bash

git submodule init
git submodule update --recursive --remote
mkdir -p ~/.config/

pip install neovim-remote pynvim
ln -s $PWD/nvim ~/.config/nvim  

if [[ "$1" != "-c" ]]; then
    ln -s $PWD/i3 ~/.config/
    ln -s $PWD/i3status ~/.config/
    ln -s $PWD/keyboard ~/.config/
    ln -s $PWD/qutebrowser ~/.config/
    ln -s $PWD/st ~/.config/
    ln -s $PWD/zathura ~/.config/
    touch ~/.vim_machine_specific.vim
else
    echo "let g:headless = 1" > ~/.vim_machine_specific.vim
fi


if ! type "$zsh" &> /dev/null; then
    ./zimfw/install.sh
fi
