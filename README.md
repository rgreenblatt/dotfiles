# dotfiles

I am using the Hack font (patched for devicons), exa, bat, thefuck, feh, tldr, and ripgrep. 

I have almost everything configured to use some variant of the gruvbox theme.

The keyboard repo contains code for using the event interface through python-evdev to contruct arbitrary 
keyboard layouts. Its undocumented right now.

Submodules in this repo may not be on latest.

I am using an install script instead of stow because I want to have this directory structure and submodules.

### Installation

To install everything run `./install.sh`. To install everything for a headless install run `./install.sh -c`
A set of machine specific files can also be installed using `./install.sh <name-of-machine>`.

### Notes

It is possible to install nvim without root using 
[this approach](https://github.com/neovim/neovim/wiki/Installing-Neovim#Linux).
It is possible to install cargo without root (see standard install).
It is possible to install npm packages without root using 
[this approach](https://docs.npmjs.com/resolving-eacces-permissions-errors-when-installing-packages-globally)

Most of this can be found [here](git@github.com:rgreenblatt/devbox), but here is some vague idea of how to set Ubuntu 18.04/18.10 to have everything needed:
```
sudo apt update
sudo apt install git build-essential i3 python3-pip zathura qutebrowser compton
```
Install neovim as desired (I am am currently on master or a fork with additional features). Install drivers as needed, nvidia drivers may be required for qutebrowser.
```
pip3 install pynvim neovim-remote thefuck evdev
curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.34.0/install.sh \
  | bash
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
nvm install lts
curl -o- -L https://yarnpkg.com/install.sh | bash
sudo ln -sf "$PWD/root_configs/etc/udev/rules.d/85-input.rules" \
  /etc/udev/rules.d/85-input.rules
curl -L -o ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
cd ~/.local/etc/st/ && make && sudo make install && cd -
sudo update-alternatives --install /usr/bin/x-terminal-emulator \
  x-terminal-emulator /usr/local/bin/st 300 
curl https://sh.rustup.rs -sSf | sh -s -- -y
~/.cargo/bin/cargo install bat exa ripgrep
apt-get install -y  git-core gcc make autoconf yodl libncursesw5-dev texinfo man-db
git clone https://github.com/zsh-users/zsh
cd zsh && ./Util/preconfig && ./configure --prefix=/usr \
    --mandir=/usr/share/man \
    --bindir=/bin \
    --infodir=/usr/share/info \
    --enable-maildir-support \
    --enable-max-jobtable-size=256 \
    --enable-etcdir=/etc/zsh \
    --enable-function-subdirs \
    --enable-site-fndir=/usr/local/share/zsh/site-functions \
    --enable-fndir=/usr/share/zsh/functions \
    --with-tcsetpgrp \
    --with-term-lib="ncursesw" \
    --enable-cap \
    --enable-pcre \
    --enable-readnullcmd=pager \
    --enable-custom-patchlevel=Debian \
    LDFLAGS="-Wl,--as-needed -g" && \
    make && make check && sudo make install
chsh -s /bin/zsh
git clone https://github.com/universal-ctags/ctags.git
cd ctags && ./autogen.sh && ./configure && make && make install
nvim +PlugInstall +qa
cd ~/.fzf && ./install --all && cd -
bat cache --build
```
