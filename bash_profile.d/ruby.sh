# Inspiration from http://github.com/hashrocket/dotmatrix/blob/master/.hashrc

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
  elif [ -f "$rails_root/script/$1" ]; then
    local name
    name="$1"
    shift
    "$rails_root/script/$name" "$@"
  else
    return 1
  fi
}

alias sc='script_rails console'
alias sg='script_rails generate'
alias ss='script_rails server'
alias sdc='script_rails dbconsole -p'

alias dm='rake db:migrate'
alias dtp='rake db:test:prepare'
alias dmtp='dm && dtp'

alias ett='mate app config lib db public spec test vendor/plugins config.ru Rakefile Capfile Gemfile README'
alias tt='[ -e log/test.log ] && cp -f /dev/null log/test.log && tail -f log/test.log'

alias r='rake'
alias rs='rake spec'
# alias s='spec'
alias t='time testrb -Itest'
# alias c='cucumber'
alias cwip='cucumber --tags @wip'

alias cdgems='cd `rvm gemdir`'

alias rak='ack --ruby'
alias wak='ack --web'
alias rak-no-test='ack --ignore-dir=test --ruby'
alias rgrep='grep -rnH'
