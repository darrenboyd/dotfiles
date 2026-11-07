# mise shims on PATH for processes that never read .bashrc (Claude Code's shell, editors,
# cron, scripts). Interactive shells also get the full activation from ~/.bashrc.d/mise.sh,
# which takes precedence; the duplicate shims entry it leaves on PATH is harmless.
eval "$(~/.local/bin/mise activate bash --shims)"
