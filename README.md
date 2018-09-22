# Backpack
![backpack](https://static.thenounproject.com/png/2551-200.png)

A shell script to automate the setup of new development environments.

Install and run it with:
``` shell
git clone git@github.com:fulstop/backpack.git ~/dotfiles/backpack
~/dotfiles/backpack/backpack.sh
```

Backpack makes a few assumptions out of the box:
- You _are_ using a Debian or Ubuntu based distro.
- You're going to be using ruby.
- You're going to be using git.
- You're going to be using zsh, vim, and tmux.

The ideal place for Backpack is within a `~/dotfiles` directory. See [mine](https://github.com/fulstop/dotfiles) as an example.
