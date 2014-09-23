# colors {{{1
autoload colors
colors
. $ZDOTDIR/zsh.d/nice_colors.zsh
# path {{{1
PATH=$ZDOTDIR/bin:$PATH
# completion {{{1
. $ZDOTDIR/zsh.d/completions.zsh
# rly? {{{1
. $ZDOTDIR/zsh.d/rly.zsh
# extract {{{1
. $ZDOTDIR/zsh.d/extract.zsh
# smart sudo {{{1
. $ZDOTDIR/zsh.d/smart_sudo.zsh
# aliases {{{1
. $ZDOTDIR/zsh.d/aliases.zsh
# directories {{{1
. $ZDOTDIR/zsh.d/dirstack.zsh
# grep {{{1
export GREP_OPTIONS='--color=auto'
export GREP_COLOR='1;32'
bindkey -v
# history {{{1
. $ZDOTDIR/zsh.d/history.zsh
. $ZDOTDIR/zsh.d/history_branching.zsh
# misc settings {{{1
## smart urls
export EDITOR=vim
autoload -U url-quote-magic
zle -N self-insert url-quote-magic
## jobs
setopt long_list_jobs
# Make things split words by shell arguments, not spaces
autoload -U select-word-style
select-word-style s
setopt no_beep
# got to observe if theese actually make any performance difference:
#setopt multios
#setopt cdablevarS
## pager
export PAGER=less
# fix ipython pager
export LESS=-r
# insert sudo widget {{{1
insert_sudo () { zle beginning-of-line; zle -U "s " }
zle -N insert-sudo insert_sudo
bindkey "^Xs" insert-sudo
bindkey '^i' complete-word # this is *VERY* important - cant remember why (:
# fast directory ascension {{{1
. $ZDOTDIR/zsh.d/fast_updir.zsh
# gpg pinentry {{{1
# I HATE YOU pinentry-curses
# export GPG_TTY=$(tty)
# keychain {{{1
. $ZDOTDIR/zsh.d/keychain.zsh
# marks {{{1
. $ZDOTDIR/zsh.d/marks.zsh
# prompt {{{1
. $ZDOTDIR/zsh.d/prompt.zsh
# edit-command-line {{{1
autoload -U edit-command-line
zle -N edit-command-line
bindkey '\C-x\C-e' edit-command-line
# modules {{{1
export MYZMODULES=$ZDOTDIR/modules
# zsh-history-substring-search {{{2
if [[ -d $MYZMODULES/zsh-history-substring-search ]]; then
        source $MYZMODULES/zsh-history-substring-search/zsh-history-substring-search.zsh
        bindkey '^P' history-substring-search-up
        bindkey '^N' history-substring-search-down
fi
# autoenv {{{2
if [[ -f $MYZMODULES/autoenv/activate.sh ]]; then
        source $MYZMODULES/autoenv/activate.sh
fi
# z (the new j, yo!) {{{2
if [[ -f $MYZMODULES/z/z.sh ]]; then
        _Z_CMD='j'
        . $MYZMODULES/z/z.sh 
fi
# modeline {{{1
# vim: fdm=marker:fdl=0
