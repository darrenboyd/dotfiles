
[[ -s "$HOME/.profile" ]] && source "$HOME/.profile" # Load the default .profile

for a in `ls $HOME/.bash_profile.d/*.sh`; do 
  source $a
done

export VISUAL="vim +1"
export EDITOR=$VISUAL
export GIT_EDITOR="vim +1"

if [[ -d ~/.rvm/bin ]] ; then
  PATH=~/.rvm/bin:$PATH
fi
if [[ -d ~/.local/bin ]] ; then
  PATH=~/.local/bin:$PATH
fi
export PATH=~/bin:/usr/local/bin:/usr/local/sbin:~/.rvm/bin:$PATH


if [[ $(uname -s) == 'Darwin' ]]; then
  ulimit -n 10240
fi

if [[ -s ~/.rvm/scripts/rvm ]] ; then source ~/.rvm/scripts/rvm ; fi

if [[ `which direnv` ]]; then
  eval "$(direnv hook bash)"
fi
