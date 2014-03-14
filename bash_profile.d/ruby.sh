# Inspiration from http://github.com/hashrocket/dotmatrix/blob/master/.hashrc

export BUNDLER_EDITOR="mvim"

rails_root() {
  (
    dir=${1:-$(pwd)}
    i=0
    while [ "/" != "$dir" -a "$i" -ne 16 ]; do
      if [ -f "$dir/config/environment.rb" ]; then
        echo "$dir"
        return 0
      fi
      dir="$(dirname "$dir")"
      i=$(expr $i + 1)
    done
    echo "* Does not appear to be a Rails project" >&2
    return 1
  )
}


script_rails() {
  rails_root=`rails_root`
  if [ -f "$rails_root/script/rails" ]; then
    "$rails_root/script/rails" "$@"
  elif [ -f "$rails_root/bin/rails" ]; then
    "$rails_root/bin/rails" "$@"
  elif [ -f "$rails_root/script/$1" ]; then
    local name
    name="$1"
    shift
    "$rails_root/script/$name" "$@"
  else
    return 1
  fi
}

alias rc='script_rails console'
alias rg='script_rails generate'
alias rd='script_rails destroy'
alias rs='script_rails server'
alias rdb='script_rails dbconsole -p'

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

alias cdgems='cd `rvm gemdir`'

alias rak='ack --ruby --cucumber'
alias wak='ack --web'
alias rak-no-test='ack --ignore-dir=test --ruby'
alias rgrep='grep -rnH'

# decent MRI GC settings for faster local development/test
export RUBY_GC_MALLOC_LIMIT_MAX=90000000
export RUBY_GC_HEAP_FREE_SLOTS=200000
# For pre 2.1 rubies
#export RUBY_GC_MALLOC_LIMIT=90000000
#export RUBY_FREE_MIN=200000
