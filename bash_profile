# ~/.bash_profile: executed by bash(1) for login shells.

[[ -s "$HOME/.bashrc" ]] && source "$HOME/.bashrc"

for a in `ls $HOME/.bash_profile.d/*.sh`; do
  source $a
done

export VISUAL="vim +1"
export EDITOR=$VISUAL
export GIT_EDITOR="vim +1"

if [[ -d ~/.npm-packages/bin ]]; then
  export PATH=~/.npm-packages/bin:$PATH
fi
if [[ -d ~/.local/bin ]] ; then
  PATH=~/.local/bin:$PATH
fi
if [[ -d ~/.node-packages/bin ]] ; then
  PATH=~/.node-packages/bin:$PATH
fi
export PATH=~/bin:/usr/local/bin:/usr/local/sbin:$PATH


if [[ $(uname -s) == 'Darwin' ]]; then
  ulimit -n 10240
fi

if [ -n "$DISPLAY" -a "$TERM" == "xterm" ]; then
  export TERM=xterm-256color
fi

#
# if [[ -s ~/.rvm/scripts/rvm ]]; then
#    source ~/.rvm/scripts/rvm ;
# fi
#