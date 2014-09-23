zstyle ':completion:*:*:*:*:processes' command "ps -A"
RPROMPT='$(battery_prompt)'
if type gls > /dev/null; then # osx gnu coreutils installed
    alias ls='\gls -h --color=auto'
    alias ll='\gls -lh --color=auto'
    alias l='\gls -h -1 --color=auto'
else # crappy osx ls installed
    alias ls="ls -h -G"
    alias ll='ls -lh -G'
    alias l="ls -h -1 -G"
fi
unalias tmux
