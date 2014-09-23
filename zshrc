# Piel's zshrc v1.0 - refactored
# colors {{{1
autoload colors
colors
. $ZDOTDIR/zsh.d/nice_colors.zsh
# path {{{1
PATH=$ZDOTDIR/bin:$PATH
# zsh.d modules {{{1
. $ZDOTDIR/zsh.d/aliases.zsh
. $ZDOTDIR/zsh.d/completions.zsh
. $ZDOTDIR/zsh.d/dirstack.zsh
. $ZDOTDIR/zsh.d/extract.zsh
. $ZDOTDIR/zsh.d/fast_updir.zsh
. $ZDOTDIR/zsh.d/history.zsh
. $ZDOTDIR/zsh.d/history_branching.zsh
. $ZDOTDIR/zsh.d/keychain.zsh
. $ZDOTDIR/zsh.d/marks.zsh
. $ZDOTDIR/zsh.d/misc.zsh
. $ZDOTDIR/zsh.d/rly.zsh
. $ZDOTDIR/zsh.d/smart_sudo.zsh
. $ZDOTDIR/zsh.d/sudo_widget.zsh
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
