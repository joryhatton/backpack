# backpack
<img src="https://static.thenounproject.com/png/47008-200.png" width="120" />

A shell script to automate the setup of new development environments. Read more [here](https://medium.com/@fulstop/quick-and-painless-linux-development-1c576b479f6c).

``` shell
# install and run it for the first time
git clone git@github.com:fulstop/backpack.git ~/dotfiles/backpack
~/dotfiles/backpack/backpack.sh

# once installed it can be run with
backpack
```

Backpack makes a few assumptions out of the box:
- You _are_ using a Debian or Ubuntu based distro.
- You're going to be using ruby.
- You're going to be using git.
- You're going to be using zsh, vim, and tmux.

Backpack is best served within an existing `~/dotfiles` directory. See [mine](https://github.com/fulstop/dotfiles) as an example.
