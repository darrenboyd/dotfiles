export HISTFILESIZE=5000
export HISTCONTROL=ignoreboth:ignoredups:erasedups
shopt -s histappend
shopt -s cmdhist
shopt -s cdspell
export PROMPT_COMMAND="history -a;$PROMPT_COMMAND"
