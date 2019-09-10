if [ $SSH_TTY ]; then
  PS1="$GREEN\h $LIGHTGRAY\w $BROWN\$(current_git_branch)$YELLOW\$(git_special)$BLUE⚡ $NC"
else
  PS1="$GREEN\h $LIGHTGRAY\w $BROWN\$(current_git_branch)$YELLOW\$(git_special)$BLUE⚡ $NC"
fi
