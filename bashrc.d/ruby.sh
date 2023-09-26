# Inspiration from http://github.com/hashrocket/dotmatrix/blob/master/.hashrc

alias rc='rails console'
alias rg='rails generate'
alias rd='rails destroy'
alias rs='rails server'
alias rdb='rails dbconsole -p'
alias rrg='rails routes -g'

#alias ss='spring stop'

function os() {
  if [ -f Procfile.dev ]; then
    overmind start -f Procfile.dev $*
  else
    overmind start $*
  fi
}

alias dm='rake db:migrate'
alias dmt='rake db:test:prepare'
alias dmu='rake db:rollback'
alias dmr='rake db:migrate:redo'

alias gua='bundle exec guard'

alias tt='[ -e log/test.log ] && cp -f /dev/null log/test.log && tail -f log/test.log'

alias rup='git up; bundle install; yarn install; rake db:migrate'

# decent MRI GC settings for faster local development/test
export RUBY_GC_MALLOC_LIMIT_MAX=90000000
export RUBY_GC_HEAP_FREE_SLOTS=200000
