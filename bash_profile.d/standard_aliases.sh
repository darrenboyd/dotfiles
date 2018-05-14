alias reload='source ~/.bash_profile && echo "Reloaded ~/.bash_profile"'

alias l='ls -lh'
alias ll='ls -lha'
alias lrt='ls -lhrt'

alias ..='cd ..'
alias cd..='cd ..'

alias cp='cp -i'
alias mv='mv -i'
alias rm='rm -i'

alias du='du -hc'
alias more='less'

alias lc='wc -l'

alias ed='emacs --geometry 120x48 &'

alias json-pretty='python -m json.tool'

export CLICOLOR=1
export LSCOLORS=gxgxcxdxbxegedabagacad

if [ -e /usr/bin/xdg-open ]; then
  function o() {
    xdg-open $* >& /dev/null
  }
else
  alias o='open'
fi
