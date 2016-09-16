alias reload='source ~/.bash_profile && echo "Reloaded ~/.bash_profile"'

alias l='ls -l'
alias ll='ls -la'
alias lrt='ls -lrt'

alias ..='cd ..'
alias cd..='cd ..'

alias cp='cp -i'
alias mv='mv -i'
alias rm='rm -i'

alias du='du -hc'
alias more='less'

alias lc='wc -l'

export CLICOLOR=1
export LSCOLORS=gxgxcxdxbxegedabagacad

ed() { emacsclient -qc "$@" & }

et() { emacsclient -t "$@"; }

if [ -e /usr/bin/gnome-open ]; then
  function o() {
    gnome-open $* >& /dev/null
  }
else
  alias o='open'
fi
