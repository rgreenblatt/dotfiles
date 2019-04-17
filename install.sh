#!/bin/bash

git submodule init
git submodule update --recursive --remote
mkdir -p ~/.config/

ln -sfn $PWD/nvim ~/.config/
ln -sfn $PWD/bat ~/.config/
ln -sfn $PWD/scripts ~/
ln -sfn $PWD/.profile ~/

if [[ "$1" != "-c" ]]; then
    ln -sfn $PWD/i3 ~/.config/
    ln -sfn $PWD/i3status ~/.config/
    ln -sfn $PWD/keyboard ~/
    ln -sfn $PWD/qutebrowser ~/.config/
    mkdir -p ~/.local/etc/
    ln -sfn $PWD/st ~/.local/etc/
    ln -sfn $PWD/zathura ~/.config/
    ln -sfn $PWD/undistract-me ~/.undistract-me
    touch ~/.vim_machine_specific.vim
else
    echo "let g:headless = 1" > ~/.vim_machine_specific.vim
fi


if ! type "$zsh" &> /dev/null; then
    if [ -f "$HOME/.zshrc" ] && [ ! -L "$HOME/.zshrc" ]; then 
        echo ".zshrc must be deleted or moved before install"
        exit 1
    fi
    if [ -f "$HOME/.zimrc" ] && [ ! -L "$HOME/.zimrc" ]; then 
        echo ".zimrc must be deleted or moved before install"
        exit 1
    fi
    ./zimfw/install.sh
    rm -f ~/.zshrc ~/.zimrc
    ln -sfn $PWD/.zshrc ~/
    ln -sfn $PWD/.zimrc ~/
fi
