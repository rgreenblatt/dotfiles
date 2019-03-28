#!/bin/bash

git submodule init
git submodule update --recursive --remote
mkdir -p ~/.config/

if [[ "$1" != "-c" ]]; then
    ln -s $PWD/i3 ~/.config/
    ln -s $PWD/i3status ~/.config/
    ln -s $PWD/keyboard ~/.config/
    ln -s $PWD/qutebrowser ~/.config/
    ln -s $PWD/st ~/.config/
    ln -s $PWD/zathura ~/.config/
    echo "let g:headless = 1" > ~/.vim_machine_specific.vim
else
    touch ~/.vim_machine_specific.vim
fi

pip install neovim-remote pynvim
ln -s $PWD/nvim ~/.config/nvim  

if ! type "$zsh" &> /dev/null; then
    ./zimfw/install.sh
fi
