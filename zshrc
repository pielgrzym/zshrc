# Piel's zshrc v1.0 - refactored
# colors {{{1
autoload colors
colors
. $ZDOTDIR/zsh.d/nice_colors.zsh
# path {{{1
PATH=$ZDOTDIR/bin:$PATH
# zsh.d modules {{{1
. $ZDOTDIR/zsh.d/completions.zsh
. $ZDOTDIR/zsh.d/rly.zsh
. $ZDOTDIR/zsh.d/extract.zsh
. $ZDOTDIR/zsh.d/smart_sudo.zsh
. $ZDOTDIR/zsh.d/dirstack.zsh
. $ZDOTDIR/zsh.d/history.zsh
. $ZDOTDIR/zsh.d/history_branching.zsh
. $ZDOTDIR/zsh.d/fast_updir.zsh
. $ZDOTDIR/zsh.d/keychain.zsh
. $ZDOTDIR/zsh.d/marks.zsh
. $ZDOTDIR/zsh.d/sudo_widget.zsh
. $ZDOTDIR/zsh.d/aliases.zsh
# settings {{{1
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
# smart urls {{{2
autoload -U url-quote-magic
zle -N self-insert url-quote-magic
# gpg pinentry {{{2
# I HATE YOU pinentry-curses
# export GPG_TTY=$(tty)
# edit-command-line ftw {{{2
autoload -U edit-command-line
zle -N edit-command-line
bindkey '\C-x\C-e' edit-command-line
# modules (git submodules) {{{1
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
# prompt shit {{{1
. $ZDOTDIR/zsh.d/prompt.zsh
# osx specific {{{1
if [[ "$(uname)" == "Darwin" ]]; then
. $ZDOTDIR/zsh.d/osx.zsh
fi
# modeline {{{1
# vim: fdm=marker:fdl=0
