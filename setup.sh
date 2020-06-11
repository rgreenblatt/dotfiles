#!/usr/bin/env bash

CONFIG_DIR=$HOME/.config
mkdir $CONFIG_DIR
ln -s $PWD/nvim/.config/nvim $CONFIG_DIR/nvim
ln -s $PWD/i3/.config/i3 $CONFIG_DIR/i3
ln -s $PWD/i3status/.config/i3status $CONFIG_DIR/i3status
ln -s $PWD/kitty/.config/kitty $CONFIG_DIR/kitty
