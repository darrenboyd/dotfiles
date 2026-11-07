export VISUAL="vim +1"
export EDITOR=$VISUAL
export GIT_EDITOR="vim +1"

if [[ $(uname -s) == 'Darwin' ]]; then
  ulimit -n 10240
fi

if [ -n "$DISPLAY" -a "$TERM" == "xterm" ]; then
  export TERM=xterm-256color
fi
