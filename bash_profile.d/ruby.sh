# Inspiration from http://github.com/hashrocket/dotmatrix/blob/master/.hashrc

export GEM_PATH=~/.gems
export GEM_HOME=~/.gems

export PATH=$GEM_HOME/bin:$PATH

alias rc='bin/rails console'
alias rg='bin/rails generate'
alias rd='bin/rails destroy'
alias rs='bin/rails server'
alias rdb='bin/rails dbconsole -p'

alias ss='spring stop'

function fs() {
  if [ -f Procfile.dev ]; then
    foreman start -f Procfile.dev $*
  else
    foreman start $*
  fi
}

alias dm='rails db:migrate'
alias dmt='rails db:test:prepare'
alias dmu='rails db:rollback'
alias dmr='rails db:migrate:redo'

alias gua='bundle exec guard'

alias tt='[ -e log/test.log ] && cp -f /dev/null log/test.log && tail -f log/test.log'

# decent MRI GC settings for faster local development/test
export RUBY_GC_MALLOC_LIMIT_MAX=90000000
export RUBY_GC_HEAP_FREE_SLOTS=200000
