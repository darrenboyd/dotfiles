if [[ -d "$HOME/.fly" ]]; then
    export FLYCTL_INSTALL="$HOME/.fly"
    export PATH="$FLYCTL_INSTALL/bin:$PATH"
fi
