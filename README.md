# dotfiles

I am using the Hack font (patched for devicons), exa, bat, thefuck, feh, tldr, and ripgrep. 

I have almost everything configured to use some variant of the gruvbox theme.

The keyboard repo contains code for using the event interface through python-evdev to contruct arbitrary 
keyboard layouts. Its undocumented right now.

Submodules in this repo may not be on latest.

I am using an install script instead of stow because I want to have this directory structure and submodules.

### Installation

To install everything run `./install.sh`. To install everything for a headless install run `./install.sh -c`

### Notes

It is possible to install nvim without root using 
[this approach](https://github.com/neovim/neovim/wiki/Installing-Neovim#Linux).
It is possible to install cargo without root (see standard install).
It is possible to install npm packages without root using 
[this approach](https://docs.npmjs.com/resolving-eacces-permissions-errors-when-installing-packages-globally)

