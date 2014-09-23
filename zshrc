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
if (( ${+commands[keychain]} )); then
    if [[ -d $HOME/.ssh ]]; then
        if [[ -f $HOME/.ssh/id_dsa ]]; then
            eval `keychain --eval --nogui -Q -q ~/.ssh/id_dsa`
        elif [[ -f $HOME/.ssh/id_rsa ]]; then
            eval `keychain --eval --nogui -Q -q ~/.ssh/id_rsa`
        fi
    fi
fi
# prompt {{{1
. $ZDOTDIR/zsh.d/prompt.zsh
# edit-command-line {{{1
autoload -U edit-command-line
zle -N edit-command-line
bindkey '\C-x\C-e' edit-command-line
# zsh-history-substring-search {{{1
if [[ -d $ZDOTDIR/zsh-history-substring-search ]]; then
        source $ZDOTDIR/zsh-history-substring-search/zsh-history-substring-search.zsh
        bindkey '^P' history-substring-search-up
        bindkey '^N' history-substring-search-down
fi
# autoenv {{{1
if [[ -f $ZDOTDIR/autoenv/activate.sh ]]; then
        source $ZDOTDIR/autoenv/activate.sh
fi
# z (the new j, yo!) {{{1
if [[ -f $ZDOTDIR/z/z.sh ]]; then
        _Z_CMD='j'
        . $ZDOTDIR/z/z.sh
fi
# marks {{{1
. $ZDOTDIR/zsh.d/marks.zsh
# teamocil {{{1
export TEAMOCIL_PATH=$ZDOTDIR/teamocil
# completions for proj {{{2
_proj_cpl() {
        reply=($HOME/work/*(/:t))
        reply+=("zsh" "vim" "tmux")
}
compctl -K _proj_cpl proj
# modeline {{{1
# vim: fdm=marker:fdl=0
