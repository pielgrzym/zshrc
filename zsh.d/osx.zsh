zstyle ':completion:*:*:*:*:processes' command "ps -A"
alias ll='ls -lh'
alias l="ls -h -1"
alias df="df -h"
RPROMPT='$(battery_prompt)'
