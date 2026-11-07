# Use the desktop's ssh agent (gcr-ssh-agent) unless one is already set.
if [ -z "${SSH_AUTH_SOCK:-}" ] && [ -n "${XDG_RUNTIME_DIR:-}" ] && [ -S "$XDG_RUNTIME_DIR/gcr/ssh" ]; then
  export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/gcr/ssh"
fi
