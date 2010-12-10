if [ $SSH_TTY ]; then
  PS1="$RED\u@\h $LIGHTGRAY\w $BROWN\$(current_git_branch)$YELLOW\$(git_modifications)$BLUE$ $NC"
else
  PS1="$GREEN\h $LIGHTGRAY\w $BROWN\$(current_git_branch)$YELLOW\$(git_modifications)$BLUE$ $NC"
fi
