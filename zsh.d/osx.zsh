zstyle ':completion:*:*:*:*:processes' command "ps -A"
unalias ll
alias ll='ls -lh'
unalias l
alias l="ls -h -1"
unalias df
alias df="df -h"
RPROMPT='$(battery_prompt)'
