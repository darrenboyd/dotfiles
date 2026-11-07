#!/bin/bash
# Status line derived from the PS1 defined in ~/.bashrc:
#   PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '

input=$(cat)
cwd=$(echo "$input" | jq -r '.cwd')

user=$(whoami)
host=$(hostname -s)

chroot_prefix=""
if [ -n "$debian_chroot" ]; then
  chroot_prefix="($debian_chroot)"
fi

# Colors are dimmed by Claude Code's status line rendering, so bold/bright
# ANSI codes from the original PS1 are kept as-is rather than toned down.
printf '%s\033[01;32m%s@%s\033[00m:\033[01;34m%s\033[00m' "$chroot_prefix" "$user" "$host" "$cwd"
