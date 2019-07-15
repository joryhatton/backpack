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
sudo apt-get install vim
sudo apt-get install git
sudo apt-get install wget
sudo apt-get install curl
sudo apt-get install postgresql
sudo apt-get install postgresql-client
sudo apt-get install libpq-dev
sudo apt-get install zsh
sudo apt-get install tmux
sudo apt-get install redis
sudo apt-get install redis-server
sudo apt-get install neofetch
sudo apt-get install -y libssl-dev libreadline-dev zlib1g-dev

# start postgres and redis
sudo service postgresql restart
sudo service redis-server restart
sudo update-rc.d postgresql enable

# vim
if [ -f ~/.vimrc ]
  echo 'Vim already configured'
then
  # ripgrep
  curl -LO https://github.com/BurntSushi/ripgrep/releases/download/0.10.0/ripgrep_0.10.0_amd64.deb
  sudo dpkg -i ripgrep_0.10.0_amd64.deb
  rm ripgrep_0.10.0_amd64.deb
  ln -fs ~/dotfiles/vimrc ~/.vimrc
fi

# vim
if [ -d ~/.vim/autoload ]
then
  echo 'Vim already configured'
else
  mkdir ~/.vim
  curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
fi

# tmux
if [ -f ~/tmux.conf  ]
  echo 'Tmux already configured'
then
  ln -fs ~/dotfiles/tmux.conf ~/.tmux.conf
  tmux source ~/.tmux.conf
fi

# tmux
if [ -d ~/.tmux/plugins ]
then
  echo 'Tmux already configured'
else
  git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
fi

# ruby
if [ -d ~/.rbenv ]
then
  echo 'Ruby already configured'
else
  git clone https://github.com/rbenv/rbenv.git ~/.rbenv
  mkdir -p ~/.rbenv/plugins
  git clone https://github.com/rbenv/ruby-build.git ~/.rbenv/plugins/ruby-build
fi

# zsh
if [ -f ~/.zhsrc ]
then
  echo 'Zsh already configured'
else
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
  chsh -s "$(which zsh)"
  rm ~/.zshrc
  ln -fs ~/dotfiles/zshrc ~/.zshrc
fi

# nodejs
curl -sL https://deb.nodesource.com/setup_8.x | sudo -E bash -
sudo apt-get install -y nodejs

sudo apt-get clean
sudo apt-get autoremove

echo
echo ' _                 _                       _     '
echo '| |               | |                     | |    '
echo '| | _   ____  ____| |  _ ____   ____  ____| |  _ '
echo '| || \ / _  |/ ___) | / )  _ \ / _  |/ ___) | / )'
echo '| |_) | ( | ( (___| |< (| | | ( ( | ( (___| |< ( '
echo '|____/ \_||_|\____)_| \_) ||_/ \_||_|\____)_| \_)'
echo '                        |_|                      '
echo
echo "Thanks for using backpack! You're all set!"
echo 'Contribute to the project at https://github.com/fulstop/backpack'

source ~/.zshrc
