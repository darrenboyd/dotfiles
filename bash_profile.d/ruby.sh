# Inspiration from http://github.com/hashrocket/dotmatrix/blob/master/.hashrc

export BUNDLER_EDITOR="mvim"

alias rc='bin/rails console'
alias rg='bin/rails generate'
alias rd='bin/rails destroy'
alias rs='bin/rails server'
alias rdb='bin/rails dbconsole -p'

function fs() {
  if [ -f Procfile.dev ]; then
    foreman start -f Procfile.dev $*
  else
    foreman start $*
  fi
}

alias dm='rake db:migrate'
alias dtp='rake db:test:prepare'
alias dmtp='dm && dtp'

alias ett='mate app config lib db public spec test vendor/plugins config.ru Rakefile Capfile Gemfile README'
alias tt='[ -e log/test.log ] && cp -f /dev/null log/test.log && tail -f log/test.log'

alias b='bundle exec'
alias br='bundle exec rake'

alias t='time testrb -Itest'
alias cuc='bundle exec cucumber -P --format pretty --quiet'

alias rgrep='grep -rnH'

# decent MRI GC settings for faster local development/test
export RUBY_GC_MALLOC_LIMIT_MAX=90000000
export RUBY_GC_HEAP_FREE_SLOTS=200000
# For pre 2.1 rubies
#export RUBY_GC_MALLOC_LIMIT=90000000
#export RUBY_FREE_MIN=200000
