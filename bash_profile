# ~/.bash_profile: executed by bash(1) for login shells.

[[ -s "$HOME/.bashrc" ]] && source "$HOME/.bashrc"

for a in `ls $HOME/.bash_profile.d/*.sh`; do
  source $a
done

export VISUAL="vim +1"
export EDITOR=$VISUAL
export GIT_EDITOR="vim +1"

if [[ -d ~/.rvm/bin ]] ; then
  PATH=~/.rvm/bin:$PATH
fi
if [[ -d ~/.npm-packages/bin ]]; then
  export PATH=~/.npm-packages/bin:$PATH
fi
if [[ -d ~/.local/bin ]] ; then
  PATH=~/.local/bin:$PATH
fi
export PATH=~/bin:/usr/local/bin:/usr/local/sbin:$PATH


if [[ $(uname -s) == 'Darwin' ]]; then
  ulimit -n 10240
fi

if [ -n "$DISPLAY" -a "$TERM" == "xterm" ]; then
  export TERM=xterm-256color
fi

if [[ -s ~/.rvm/scripts/rvm ]] ; then source ~/.rvm/scripts/rvm ; fi

if [[ -s /usr/local/share/chruby/chruby.sh ]]; then
  source /usr/local/share/chruby/chruby.sh;
  chruby 2.3.1
fi

if [ -e /home/darren/.nix-profile/etc/profile.d/nix.sh ]; then
  source /home/darren/.nix-profile/etc/profile.d/nix.sh
  export MANPATH=/home/darren/.nix-profile/share/man:$MANPATH
fi # added by Nix installer

if [[ `which direnv` ]]; then
  eval "$(direnv hook bash)"
fi

### Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"
