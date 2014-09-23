export GREP_OPTIONS='--color=auto'
export GREP_COLOR='1;32'
bindkey -v # vi style keybindings
export EDITOR=vim # the only true editor
setopt long_list_jobs
autoload -U select-word-style
select-word-style s # split words by shell arguments instead of spaces
setopt no_beep # no bling bling
export PAGER=less
export LESS=-r # fix ipython pager
# smart urls 
autoload -U url-quote-magic
zle -N self-insert url-quote-magic
# gpg pinentry
# I HATE YOU pinentry-curses
# export GPG_TTY=$(tty)
# edit-command-line ftw
autoload -U edit-command-line
zle -N edit-command-line
bindkey '\C-x\C-e' edit-command-line
