# http://gist.github.com/124422

# Can't get it to work in iTerm.
# nt() {
#   terminal_clone_command="
# tell application \"iTerm\"
# tell application \"System Events\" to tell process \"iTerm\" to keystroke \"t\" using command down
# do script with command \"cd `pwd`\" in selected tab of the front window
# end tell
# "
#   echo "$terminal_clone_command" | osascript 
# }