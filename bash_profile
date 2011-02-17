for a in `ls $HOME/.bash_profile.d/*.sh`; do 
  source $a
done

export VISUAL='mate -w'
export EDITOR=$VISUAL
export GIT_EDITOR='mate -wl1'
export GEMEDITOR='mate'

export PATH=~/bin:$PATH

if [[ -s ~/.rvm/scripts/rvm ]] ; then source ~/.rvm/scripts/rvm ; fi
