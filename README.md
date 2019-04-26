# dotfiles

I am using the nerd fonts version of the Hack font, exa, bat, thefuck, vimiv, tldr, and ripgrep. 

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

Most of this can be found [here](git@github.com:rgreenblatt/devbox), but here is some vague idea of how to set Ubuntu 18.04/18.10 to have everything needed for a full install.

I am not making this a script because it should probably be run at most several lines at a time and I haven't tested the entire sequence (yet). Some lines require user input.

```
sudo apt update
sudo apt install git build-essential i3 python3-pip zathura qutebrowser \
  compton xdotool subversion openssh-server ruby-dev
```
Install neovim as desired (I am am currently on master or a fork with additional features). 
Install drivers as needed, nvidia drivers may be required for qutebrowser.
```
sudo update-alternatives --config x-www-browser
mkdir install
cd install
wget https://raw.githubusercontent.com/ryanoasis/nerd-fonts/master/install.sh
mkdir patched-fonts
cd patched-fonts
svn export https://github.com/ryanoasis/nerd-fonts/trunk/patched-fonts/Hack
cd ..
chmod +x install.sh
./install.sh
pip3 install pynvim neovim-remote thefuck evdev
pip2 install pynvim
sudo gem install neovim
curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.34.0/install.sh \
  | bash
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
nvm install lts
npm i -g tldr bash-language-server neovim
curl -o- -L https://yarnpkg.com/install.sh | bash
cd .. && sudo ln -sf "$PWD/root_configs/etc/udev/rules.d/85-input.rules" \
  /etc/udev/rules.d/85-input.rules && cd install
sudo usermod -aG input $USER
curl -L -o ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
cd ~/.local/etc/st/ && make && sudo make install && cd -
sudo update-alternatives --install /usr/bin/x-terminal-emulator \
  x-terminal-emulator /usr/local/bin/st 300 
curl https://sh.rustup.rs -sSf | sh -s -- -y
~/.cargo/bin/cargo install bat exa ripgrep
apt-get install -y  git-core gcc make autoconf yodl libncursesw5-dev texinfo man-db
git clone https://github.com/zsh-users/zsh && cd zsh && ./Util/preconfig && \
  ./configure --prefix=/usr \
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
git clone https://github.com/universal-ctags/ctags.git && cd ctags \
  && ./autogen.sh && ./configure && make && sudo make install && cd ..
git clone https://github.com/karlch/vimiv && cd vimiv && make && \
  sudo make install && cd ..
cd ..
./install.sh main
nvim +PlugInstall +qa
cd ~/.fzf && ./install --all && cd -
bat cache --build
```

Additional language servers for coc may also be desirable.
