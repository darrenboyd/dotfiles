# Inspiration from http://github.com/hashrocket/dotmatrix/blob/master/.hashrc

alias rc='spring rails console'
alias rg='spring rails generate'
alias rd='spring rails destroy'
alias rs='spring rails server'
alias rdb='spring rails dbconsole -p'

alias ss='spring stop'

function fs() {
  if [ -f Procfile.dev ]; then
    foreman start -f Procfile.dev $*
  else
    foreman start $*
  fi
}

alias dm='spring rake db:migrate'
alias dmt='spring rake db:test:prepare'
alias dmu='spring rake db:rollback'
alias dmr='spring rake db:migrate:redo'

alias gua='bundle exec guard'

alias tt='[ -e log/test.log ] && cp -f /dev/null log/test.log && tail -f log/test.log'

# decent MRI GC settings for faster local development/test
export RUBY_GC_MALLOC_LIMIT_MAX=90000000
export RUBY_GC_HEAP_FREE_SLOTS=200000


if [[ -d ~/.yarn/bin ]]; then
    export PATH=~/.yarn/bin:$PATH
fi
