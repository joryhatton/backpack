#!/bin/bash
echo ' _                 _                       _     '
echo '| |               | |                     | |    '
echo '| | _   ____  ____| |  _ ____   ____  ____| |  _ '
echo '| || \ / _  |/ ___) | / )  _ \ / _  |/ ___) | / )'
echo '| |_) | ( | ( (___| |< (| | | ( ( | ( (___| |< ( '
echo '|____/ \_||_|\____)_| \_) ||_/ \_||_|\____)_| \_)'
echo '                        |_|                      '
echo

sudo apt-get update
sudo apt-get upgrade

sudo apt-get install build-essential
sudo apt-get install git git-core vim git wget curl
sudo apt-get install postgresql
sudo apt-get install postgresql-client
sudo apt-get install libpq-dev
sudo apt-get install zsh
sudo apt-get install tmux
sudo apt-get install redis
sudo apt-get install redis-server
sudo apt-get install neofetch
sudo apt-get install -y libssl-dev libreadline-dev zlib1g-dev
sudo apt-get install libyaml-dev libsqlite3-dev libxml2-dev
sudo apt-get install libxslt1-dev libcurl4-openssl-dev libffi-dev

# docker
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
sudo apt-get update
sudo apt-get install docker-ce docker-ce-cli containerd.io
# and docker compose
sudo curl -L "https://github.com/docker/compose/releases/download/1.24.1/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose

# free tds
wget http://www.freetds.org/files/stable/freetds-1.1.6.tar.gz
tar -xzf freetds-1.1.6.tar.gz
cd freetds-1.1.6
./configure --prefix=/usr/local --with-tdsver=7.3
make
sudo make install
cd ../
rm freetds-1.1.6.tar.gz
rm -rf freetds-1.1.6

# start postgres and redis
sudo service postgresql restart
sudo service redis-server restart
sudo update-rc.d postgresql enable

# nodejs
curl -sL https://deb.nodesource.com/setup_8.x | sudo -E bash -
sudo apt-get install -y nodejs

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

sudo apt-get clean
sudo apt-get autoremove

# install zsh at the end
printf '# Switch to ZSH shell\nif test -t 1; then exec zsh; fi' >> ~/.bashrc
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

if [ -f ~/dotfiles/zshrc ]
then
  rm ~/.zshrc
  ln -fs ~/dotfiles/zshrc ~/.zshrc
fi
