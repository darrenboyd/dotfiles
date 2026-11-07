# Last, so these lead PATH (same order as before the split).
if [[ -d ~/.local/bin ]] ; then
  PATH=~/.local/bin:$PATH
fi
export PATH=~/bin:/usr/local/bin:/usr/local/sbin:$PATH

[[ -s "$HOME/.cargo/env" ]] && source "$HOME/.cargo/env"
