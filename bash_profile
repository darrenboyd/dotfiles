
for a in `ls $HOME/.bash_profile.d/*.sh`; do 
  source $a
done

export VISUAL="vim +1"
export EDITOR=$VISUAL
export GIT_EDITOR="vim +1"
export GEMEDITOR='mvim'

export PATH=~/bin:/usr/local/bin:/usr/local/sbin:$PATH

ulimit -n 10240

if [[ -s ~/.rvm/scripts/rvm ]] ; then source ~/.rvm/scripts/rvm ; fi

eval "$(direnv hook bash)"
