#!/bin/bash
echo ' _                 _                       _     '
echo '| |               | |                     | |    '
echo '| | _   ____  ____| |  _ ____   ____  ____| |  _ '
echo '| || \ / _  |/ ___) | / )  _ \ / _  |/ ___) | / )'
echo '| |_) | ( | ( (___| |< (| | | ( ( | ( (___| |< ( '
echo '|____/ \_||_|\____)_| \_) ||_/ \_||_|\____)_| \_)'
echo '                        |_|                      '
echo

sudo apt-get update && upgrade -y
sudo apt-get install -y build-essential \
vim zsh tmux git git-core \
wget curl neofetch \
mongodb postgresql postgresql-client redis redis-server \
python3.6 python-pip python3-venv \
libpq-dev libssl-dev libreadline-dev zlib1g-dev \
libyaml-dev libsqlite3-dev libxml2-dev \
libxslt1-dev libcurl4-openssl-dev libffi-dev

# azure cli
curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash

# docker
./docker.sh

# nodejs
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.35.2/install.sh | bash
nvm install node
nvm install-latest-npm

# vim
ln -fs ~/dotfiles/vimrc ~/.vimrc

if [ -d ~/.vim/autoload ]
then
  echo 'Vim plugins already configured'
else
  mkdir ~/.vim
  curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
fi

# ripgrep
curl -LO https://github.com/BurntSushi/ripgrep/releases/download/0.10.0/ripgrep_0.10.0_amd64.deb
sudo dpkg -i ripgrep_0.10.0_amd64.deb
rm ripgrep_0.10.0_amd64.deb

# tmux
if [ -f ~/.tmux.conf  ]
  echo 'Tmux already configured'
then
  ln -fs ~/dotfiles/tmux.conf ~/.tmux.conf
  tmux source ~/.tmux.conf
fi

# tmux
if [ -d ~/.tmux/plugins/tpm ]
then
  echo 'Tmux plugins already configured'
else
  git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
fi

# rbenv
if [ -d ~/.rbenv ]
then
  echo 'Rbenv already configured'
  ~/.rbenv/bin/rbenv init
else
  git clone https://github.com/rbenv/rbenv.git ~/.rbenv
  mkdir -p ~/.rbenv/plugins
  git clone https://github.com/rbenv/ruby-build.git ~/.rbenv/plugins/ruby-build
  ~/.rbenv/bin/rbenv init
fi

# gitconfig
if [ -d ~/dotfiles/gitconfig ]
then
  ln -s ~/dotfiles/gitconfig ~/.gitconfig
fi

sudo apt-get clean -y
sudo apt-get autoremove -y

# install zsh at the end
printf '# Switch to ZSH shell\nif test -t 1; then exec zsh; fi' >> ~/.bashrc
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

if [ -f ~/dotfiles/zshrc ]
then
  rm ~/.zshrc
  ln -fs ~/dotfiles/zshrc ~/.zshrc
fi

exec zsh
