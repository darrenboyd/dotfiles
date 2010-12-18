
alias gi='git init && printf ".DS_Store\nThumbs.db\n" >> .gitignore && git add .gitignore'


# http://www.jukie.net/~bart/blog/pimping-out-git-log
alias gl="git log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%an %cr)%Creset' --abbrev-commit --date=relative"
alias glp='gl -p'

alias gst='git status'
alias gs='git status'
alias gd='git diff --color-words'
alias gds='git diff --color-words --cached'
alias gdh='git diff --color-words HEAD'

alias ga='git add'
alias gap='git add -p'
alias gc='git commit -v'
alias gca='gc -a'

alias gco="git checkout"
alias gcop="git checkout -p"

alias gp='git pull --rebase || (notify "pull failed" "Git" && false)'
alias gu='git push origin HEAD || (notify "push failed" "Git" && false)'
alias gpru='gp && rake && gu'
alias gri='git rebase -i origin/master^'
alias grc='git rebase --continue'

alias gb='git branch'
complete -o default -o nospace -F _git_branch gb

alias gitx='gitx --all'

ggc() {
  set -- `du -ks`
  before=$1
  git reflog expire --expire=1.minute refs/heads/master && git fsck --unreachable && git prune && git gc 
  set -- `du -ks`
  after=$1
  echo "Cleaned up $((before-after)) kb."
}

# Might use this, but we already have grb
# grb() {
#   git push origin HEAD:refs/heads/$1
#   git fetch origin &&
#   git checkout -b $1 --track origin/$1
# }

current_git_branch() {
  git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/'
}

git_commits_ahead() {
  git status 2> /dev/null | grep ahead | sed -e 's/.*by \([0-9]\{1,\}\) commits\{0,1\}\./\1/'
}

# Roughly from git_completion
git_dirty_state() {
  local w
  w=''
  local g="$(__gitdir)"
  if [ -n "$g" ]; then
    git diff --no-ext-diff --quiet --exit-code || w="+"
    if git rev-parse --quiet --verify HEAD >/dev/null; then
      git diff-index --cached --quiet HEAD -- || w="+"
    fi
  fi
  echo -n $w
}

git_modifications() {
  wrap_unless_empty "`git_commits_ahead`" "`git_dirty_state`"
}
wrap_unless_empty() {
  if [ -n "$1" ] || [ -n "$2" ] || [ -n "$3" ] || [ -n "$4" ]; then
    echo -n "($1$2$3$4)"
  fi
}
