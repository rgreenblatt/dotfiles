#!/usr/bin/env bash

CONFIG_DIR=$HOME/.config
mkdir $CONFIG_DIR
ln -s nvim/.config/nvim $CONFIG_DIR/nvim
ln -s i3/.config/i3 $CONFIG_DIR/i3
ln -s i3status/.config/i3status $CONFIG_DIR/i3status
ln -s kitty/.config/kitty $CONFIG_DIR/kitty
