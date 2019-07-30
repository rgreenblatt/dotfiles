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

Most of this can be found [here](git@github.com:rgreenblatt/devbox), but here is some vague idea of how to set Ubuntu 18.04/18.10/19.04 etc to have everything needed for a full install.

I am not making this a script because it should probably be run at most several lines at a time and I haven't tested the entire sequence (yet). Some lines require user input.

```
./change_directory_names.sh
cd ../../
cd documents/dotfiles
ln -sfn "$PWD/user-dirs.dirs" ~/.config
sudo apt update
sudo apt install git build-essential i3 python3-pip python-pip zathura \
  compton xdotool subversion openssh-server ruby-dev curl sqlite3 libx11-dev \
  libxft-dev xsel xcalib cmake flameshot mpv openvpn hsetroot \
  unclutter
sudo add-apt-repository ppa:neovim-ppa/unstable && sudo apt install neovim
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
pip3 install pynvim neovim-remote thefuck evdev bidict watchdog recordclass \
  rtv cmakelint py3status youtube-dl tox bpython
sudo python3 -m pip install --upgrade openpyn
sudo openpyn --init
pip2 install pynvim
sudo apt-get install libxcb-render0-dev libffi-dev python-dev python-cffi && \
  pip3 install flashfocus
sudo gem install neovim
curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.34.0/install.sh \
  | bash
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
nvm install --lts
npm i -g tldr bash-language-server neovim insect
curl -o- -L https://yarnpkg.com/install.sh | bash
cd .. && sudo ln -sf "$PWD/root_configs/etc/udev/rules.d/85-input.rules" \
  /etc/udev/rules.d/85-input.rules && cd install
sudo usermod -aG input $USER
curl -L -o ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
curl https://sh.rustup.rs -sSf | sh -s -- -y
~/.cargo/bin/cargo install bat exa ripgrep fd-find sd
sudo apt install -y  git-core gcc make autoconf yodl libncursesw5-dev texinfo \
  man-db
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
    make && make check && sudo make install && \
    command -v zsh | sudo tee -a /etc/shells && chsh -s $(command -v zsh) &&
    cd ..
git clone https://github.com/universal-ctags/ctags.git && cd ctags \
  && ./autogen.sh && ./configure && make && sudo make install && cd ..
git clone https://github.com/karlch/vimiv && cd vimiv && make && \
  sudo make install && cd ..
cd ..
./install.sh main
source ~/.profile
cd ~/.local/etc/st/ && make && sudo make install && cd - && sudo \
  update-alternatives --install /usr/bin/x-terminal-emulator \
  x-terminal-emulator /usr/local/bin/st 300
cd ~/.local/etc/ && git clone https://github.com/qutebrowser/qutebrowser &&
  cd qutebrowser && tox -e mkvenv-pypi && echo '#!/bin/bash
curl -L https://sw.kovidgoyal.net/kitty/installer.sh | sh /dev/stdin && 
  ln -s ~/.local/kitty.app/bin/kitty ~/.local/bin/ && 
  cp ~/.local/kitty.app/share/applications/kitty.desktop \
  ~/.local/share/applications && (cd ~/.local/bin/ && 
  ln -s kitty x-terminal-emulator) && rm -rf ~/.config/kitty/
~/.local/etc/qutebrowser/.venv/bin/python3 -m qutebrowser $@' > \
  ~/.local/bin/qutebrowser && chmod +x ~/.local/bin/qutebrowser && cd -
nvim +PlugInstall +qa
cd ~/.fzf && ./install --all && cd -
bat cache --build
sudo update-alternatives --install /usr/bin/editor editor ~/scripts/editor 300
```

Additional language servers and watchmen for coc may also be desirable. Consider changing to
```
GRUB_CMDLINE_LINUX_DEFAULT="text"
```
in `/etc/default/grub`. Also consider no mitigations along the lines of: 
`pti=off spectre_v2=off l1tf=off nospec_store_bypass_disable no_stf_barrier`.

Consider changing the contents of `/etc/sysctl.d/10-ptrace.conf` from `... = 1` to `... = 0`.
Consider running:
```
echo 999999 | sudo tee -a /proc/sys/fs/inotify/max_user_watches && echo 999999 | sudo tee -a /proc/sys/fs/inotify/max_queued_events && echo 999999 | sudo tee -a /proc/sys/fs/inotify/max_user_instances && watchman shutdown-server && sudo sysctl -p
```
Consider running the following to remove ubuntu bloat:
```
sudo apt purge gnome*
sudo apt purge snapd ubuntu-core-launcher squashfs-tools
sudo apt purge plymouth*
```

The following can speed up boot time (docker will need to be manually started)
```
sudo systemctl disable docker.socket
sudo systemctl disable docker.service
sudo systemctl disable NetworkManager-wait-online.service
systemd stop systemd-timesyncd
systemctl disable systemd-timesyncd
```
Consider installing some of the rust binaries to a global bin directory so that
sudo aliases don't cause ls to fail etc.
Considering installing [cling](https://github.com/root-project/cling#installation).
Consider installing lld (the LLVM Linker) and setting it as default using update alternatives.
