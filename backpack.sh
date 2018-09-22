#!/bin/bash
echo ' _                 _                       _     '
echo '| |               | |                     | |    '
echo '| | _   ____  ____| |  _ ____   ____  ____| |  _ '
echo '| || \ / _  |/ ___) | / )  _ \ / _  |/ ___) | / )'
echo '| |_) | ( | ( (___| |< (| | | ( ( | ( (___| |< ( '
echo '|____/ \_||_|\____)_| \_) ||_/ \_||_|\____)_| \_)'
echo '                        |_|                      '
echo
echo

echo '#### updating system ####'
echo
sudo apt-get update
sudo apt-get upgrade
echo
echo '#### DONE ####'
echo
echo

echo '#### installing core packages ####'
echo

sudo apt-get install build-essential
sudo apt-get install vim
sudo apt-get install git
sudo apt-get install wget
sudo apt-get install curl
sudo apt-get install postgresql
sudo apt-get install zsh
sudo apt-get install tmux
sudo apt-get install libpq-dev
sudo apt-get install redis
sudo apt-get install neofetch
echo
echo '#### DONE ####'
echo
echo

echo '#### set up nodejs ####'
echo

curl -sL https://deb.nodesource.com/setup_8.x | sudo -E bash -
sudo apt-get install -y nodejs
echo
echo '#### DONE ####'
echo
echo

echo '#### set up zsh ####'
echo

if [ -d ~/.oh-my-zsh ]
then
  echo 'NOTE: zsh already configured'
else
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
  chsh -s "$(which zsh)"
  rm ~/.zshrc
  ln -fs ~/dotfiles/zshrc ~/.zshrc
fi
echo
echo '#### DONE ####'
echo
echo

echo '#### set up vim ####'
echo

if [ -d ~/.vim/autoload ]
then
  echo 'NOTE: vim already configured'
else
  mkdir ~/.vim
  curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
fi

if [ -f ~/dotfiles/vimrc ]
then
  ln -fs ~/dotfiles/vimrc ~/.vimrc
fi
echo
echo '#### DONE ####'
echo
echo

echo '#### set up git ####'
echo

if [ -f ~/dotfiles/gitconfig ]
then
  ln -fs ~/dotfiles/gitconfig ~/.gitconfig
fi

if [ -f ~/.gitconfig.local ]
then
  echo 'NOTE: git already configured'
else
  echo '[user]' >> ~/.gitconfig.local
  echo 'What is your full name used on GitHub?'
  read ghubfullname
  echo "  name = $ghubfullname" >> ~/.gitconfig.local
  echo 'What is your GitHub username?'
  read ghubusername
  echo "  username = $ghubusername" >> ~/.gitconfig.local
  echo 'What is your GitHub email?'
  read ghubemail
  echo "  email = $ghubemail" >> ~/.gitconfig.local
fi

echo
echo '#### DONE ####'
echo
echo

echo '#### set up tmux ####'
echo

if [ -f ~/dotfiles/tmux.conf  ]
then
  ln -fs ~/dotfiles/tmux.conf ~/.tmux.conf
fi

if [ -d ~/.tmux/plugins ]
then
  echo 'NOTE: tmux already configured'
else
  git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
fi

tmux source ~/.tmux.conf

echo
echo '#### DONE ####'
echo
echo

echo '#### set up ruby ####'
echo

if [ -d ~/.rbenv ]
then
  echo 'NOTE: ruby already configured'
else
  git clone https://github.com/rbenv/rbenv.git ~/.rbenv
  mkdir -p "$(rbenv root)"/plugins
  git clone https://github.com/rbenv/ruby-build.git "$(rbenv root)"/plugins/ruby-build
fi
echo
echo '#### DONE ####'
echo
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
